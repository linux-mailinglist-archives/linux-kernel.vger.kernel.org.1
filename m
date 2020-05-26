Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5EE1D7779
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgERLlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 07:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgERLlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:41:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15108C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:41:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id a13so2566493pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VbJhaAvLm/7HhZgtjqIe1iWgPLvm0UT8AWoz9bkvXtQ=;
        b=Y5bxw+2jHVl/upYZ404mYjQNncJQLYy8IoKs0NolwTK20WNPDR99KSL82UEQr03amL
         SpwDmuv2b47RjabdVoKCKDcF6Mibor4vPFl9FTl+iNLlCu/0PtV5yPAF4qy3SY23oakK
         sLH7e/ht6ZSxlF7uLiaVoLb11oiU36w6wzd7D3uwlDq6W/cBZU5OtdR4MiiN7p0b7082
         3YfyiKSmR4SvVNwSMuluUJkBlDsGot9yP4ToIsCsxLrxj+61srvSxRcyvKOj5mdiYI8k
         HTiVjw8V2Jnc/yEVMgV5uCG5poZeGeN4HYYeI2bZPDwute/rlxFmZbKs4S52ruQo33X6
         2Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VbJhaAvLm/7HhZgtjqIe1iWgPLvm0UT8AWoz9bkvXtQ=;
        b=Ai0GsbhYrndxb1jOlAjbVOdqXtnBgViJkM9W/F0Ef0n3bbGtaETYwDVgLgkDRmxNF5
         7ypFiM5zC5jIWN9DOck2RZW8HzP4GywPiZBmyl04BT7HW/E8IFeoeaZYkSjSbqmKGKDu
         qxsMSXiymHIqhIBknHQCjtGFvaJ/sSo+rerbr9QhrMiIuzyLJniXGzYu3Zam3k4DSWR/
         js7DpKkApXI3fEfcQdkfFAJX2JqTy3P6g7yZEGyw2/2Qyw28DG3k9fWNSo3ez5tmFHNZ
         OYbogQvMWxfOQavuuWNdwFoHx3QktnGOA0bwPjoY6+1MhlM4+XhizHmr8X96EWkGrFnn
         RtyA==
X-Gm-Message-State: AOAM533HURfq6cewANJzXG+TwNuGFIVRX21Sk6Fsf9FMYAtC2wtrB53o
        EZz1F9B35Ioz8BTXsgqIeVV61w==
X-Google-Smtp-Source: ABdhPJwiUAF6xS8J52ol3Q4l7W/WTwov8MV6Dxb9vzOVbeRrhwgPOcI2SoI5Jaipu041OCU7He4xBA==
X-Received: by 2002:a17:902:bd95:: with SMTP id q21mr11981142pls.238.1589802068529;
        Mon, 18 May 2020 04:41:08 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id i10sm8650727pfa.166.2020.05.18.04.41.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 04:41:07 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Expose bandwidth information via debugfs
Date:   Mon, 18 May 2020 17:11:02 +0530
Message-Id: <c2ac269c4fd07059963ab973f9dd40ee869d9f5e.1589802005.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <20200512125327.1868-1-georgi.djakov@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the bandwidth information as well via debugfs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
@Georgi: I am applying this along with your series.

 drivers/interconnect/core.c  | 18 ++++++++++++++++
 drivers/opp/debugfs.c        | 42 ++++++++++++++++++++++++++++++++++++
 include/linux/interconnect.h |  6 ++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 2d2e49780511..a56349c14985 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -514,6 +514,24 @@ void icc_set_tag(struct icc_path *path, u32 tag)
 }
 EXPORT_SYMBOL_GPL(icc_set_tag);
 
+/**
+ * icc_get_name() - Get name of the icc path
+ * @path: reference to the path returned by icc_get()
+ *
+ * This function is used by an interconnect consumer to get the name of the icc
+ * path.
+ *
+ * Returns a valid pointer on success, or NULL otherwise.
+ */
+const char *icc_get_name(struct icc_path *path)
+{
+	if (!path)
+		return NULL;
+
+	return path->name;
+}
+EXPORT_SYMBOL_GPL(icc_get_name);
+
 /**
  * icc_set_bw() - set bandwidth constraints on an interconnect path
  * @path: reference to the path returned by icc_get()
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 609665e339b6..596c185b5dda 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -32,6 +32,47 @@ void opp_debug_remove_one(struct dev_pm_opp *opp)
 	debugfs_remove_recursive(opp->dentry);
 }
 
+static ssize_t bw_name_read(struct file *fp, char __user *userbuf,
+			    size_t count, loff_t *ppos)
+{
+	struct icc_path *path = fp->private_data;
+	char buf[64];
+	int i;
+
+	i = scnprintf(buf, sizeof(buf), "%.62s\n", icc_get_name(path));
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, i);
+}
+
+static const struct file_operations bw_name_fops = {
+	.open = simple_open,
+	.read = bw_name_read,
+	.llseek = default_llseek,
+};
+
+static void opp_debug_create_bw(struct dev_pm_opp *opp,
+				struct opp_table *opp_table,
+				struct dentry *pdentry)
+{
+	struct dentry *d;
+	char name[11];
+	int i;
+
+	for (i = 0; i < opp_table->path_count; i++) {
+		snprintf(name, sizeof(name), "icc-path-%.1d", i);
+
+		/* Create per-path directory */
+		d = debugfs_create_dir(name, pdentry);
+
+		debugfs_create_file("name", S_IRUGO, d, opp_table->paths[i],
+				    &bw_name_fops);
+		debugfs_create_u32("peak_bw", S_IRUGO, d,
+				   &opp->bandwidth[i].peak);
+		debugfs_create_u32("avg_bw", S_IRUGO, d,
+				   &opp->bandwidth[i].avg);
+	}
+}
+
 static void opp_debug_create_supplies(struct dev_pm_opp *opp,
 				      struct opp_table *opp_table,
 				      struct dentry *pdentry)
@@ -94,6 +135,7 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 			     &opp->clock_latency_ns);
 
 	opp_debug_create_supplies(opp, opp_table, d);
+	opp_debug_create_bw(opp, opp_table, d);
 
 	opp->dentry = d;
 }
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 34e97231a6ab..1ad09efd296e 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -32,6 +32,7 @@ struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
 void icc_put(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 void icc_set_tag(struct icc_path *path, u32 tag);
+const char *icc_get_name(struct icc_path *path);
 
 #else
 
@@ -65,6 +66,11 @@ static inline void icc_set_tag(struct icc_path *path, u32 tag)
 {
 }
 
+static inline const char *icc_get_name(struct icc_path *path)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_INTERCONNECT */
 
 #endif /* __LINUX_INTERCONNECT_H */
-- 
2.25.0.rc1.19.g042ed3e048af

