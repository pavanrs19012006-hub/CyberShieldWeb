
package com.cybershield.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "url_scans")
public class UrlScan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "scan_id")
    private int scanId;

    @Column(name = "user_id", nullable = false)
    private int userId;

    @Column(name = "url", nullable = false, length = 500)
    private String url;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "scan_date", nullable = false)
    private Date scanDate;

    public UrlScan() {
    }

    public int getScanId() {
        return scanId;
    }

    public void setScanId(int scanId) {
        this.scanId = scanId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Date getScanDate() {
        return scanDate;
    }

    public void setScanDate(Date scanDate) {
        this.scanDate = scanDate;
    }
}
