
package com.cybershield.entity;

import javax.persistence.*;

@Entity
@Table(name = "threat_results")
public class ThreatResult {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "threat_id")
    private int threatId;

    @Column(name = "scan_id", nullable = false)
    private int scanId;

    @Column(name = "threat_type", length = 100)
    private String threatType;

    @Column(name = "risk_level", length = 20)
    private String riskLevel;

    @Column(name = "status", length = 50)
    private String status;

    public ThreatResult() {
    }

    public int getThreatId() {
        return threatId;
    }

    public void setThreatId(int threatId) {
        this.threatId = threatId;
    }

    public int getScanId() {
        return scanId;
    }

    public void setScanId(int scanId) {
        this.scanId = scanId;
    }

    public String getThreatType() {
        return threatType;
    }

    public void setThreatType(String threatType) {
        this.threatType = threatType;
    }

    public String getRiskLevel() {
        return riskLevel;
    }

    public void setRiskLevel(String riskLevel) {
        this.riskLevel = riskLevel;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
