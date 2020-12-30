Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979CE2E75FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 05:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgL3EnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 23:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL3EnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 23:43:07 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8A3C061799
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 20:42:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b5so3094188pjk.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 20:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ygUTwowbaKX+x6PHk7VllklgXsSmDh2V2ziXN2HkbI=;
        b=A3syDYoU5CWZi3JDsiG/XcD+eCTvKVVkOozzOP5qI+hqSthU5t0im0P3KnBDDHOniU
         k3CcBbUTzt5lLS+AdZxXSBwuzvG2bAcaCo/qSmG7oQygFXOGiL9duT/uGYW5QXzvdAWY
         sZygrTmKfOhkI2t1eMH49motPxcTFEiIC4ePrenE8Gx4p6dQo+UM+IpWvu6nn+UeM0tf
         cpe+XKr0VJCFG52JINgf1Wm0gf6va/MB+GYSN/uFhira8JWzAWbDxDYA8FzayIMUGmz9
         mXosmWOotRdh9s/jtsQ7odDEloGIEXaOzLc/ZpaPDDvDUB39Gyv+DNAl3G2l8MYgrHzB
         tA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ygUTwowbaKX+x6PHk7VllklgXsSmDh2V2ziXN2HkbI=;
        b=Q0sb4AoBSG8Kc/yu0NbyXBONVctZruiIDJRZsZ5qNtJiy/aB/fRRBiqym2tsVAZV3Z
         imRqwSLOuahvqnWgS/WCd0Dq8BPZKTEQgr9c9RcbMrPrNj4At5V7OL9eW7ZljpVXViib
         hLs86qG6FTlyYYoAcP5Ur9ar1+lsJwBFgJ0wIF3CWh+bmyFiHcTUhZ7/uIu6qkqPJSCo
         CqDnzn0PU6JqEGgWphqAp3IxavJB4GCxBMbh9PKypBINJBpVYM1/Z3jOysvZlNzB83vX
         x1zL+n1ZrIwEVOJLastf8nhKhNaZRiRVOVQjxhqDhy4YUfm947o9jNBBhWMLssklfAVv
         Kckw==
X-Gm-Message-State: AOAM531b49yQ56yxRkYFDQ/Hw/kzQtxiJpJ8WsbWpOuct3hWB5Osm1Xz
        D2PI9jDNaNVi2G75D0SemqBNpg==
X-Google-Smtp-Source: ABdhPJzHQsFHLv1H0KgreMccuPWSaEx5Jxt3wQEi/rnOsZhOuHBzbYUpLij1sEt5iR7g6OoxUYJu8Q==
X-Received: by 2002:a17:90b:4a0c:: with SMTP id kk12mr6891180pjb.205.1609303345681;
        Tue, 29 Dec 2020 20:42:25 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id v15sm37615077pfn.217.2020.12.29.20.42.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2020 20:42:24 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: arm_mhuv2: Fix sparse warnings
Date:   Wed, 30 Dec 2020 10:12:04 +0530
Message-Id: <db5dd593cfd8b428ce44c1cce7484d887fa5e67c.1609303304.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bunch of sparse warnings in the newly added arm_mhuv2
driver.

drivers/mailbox/arm_mhuv2.c:506:24: warning: incorrect type in argument 1 (different address spaces)
drivers/mailbox/arm_mhuv2.c:506:24:    expected void const volatile [noderef] __iomem *addr
drivers/mailbox/arm_mhuv2.c:506:24:    got unsigned int [usertype] *
drivers/mailbox/arm_mhuv2.c:547:42: warning: incorrect type in argument 2 (different address spaces)
drivers/mailbox/arm_mhuv2.c:547:42:    expected unsigned int [usertype] *reg
drivers/mailbox/arm_mhuv2.c:547:42:    got unsigned int [noderef] __iomem *
drivers/mailbox/arm_mhuv2.c:625:42: warning: incorrect type in argument 2 (different address spaces)
drivers/mailbox/arm_mhuv2.c:625:42:    expected unsigned int [usertype] *reg
drivers/mailbox/arm_mhuv2.c:625:42:    got unsigned int [noderef] __iomem *
drivers/mailbox/arm_mhuv2.c:972:24: warning: dereference of noderef expression
drivers/mailbox/arm_mhuv2.c:973:22: warning: dereference of noderef expression
drivers/mailbox/arm_mhuv2.c:993:25: warning: dereference of noderef expression
drivers/mailbox/arm_mhuv2.c:1026:24: warning: dereference of noderef expression
drivers/mailbox/arm_mhuv2.c:1027:22: warning: dereference of noderef expression
drivers/mailbox/arm_mhuv2.c:1048:17: warning: dereference of noderef expression

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/mailbox/arm_mhuv2.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index 67fb10885bb4..8223c1005254 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -238,19 +238,19 @@ struct mhuv2_mbox_chan_priv {
 };
 
 /* Macro for reading a bitfield within a physically mapped packed struct */
-#define readl_relaxed_bitfield(_regptr, _field)				\
+#define readl_relaxed_bitfield(_regptr, _type, _field)			\
 	({								\
 		u32 _regval;						\
 		_regval = readl_relaxed((_regptr));			\
-		(*(typeof((_regptr)))(&_regval))._field;		\
+		(*(_type *)(&_regval))._field;				\
 	})
 
 /* Macro for writing a bitfield within a physically mapped packed struct */
-#define writel_relaxed_bitfield(_value, _regptr, _field)		\
+#define writel_relaxed_bitfield(_value, _regptr, _type, _field)		\
 	({								\
 		u32 _regval;						\
 		_regval = readl_relaxed(_regptr);			\
-		(*(typeof(_regptr))(&_regval))._field = _value;		\
+		(*(_type *)(&_regval))._field = _value;			\
 		writel_relaxed(_regval, _regptr);			\
 	})
 
@@ -496,7 +496,7 @@ static const struct mhuv2_protocol_ops mhuv2_data_transfer_ops = {
 
 /* Interrupt handlers */
 
-static struct mbox_chan *get_irq_chan_comb(struct mhuv2 *mhu, u32 *reg)
+static struct mbox_chan *get_irq_chan_comb(struct mhuv2 *mhu, u32 __iomem *reg)
 {
 	struct mbox_chan *chans = mhu->mbox.chans;
 	int channel = 0, i, offset = 0, windows, protocol, ch_wn;
@@ -969,8 +969,8 @@ static int mhuv2_tx_init(struct amba_device *adev, struct mhuv2 *mhu,
 	mhu->mbox.ops = &mhuv2_sender_ops;
 	mhu->send = reg;
 
-	mhu->windows = readl_relaxed_bitfield(&mhu->send->mhu_cfg, num_ch);
-	mhu->minor = readl_relaxed_bitfield(&mhu->send->aidr, arch_minor_rev);
+	mhu->windows = readl_relaxed_bitfield(&mhu->send->mhu_cfg, struct mhu_cfg_t, num_ch);
+	mhu->minor = readl_relaxed_bitfield(&mhu->send->aidr, struct aidr_t, arch_minor_rev);
 
 	spin_lock_init(&mhu->doorbell_pending_lock);
 
@@ -990,7 +990,7 @@ static int mhuv2_tx_init(struct amba_device *adev, struct mhuv2 *mhu,
 			mhu->mbox.txdone_poll = false;
 			mhu->irq = adev->irq[0];
 
-			writel_relaxed_bitfield(1, &mhu->send->int_en, chcomb);
+			writel_relaxed_bitfield(1, &mhu->send->int_en, struct int_en_t, chcomb);
 
 			/* Disable all channel interrupts */
 			for (i = 0; i < mhu->windows; i++)
@@ -1023,8 +1023,8 @@ static int mhuv2_rx_init(struct amba_device *adev, struct mhuv2 *mhu,
 	mhu->mbox.ops = &mhuv2_receiver_ops;
 	mhu->recv = reg;
 
-	mhu->windows = readl_relaxed_bitfield(&mhu->recv->mhu_cfg, num_ch);
-	mhu->minor = readl_relaxed_bitfield(&mhu->recv->aidr, arch_minor_rev);
+	mhu->windows = readl_relaxed_bitfield(&mhu->recv->mhu_cfg, struct mhu_cfg_t, num_ch);
+	mhu->minor = readl_relaxed_bitfield(&mhu->recv->aidr, struct aidr_t, arch_minor_rev);
 
 	mhu->irq = adev->irq[0];
 	if (!mhu->irq) {
@@ -1045,7 +1045,7 @@ static int mhuv2_rx_init(struct amba_device *adev, struct mhuv2 *mhu,
 		writel_relaxed(0xFFFFFFFF, &mhu->recv->ch_wn[i].mask_set);
 
 	if (mhu->minor)
-		writel_relaxed_bitfield(1, &mhu->recv->int_en, chcomb);
+		writel_relaxed_bitfield(1, &mhu->recv->int_en, struct int_en_t, chcomb);
 
 	return 0;
 }
-- 
2.25.0.rc1.19.g042ed3e048af

