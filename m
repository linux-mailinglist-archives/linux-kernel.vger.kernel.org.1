Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE6420E419
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 00:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbgF2VVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 17:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390654AbgF2VUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:20:44 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE786C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:20:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so2615690iln.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikmoMwgWrI1HSTvIu3OsRZsmkzSggb5efR8I4lGwKfU=;
        b=sNLU/2+B0nxI/itWKc1EQzh6GK7KMZMGj5NLUcnvhUyQrjoZJUGpniCudLZIxJRNH6
         lu6+5OQe+k6rqJZ1/QFthfraObsnIne4IodPSIBP05ya0avWoVWlC85uVgbF2DzYo6eK
         ZZucb9PINrN62vWvBTLNTRqpmIeyx5BVy2PKB+Xoipglj1h7B3SZshMox+7qySHR2N5H
         XMjGf4qMiAd2WR8jXGaee1sSeSzEQ7Diyzhm1Jg5n2fHjGD3I8VSFpdPBMaszoT2OW1c
         bXlVYGy3kcIsLw2YMc999fZ9kWiT9JUAAJSO22+X8FmWmDdqDkKpbPLd9TezaY7+nS0D
         +apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikmoMwgWrI1HSTvIu3OsRZsmkzSggb5efR8I4lGwKfU=;
        b=FPJfB1yWKWoXCd2xixXgtdzJg+YMqLDBjZTSa2xuCzPh37t5EqpZEh68AajoNloZjv
         G3hNO3n6YEI7JsC6TX1Jo3WKNwtbzXnrd/oi6RYmvidLn3x4qZAwU9fpYqKPUizWf28E
         8fUsrThRJcMpNJI0tGWOyMDwT6wKf3dOGo8MDSYsCk2Xhyqfg+vz0qa6wcya58Kmy5iz
         TjTHDDEYnmPCGinDJryIfONoVWL+z/eaZvFUZwr2xlJ27iuJdB8+IGwduAvoCJjJWtt7
         K7ZDXW2lQaCd9QSeIU79NsPT39OC0Qe2lwlkCALP5Yc/m15u+xnlv0xFbvamk6X1LSxN
         PhNQ==
X-Gm-Message-State: AOAM533GnZ4uQRc6VAKXqBoj/NSNwVOu6Y2B3/lecwFAN/xIjfMQIvDV
        fivqErzBpH1MzLMzloZ0aDsfHw==
X-Google-Smtp-Source: ABdhPJzaAN/WcKfob045owqNeJnOq0QdhsRI7nvnbKBceIkYWSW5Vf6REkPoEjNAFbKHvMTEj0l51w==
X-Received: by 2002:a92:d843:: with SMTP id h3mr18802430ilq.255.1593465644108;
        Mon, 29 Jun 2020 14:20:44 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f18sm564588ilj.15.2020.06.29.14.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:20:43 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: ipa: no checksum offload for SDM845 LAN RX
Date:   Mon, 29 Jun 2020 16:20:37 -0500
Message-Id: <20200629212038.1153054-3-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629212038.1153054-1-elder@linaro.org>
References: <20200629212038.1153054-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AP LAN RX endpoint should not have download checksum offload
enabled.

The receive handler does properly accomodate the trailer that's
added by the hardware, but we ignore it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-sdm845.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index 52d4b84e0dac..de2768d71ab5 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -44,7 +44,6 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		.endpoint = {
 			.seq_type	= IPA_SEQ_INVALID,
 			.config = {
-				.checksum	= true,
 				.aggregation	= true,
 				.status_enable	= true,
 				.rx = {
-- 
2.25.1

