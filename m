Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA9E2AA86C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 00:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgKGXgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 18:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKGXgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 18:36:39 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F20C0613CF;
        Sat,  7 Nov 2020 15:36:39 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id w142so139561lff.8;
        Sat, 07 Nov 2020 15:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Km/iLKNq6GfA8OVAobsaReSVv5m0TkV1fWK6/2swUyA=;
        b=uhEhwp3gUa//+ITtT6SmNHrpssFmZeLzebu6HH0fkCI8B3wS25i9RYtF3gVKAZsRxE
         RfQq8GdLOa+akBfNWYTB+llDvtmktyrQ/44bNejKIx9hIjY72W2GFuyjbKkpkZ6SaPwx
         lBC1e0HA8rqQErBXTi5u6nEvi5yGBbXmH2U8s/NoJFK+ybI54R3fSKrKDmyTx67qzfCn
         4RbUGriEp73g+4ttVPFd7ecFojylv5hNfS6lmob+sElDtqsR8cKBLTqovTWMD2kKUBUH
         2+yds+aLOMlLxoyup7o5OMw0+NFG7veufQU43zlovIitXzUlN/zQxFwZCNcnTlvE3c4w
         uBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Km/iLKNq6GfA8OVAobsaReSVv5m0TkV1fWK6/2swUyA=;
        b=WQ/k1KyASilCw8LnUxzhDQYbTWMU9H16MZAokzqKctbhiYUsuVrbtfJYZzgAdTyKyv
         k6QxaANBeRXZQnu4H0hypH/kulFaw4Gwh62Q40MJtoXxBaLzs78Mqj3PzFaW4lgXjs6f
         0BO2Z4uYZCeIP1aU2QBX/edICWmZKwEAXf9fkgTstbTsopehQ8+DfcudkUhqWWgvkcYg
         hK7K9cPwjyxmGd3eY+dA5HwKDJ3hi47gXi3v+Zt2WUwzkXZT6Rm/K+J6EWXBcwFIgEc2
         EJMqmHaCq6kPZHMpTFT6cQW6eXHBRHmRGeAQdTWkZyEm1zW7pTSnwO5rku1Q0IN78uYm
         z+hw==
X-Gm-Message-State: AOAM531O55EiQ3HqVajMHLSnMRrfjx87OkYSyHpnwIUGGdOAtKL9PV8c
        c++8Y3ywLx8c5rwnJMSoMUM=
X-Google-Smtp-Source: ABdhPJxcClE9aESERDjjGC0k+h8RTuUSmTxDHg6SFBwd0PG+QcwfCbe/FMBRxWrDiovawbmYjEBDvg==
X-Received: by 2002:a19:e57:: with SMTP id 84mr1208005lfo.349.1604792197680;
        Sat, 07 Nov 2020 15:36:37 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-112.NA.cust.bahnhof.se. [155.4.221.112])
        by smtp.gmail.com with ESMTPSA id j23sm782772lfm.16.2020.11.07.15.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 15:36:37 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/2] remoteproc: ingenic: Constify ingenic_rproc_ops
Date:   Sun,  8 Nov 2020 00:36:29 +0100
Message-Id: <20201107233630.9728-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201107233630.9728-1-rikard.falkeborn@gmail.com>
References: <20201107233630.9728-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of ingenic_rproc_ops is to pass its address to
devm_rproc_alloc(), which accepts a const pointer. Make it const to
allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/remoteproc/ingenic_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ingenic_rproc.c b/drivers/remoteproc/ingenic_rproc.c
index 1c2b21a5d178..26e19e6143b7 100644
--- a/drivers/remoteproc/ingenic_rproc.c
+++ b/drivers/remoteproc/ingenic_rproc.c
@@ -135,7 +135,7 @@ static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
 	return (__force void *)va;
 }
 
-static struct rproc_ops ingenic_rproc_ops = {
+static const struct rproc_ops ingenic_rproc_ops = {
 	.prepare = ingenic_rproc_prepare,
 	.unprepare = ingenic_rproc_unprepare,
 	.start = ingenic_rproc_start,
-- 
2.29.2

