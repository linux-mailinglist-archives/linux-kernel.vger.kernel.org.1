Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC521CF4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 14:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgELMyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 08:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729900AbgELMyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:54:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F399C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:54:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so21623883wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b24wWlVcAI5WtF67gfQ7lrjlIMYnj1RJeDLHmrXEYY0=;
        b=Bp9y1iYjiq7ye/soNQOoI0zgGM05UpR/YwVIWWyyEltiDcIOoAGDYxVDyrDRrvoh0O
         daBFFibX2WNQ2n4W5P7mhIcxYCnoHunw/ZHAgIJfRZeNwwKd/+4yY6j2RSUCcAO2oKcG
         SlfmAbhoI/WUOA16HyPwEuIj1qRrpMFdx/6fH+Dv5VKckYOsA70pKQD7sY6ocNbpEILX
         xIEK/cd4VbYgamr0IAvzmZgRzZEWeNyStR5Lyqvf7wpEZ/3sclOwgm73VYOhveGK1FZm
         Ocaj1mJlJ2z1Vu6Fid4ZF3lE7fTtiybksa2rITo9zqBwvMuPmmswX2vTdUeFj+9Na6YF
         ms/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b24wWlVcAI5WtF67gfQ7lrjlIMYnj1RJeDLHmrXEYY0=;
        b=o42Sa86OsQKo14i+5X4htAllCDo+txiNjVjzPBd7p9vn+i2inyeCrdZSTPYBIHxacW
         UAbitQMLEVthkfHQSrQGPdRT8g5Hhfjw+7HoCudHrwLDBb+FapTDWj7r4iBKk7mMWOwO
         s+/OkhzX3YjnE/7AhbVJHCq5+ZyZ42Wg7NxwfZ+9EMlp9Lr+1kTj/5YSkRp4Wj+4Dvaq
         1P1dyzHddxoUnKX2dtVOYHVUqZV+5cDOyXHL+pU6yr4A1C3W+QnhLRg+PjXxQ72D3DW8
         oXn2rWSZWv/3SCs4+oJiu9rkaea9Y6PNAw3+GszL7JXgdKdcOeS1BZnEYdGYjDV6V2kr
         OkSw==
X-Gm-Message-State: AGi0PuYCvFofQGr96I+v/B6qoGB5qhaKMso4yo1WSZbWXEpevpnpN0RM
        CWc6+9c9ZmnoKYS0Emeh12SEZg==
X-Google-Smtp-Source: APiQypImfYB5nyqvxvA2M9l1iE6rJd3+iWflg0lmI06ciJYbhnp3vcBubfm+gyg9hkqNQsFSQpHNSQ==
X-Received: by 2002:a1c:3884:: with SMTP id f126mr39071056wma.91.1589288042966;
        Tue, 12 May 2020 05:54:02 -0700 (PDT)
Received: from localhost.localdomain (212-39-89-66.ip.btc-net.bg. [212.39.89.66])
        by smtp.googlemail.com with ESMTPSA id n13sm2433938wrs.2.2020.05.12.05.54.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 05:54:02 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org
Cc:     robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 05/10] OPP: Add sanity checks in _read_opp_key()
Date:   Tue, 12 May 2020 15:53:22 +0300
Message-Id: <20200512125327.1868-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512125327.1868-1-georgi.djakov@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we read the OPP keys, it would be nice to do some sanity checks
of the values we get from DT and see if they match with the information
that is populated in the OPP table. Let's pass a pointer of the table,
so that we can do some validation.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v8:
* Picked reviewed-by tags.

 drivers/opp/of.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index d139ad8c8f4f..3a64f2aa0f86 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -573,8 +573,8 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
-static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
-			 bool *rate_not_available)
+static int _read_opp_key(struct dev_pm_opp *new_opp, struct opp_table *table,
+			 struct device_node *np, bool *rate_not_available)
 {
 	struct property *peak, *avg;
 	u32 *peak_bw, *avg_bw;
@@ -602,6 +602,12 @@ static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
 		 * opp-avg-kBps = <path1_value path2_value>;
 		 */
 		count = peak->length / sizeof(u32);
+		if (table->path_count != count) {
+			pr_err("%s: Mismatch between opp-peak-kBps and paths (%d %d)\n",
+			       __func__, count, table->path_count);
+			return -EINVAL;
+		}
+
 		peak_bw = kmalloc_array(count, sizeof(*peak_bw), GFP_KERNEL);
 		if (!peak_bw)
 			return -ENOMEM;
@@ -624,6 +630,13 @@ static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
 	avg = of_find_property(np, "opp-avg-kBps", NULL);
 	if (peak && avg) {
 		count = avg->length / sizeof(u32);
+		if (table->path_count != count) {
+			pr_err("%s: Mismatch between opp-avg-kBps and paths (%d %d)\n",
+			       __func__, count, table->path_count);
+			ret = -EINVAL;
+			goto free_peak_bw;
+		}
+
 		avg_bw = kmalloc_array(count, sizeof(*avg_bw), GFP_KERNEL);
 		if (!avg_bw) {
 			ret = -ENOMEM;
@@ -697,7 +710,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (!new_opp)
 		return ERR_PTR(-ENOMEM);
 
-	ret = _read_opp_key(new_opp, np, &rate_not_available);
+	ret = _read_opp_key(new_opp, opp_table, np, &rate_not_available);
 	/* The key is optional for devices like power domains. */
 	if (ret < 0 && !opp_table->is_genpd) {
 		dev_err(dev, "%s: opp key field not found\n", __func__);
