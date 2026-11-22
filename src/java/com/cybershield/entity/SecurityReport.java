
package com.cybershield.entity;

import javax.persistence.*;
import java.util.Date;

@Entity(name = "ManagedSecurityReport")
@Table(name = "security_reports")
public class SecurityReport {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "report_id")
    private int reportId;

    @Column(name = "scan_id", nullable = false)
    private int scanId;

    @Column(name = "report_title", length = 150)
    private String reportTitle;

    @Column(name = "report_summary", columnDefinition = "TEXT")
    private String reportSummary;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "generated_at", insertable = false, updatable = false)
    private Date generatedAt;

    public SecurityReport() {
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getScanId() {
        return scanId;
    }

    public void setScanId(int scanId) {
        this.scanId = scanId;
    }

    public String getReportTitle() {
        return reportTitle;
    }

    public void setReportTitle(String reportTitle) {
        this.reportTitle = reportTitle;
    }

    public String getReportSummary() {
        return reportSummary;
    }

    public void setReportSummary(String reportSummary) {
        this.reportSummary = reportSummary;
    }

    public Date getGeneratedAt() {
        return generatedAt;
    }

    public void setGeneratedAt(Date generatedAt) {
        this.generatedAt = generatedAt;
    }
}
