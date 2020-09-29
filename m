Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D00B27D834
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgI2UbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2UbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:31:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D456EC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:31:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so3347046pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6Gs5CgGrT7/dE/0i0Kz33QzSpxebvhL70Kc9W54Bfk=;
        b=FgEC/9TjFwz3LPuu1b3e38wqyfYZXVCqBvGpZ+E6u8Kdp5LeC4QfJscyElLXVW4tfr
         vRBfHkvctRKVaQL7QyBu8BrHU5iDWdwmJ8MaGj4PMgeSw2W1dshGhEBEvFtkHMk9TuHg
         OwbSbd7mZGtr2aB+KZOl8Dyxb+aaZjO5Gzh90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6Gs5CgGrT7/dE/0i0Kz33QzSpxebvhL70Kc9W54Bfk=;
        b=XNtH5Y9QVTsSULUhzoeC0XKOR7L7HUeKR5jCwdJZavkZxbh8jcUsBZFNKhwAYq9znQ
         fsGFz3JKJqbbQHS27joGeoZ/lQ2vWFuQmZZ+GMJs5lfH8ha413h0XhEqcAvgoeR1iOyU
         UyF7U1hMS2PJm+dV1/jtiu0D8w3CgOpX1O7Nsq7RSN1DX5C+7Jt6mT+0NakXoJCoOTdT
         PNzUsQsLIRYPPy95BWXDI5r6dtgklJ3ogOw39jX3utDwv8tqnfZ6Nm6JQpABmAz3RwCu
         +VtFFg2hz1wrDHSffLmEpwwvMxU+zlWc7qENnkohndTfrI/Tb9rxDLn3S7XcAUdC1Kjz
         MMKQ==
X-Gm-Message-State: AOAM530FiuCq3cmjbEa+AzMkFohfJervd9FiLpMo52R16Z3sumGtPOAi
        Zuc4WNhxjcq4pPE93dBm3hR/f0RM+A1ccWxR
X-Google-Smtp-Source: ABdhPJwmrwBwUiVGBgxlOcHDg1VpFJuJtHBMscZT15BqLh6qfbkVr+93YRjl0YskxIVEgWtawk4JCw==
X-Received: by 2002:a17:90a:fb53:: with SMTP id iq19mr5465867pjb.122.1601411465785;
        Tue, 29 Sep 2020 13:31:05 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:a2ce:c8ff:fec4:54a3])
        by smtp.gmail.com with ESMTPSA id j9sm5997167pfc.175.2020.09.29.13.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Sep 2020 13:31:05 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Markus Elfring <elfring@users.sourceforge.net>,
        Evan Green <evgreen@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] soc: qcom: smp2p: Safely acquire spinlock without IRQs
Date:   Tue, 29 Sep 2020 13:30:57 -0700
Message-Id: <20200929133040.RESEND.1.Ideabf6dcdfc577cf39ce3d95b0e4aa1ac8b38f0c@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp2p_update_bits() should disable interrupts when it acquires its
spinlock. This is important because without the _irqsave, a priority
inversion can occur.

This function is called both with interrupts enabled in
qcom_q6v5_request_stop(), and with interrupts disabled in
ipa_smp2p_panic_notifier(). IRQ handling of spinlocks should be
consistent to avoid the panic notifier deadlocking because it's
sitting on the thread that's already got the lock via _request_stop().

Found via lockdep.

Fixes: 50e99641413e7 ("soc: qcom: smp2p: Qualcomm Shared Memory Point to Point")
Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/soc/qcom/smp2p.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 07183d731d747..a9709aae54abb 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -318,15 +318,16 @@ static int qcom_smp2p_inbound_entry(struct qcom_smp2p *smp2p,
 static int smp2p_update_bits(void *data, u32 mask, u32 value)
 {
 	struct smp2p_entry *entry = data;
+	unsigned long flags;
 	u32 orig;
 	u32 val;
 
-	spin_lock(&entry->lock);
+	spin_lock_irqsave(&entry->lock, flags);
 	val = orig = readl(entry->value);
 	val &= ~mask;
 	val |= value;
 	writel(val, entry->value);
-	spin_unlock(&entry->lock);
+	spin_unlock_irqrestore(&entry->lock, flags);
 
 	if (val != orig)
 		qcom_smp2p_kick(entry->smp2p);
-- 
2.26.2

