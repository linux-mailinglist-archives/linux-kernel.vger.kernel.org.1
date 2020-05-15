Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03271D5A63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 21:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgEOTwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 15:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726212AbgEOTwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:52:10 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4C6C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:52:09 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v4so3057599qte.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3XvVWlcABe+G1BQ6kr2b41L/KK5+KHFkpsP1sIPAus=;
        b=Lm6SPwXJctKfqb3iymt0usIPWefut4rllvwu0BRFgI1lzCOR3b+LxHsNOV5t6U38li
         /W3htFZSZkCHnKZJJe9WCsXxYWyZEdFxcxBCl1FLBmqbZDif59dizshvNDz5dJkZnFQY
         ivjcYRVu8cMkuaUAlq0VGpZfwVNlrLSaXliKhlHkymFTJ8cRbq+XRNMatueVdIh2FEo1
         bTFeQ1Wdem6gwqVQ+fAIL7mBfsf8XrPxo5NtmMYa6N2LfVUcmL27koewlyN8SKyLWt0O
         diqz6jNfgx4effk+AkpMOAZGULf0lEjfroImkVyUOpU4fYVOciMEhd2iwvZAR3Iukzhy
         Bmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3XvVWlcABe+G1BQ6kr2b41L/KK5+KHFkpsP1sIPAus=;
        b=nPMGQOUYbxZXPv0Ij9yyCsnIoGWF/1mi24/Y+Htd70DRlsPkT0smzLhrSoJF/amiPc
         h0uF9GskHZF3OcesEMIzZkfCpj4w9umlRM3aIVWazmoyYyPW4FB/eaEmyltBWcrRci7k
         OUXn3tLyBJvD2ZVFXk79Vx11NYoVzb8hZebRlHzdG7Dbe9XXMKVxxaskhdJRbKq0zOJ4
         H46u+Vd7dF1J0HcFoXlqvxjBl/7QpusjR96XApjeW1KLaca2JYjU0NxRd5bSiIobgZ4S
         I8bBNkAVsYNlg/p2wqqbgU/qz7A0UsnNkR0aIgR1rpiFsVvAk4W6SWAphI2bN5xzr6aI
         IOfQ==
X-Gm-Message-State: AOAM530RltoA4r9hPsYRyeEYa16E09pFj+LOZN10xGZ8+glTKM3xQNmR
        0cuosQiHb9/WlivS7ssCYETzIg==
X-Google-Smtp-Source: ABdhPJyPQo9XbHdCgbpnOxJu14HVKuo3dzqO0iETAcDpo6pM/yJUgHJF2MXbR8nDh1h4cOHANg/gcQ==
X-Received: by 2002:ac8:3f5d:: with SMTP id w29mr5315022qtk.192.1589572328247;
        Fri, 15 May 2020 12:52:08 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z50sm2943704qta.18.2020.05.15.12.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 12:52:07 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sharath Chandra Vurukala <sharathv@codeaurora.com>
Subject: [PATCH net 1/1] net: ipa: don't be a hog in gsi_channel_poll()
Date:   Fri, 15 May 2020 14:52:03 -0500
Message-Id: <20200515195203.24947-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iteration count value used in gsi_channel_poll() is intended to
limit poll iterations to the budget supplied as an argument.  But
it's never updated.

Fix this bug by incrementing the count each time through the loop.

Reported-by: Sharath Chandra Vurukala <sharathv@codeaurora.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index b671bea0aa7c..8d9ca1c335e8 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1392,6 +1392,7 @@ static int gsi_channel_poll(struct napi_struct *napi, int budget)
 	while (count < budget) {
 		struct gsi_trans *trans;
 
+		count++;
 		trans = gsi_channel_poll_one(channel);
 		if (!trans)
 			break;
-- 
2.20.1

