Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41722B9F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 01:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgKTAtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 19:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKTAtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 19:49:50 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E64C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 16:49:50 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id g7so6214287pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 16:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Q+Mp75nfNtK6sDEMyLCAn9ibN5HjWvl6TODH5bfTHM=;
        b=mbTZtbGchTO/Nfp1nQK9phNAZQAkQ3UxGzTamYMVaSTEibuNRP/5jqtj2DV6OpK3jM
         UAgRpels/gxKgJUPbXftL/HXioxwbfp+5btqKIlyXhhl1UqtiNSvewVgvP8Afl/4k/Hi
         LoAzQnNz8MTJDPgwi5Imxrm50/6KEgAAof+kzr6Lo5gBNKEgf1vGSp1AnZQASYlMknXM
         28HXdk2S3f6udbjgyHiz7cB00GDyHQkXjTmZFoyRjlMBOhJ/zfJl79G7E4SnQ2k2YfVq
         rEGkVoNIn0WXp5eP3Jz9EJ1zdulIwhmTrT5FGl1HaJCucTcwMvS70L6ddIR6D3mT8uMz
         MGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2Q+Mp75nfNtK6sDEMyLCAn9ibN5HjWvl6TODH5bfTHM=;
        b=USA3GeokZ68B17tpWOPZSaGk8XPF7LHPKR7DqpwK1PEM1XdIS81bFmNlF1A7hQGkmM
         OXm9Tm5LfcZrL0lFjcdOfBwc+jrt9dkf9SlOocjZ/lubID+o1LsRcPdD5RhPpkkwl6tQ
         rV+HT65YFVwWjdpSdPHstRtJ1FjmcH+tEBpxeq+sEKFfbALkH1KOuG1PrJi3eDvmZk78
         yOnXdYvZgpDv1QbxbP//mAqK5SfX5as464OxiSI3H2vqNokF16j1fzOL6SxAe+J9q8Mc
         XGU+4vGX8Jm7fYJDmNty2EJh+zyYfdN/MPSpDlCV7x8e0gOLzcYpZYYS728JpvR7EZiC
         Dzuw==
X-Gm-Message-State: AOAM531HNIwDu97fRVFPhjSWsWyShulCUS3LHqqgp1kX7CjoRzD5KOwh
        rhZ6m/QnlkXP0ZvN/okM2vI=
X-Google-Smtp-Source: ABdhPJzmMwRA6Z/TuspnzE2mztwaREvUp8ZN1TfsOwjnlMRSOzHMBVPhc77zLs/morRdW6FYuLDZIw==
X-Received: by 2002:a65:4483:: with SMTP id l3mr14680500pgq.96.1605833390301;
        Thu, 19 Nov 2020 16:49:50 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id s4sm1038802pjn.0.2020.11.19.16.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 16:49:49 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Milton Miller <miltonm@us.ibm.com>
Subject: [PATCH] fsi: Aspeed: Add mutex to protect HW access
Date:   Fri, 20 Nov 2020 11:19:29 +1030
Message-Id: <20201120004929.185239-1-joel@jms.id.au>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@linux.ibm.com>

There is nothing to prevent multiple commands being executed
simultaneously. Add a mutex to prevent this.

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Milton Miller <miltonm@us.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---

Hi Greg, can you please merge this.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-master-aspeed.c | 45 +++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index c006ec008a1a..90dbe58ca1ed 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -8,6 +8,7 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -19,6 +20,7 @@
 
 struct fsi_master_aspeed {
 	struct fsi_master	master;
+	struct mutex		lock;	/* protect HW access */
 	struct device		*dev;
 	void __iomem		*base;
 	struct clk		*clk;
@@ -254,6 +256,8 @@ static int aspeed_master_read(struct fsi_master *master, int link,
 	addr |= id << 21;
 	addr += link * FSI_HUB_LINK_SIZE;
 
+	mutex_lock(&aspeed->lock);
+
 	switch (size) {
 	case 1:
 		ret = opb_readb(aspeed, fsi_base + addr, val);
@@ -265,14 +269,14 @@ static int aspeed_master_read(struct fsi_master *master, int link,
 		ret = opb_readl(aspeed, fsi_base + addr, val);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto done;
 	}
 
 	ret = check_errors(aspeed, ret);
-	if (ret)
-		return ret;
-
-	return 0;
+done:
+	mutex_unlock(&aspeed->lock);
+	return ret;
 }
 
 static int aspeed_master_write(struct fsi_master *master, int link,
@@ -287,6 +291,8 @@ static int aspeed_master_write(struct fsi_master *master, int link,
 	addr |= id << 21;
 	addr += link * FSI_HUB_LINK_SIZE;
 
+	mutex_lock(&aspeed->lock);
+
 	switch (size) {
 	case 1:
 		ret = opb_writeb(aspeed, fsi_base + addr, *(u8 *)val);
@@ -298,14 +304,14 @@ static int aspeed_master_write(struct fsi_master *master, int link,
 		ret = opb_writel(aspeed, fsi_base + addr, *(__be32 *)val);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto done;
 	}
 
 	ret = check_errors(aspeed, ret);
-	if (ret)
-		return ret;
-
-	return 0;
+done:
+	mutex_unlock(&aspeed->lock);
+	return ret;
 }
 
 static int aspeed_master_link_enable(struct fsi_master *master, int link,
@@ -320,17 +326,21 @@ static int aspeed_master_link_enable(struct fsi_master *master, int link,
 
 	reg = cpu_to_be32(0x80000000 >> bit);
 
-	if (!enable)
-		return opb_writel(aspeed, ctrl_base + FSI_MCENP0 + (4 * idx),
-				  reg);
+	mutex_lock(&aspeed->lock);
+
+	if (!enable) {
+		ret = opb_writel(aspeed, ctrl_base + FSI_MCENP0 + (4 * idx), reg);
+		goto done;
+	}
 
 	ret = opb_writel(aspeed, ctrl_base + FSI_MSENP0 + (4 * idx), reg);
 	if (ret)
-		return ret;
+		goto done;
 
 	mdelay(FSI_LINK_ENABLE_SETUP_TIME);
-
-	return 0;
+done:
+	mutex_unlock(&aspeed->lock);
+	return ret;
 }
 
 static int aspeed_master_term(struct fsi_master *master, int link, uint8_t id)
@@ -431,9 +441,11 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
 {
 	struct fsi_master_aspeed *aspeed = dev_get_drvdata(dev);
 
+	mutex_lock(&aspeed->lock);
 	gpiod_set_value(aspeed->cfam_reset_gpio, 1);
 	usleep_range(900, 1000);
 	gpiod_set_value(aspeed->cfam_reset_gpio, 0);
+	mutex_unlock(&aspeed->lock);
 
 	return count;
 }
@@ -597,6 +609,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, aspeed);
 
+	mutex_init(&aspeed->lock);
 	aspeed_master_init(aspeed);
 
 	rc = fsi_master_register(&aspeed->master);
-- 
2.29.2

