Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D19C2D2CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgLHOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbgLHOMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:12:16 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09600C0619DB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:10:49 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y16so19606113ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 06:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ColZvFMxeBX2F8jNmrJL1c8E3SYpy08jyj4gqYNN2Q=;
        b=F/qSEHHimCf8rH5UvNdUHXdgEwBU/rlqYccUOT2bxodbri/gk8Sqdibs2NMzsEAzcO
         4fhuiTBh6X4oPFv+D/gcuFPlTIPxOnCo4aG7Ug774m46ZqCtdh/SpQLhZupl49F9snVP
         NmCHLqUJtiVHRKBdHRKM+2zhZjQq/e0bc+w9x2tYgEAQzp6jMn+B34IavMEOChJn8xIS
         fcJsg60GI2pDYzfwYtgm15jMZ5Bx1KqMBii7Wc6NPAY/c3x6+WED5RWHnluhJ277kGvd
         fI17OZy2hTIKsgJk915wEy8Cm5yboxfD7X3jvKgO+whSRnemVeNclz5Cyb13d6StDetT
         XF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ColZvFMxeBX2F8jNmrJL1c8E3SYpy08jyj4gqYNN2Q=;
        b=CfLaRNNwkLQ8pUNuw45/1gmGrYZU2SnbNbLSOy9TOXL/cVmqiCCFb+GtMjddgCyfTB
         OK9/RnvC2aHJYhVg1dyPsB8SiinXzcBad2W/lVPLojdCr0EYdSvnapOhEogk2T5Lo8DA
         EX9GZ2Uqy247CVDP6RzMJ3AYKYiYlycmAzANQHRQFlglimw6dnxDYIOudlMM6UI2JuP/
         IUJB7A1PN3u7A2aUM7KdX+qII1aoT3EA8kCjGGQFsBP6OdKwvBlsWTBoqmp/2e+l7xnd
         rZs96asG54UrFs6K/n4NHUd5YqeaEeubMDi4COSh2H7/4ZV76/DjEnjAwSdjNo/3sPyF
         nyCw==
X-Gm-Message-State: AOAM531sN7NubaCsEHN7QNIHo3ChHjn1m3sBScr4K8JSFEKa6riXXme+
        Ts5GAUwtOuaj31i1KXi3aP9qgw==
X-Google-Smtp-Source: ABdhPJwqXbavh17S7UTzCBV4act1/virkJITv41YRbvHOFx1U7eHC/c5oyg1pfML1LrsGvfd8ErFug==
X-Received: by 2002:a05:651c:113c:: with SMTP id e28mr2820609ljo.252.1607436647436;
        Tue, 08 Dec 2020 06:10:47 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id h23sm417017ljh.115.2020.12.08.06.10.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:10:46 -0800 (PST)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org, s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, linux-remoteproc@vger.kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, praneeth@ti.com,
        rogerq@ti.com
Subject: [PATCH v4 6/6] remoteproc: pru: Add support for various PRU cores on K3 J721E SoCs
Date:   Tue,  8 Dec 2020 15:10:02 +0100
Message-Id: <20201208141002.17777-7-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201208141002.17777-1-grzegorz.jaszczyk@linaro.org>
References: <20201208141002.17777-1-grzegorz.jaszczyk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The K3 J721E family of SoCs have a revised version of the AM65x ICSSG IP
and contains two instances of this newer ICSSG IP. Each ICSSG processor
subsystem contains 2 primary PRU cores, 2 auxiliary PRU cores called RTUs,
and 2 new auxiliary cores called Transmit PRUs (Tx_PRUs).

Enhance the existing PRU remoteproc driver to support these new PRU
and RTU cores by using specific compatibles. The cores have the same
memory copying limitations as on AM65x, so reuses the custom memcpy
function within the driver's ELF loader implementation. The initial
names for the firmware images for each PRU core are retrieved from
DT nodes, and can be adjusted through sysfs if required.

Signed-off-by: Suman Anna <s-anna@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
v3->v4:
- No changes.

v2->v3:
- Add Reviewed-by: tag
---
 drivers/remoteproc/pru_rproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 421ebbc1c02d..2667919d76b3 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -850,6 +850,9 @@ static const struct of_device_id pru_rproc_match[] = {
 	{ .compatible = "ti,am654-pru",		.data = &k3_pru_data },
 	{ .compatible = "ti,am654-rtu",		.data = &k3_rtu_data },
 	{ .compatible = "ti,am654-tx-pru",	.data = &k3_tx_pru_data },
+	{ .compatible = "ti,j721e-pru",		.data = &k3_pru_data },
+	{ .compatible = "ti,j721e-rtu",		.data = &k3_rtu_data },
+	{ .compatible = "ti,j721e-tx-pru",	.data = &k3_tx_pru_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, pru_rproc_match);
-- 
2.29.0

