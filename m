Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286C327B79C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgI1XNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgI1XNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:13:42 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FD7C05BD0F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:04:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u19so2929488ion.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dm8XS2HSKEv02T22veiY2AtisIW8U/KWf00I2CNm2Oc=;
        b=Vp+hMh1DoiUYSZXD9dySKybdalCByzNL+2dPjcj6W7Am1qGkOg1mrWaKskhQEWETJf
         v+aSj/h0pr6Bf0pRRomB90IByKSIoDsHdd+NTsn0f6bLbl+JrcZ3Sfp4z+O+3dInjZjp
         1DjPKVx45SPvW7qzTUPBGHrzw4J0GZUwtsgDGVoWeaKhcpziGXP5sRwZDWH7aa9boi3m
         lg/qC2e+OTGLw4q2eGnfZ3w8xgUA/CFMT0zE5FBML7L5qDPG4m42FR9NbRGMyOJzSOuK
         NMxzDMsxnaKS7Na9obbZi/cAO+dPqSACgXzoMYyToNZ615gwhCyH47Bd+sifqAVLOnO5
         JKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dm8XS2HSKEv02T22veiY2AtisIW8U/KWf00I2CNm2Oc=;
        b=rQsGz+i9sazQn8dti/IcwuzYGZnqtGhgRapI3NnRjqZP1bxrMrqBP6fXZce8NomAoF
         QC1aQs0dCAzBMZhSEiH2CrhqJrULC2aHceVphAY6wH5NNm5IjN/Ll7ZT55PSjs/ISLRD
         jurr6zlReH2d1it5zkOkSnzwCK0UE0e9WTOCoNfMzP8ET4K9lOE71Swf9im2KhM31187
         /1wmrGdrMgm9nr6Cyrq2+KiUQkZsiGictg+7WYxKn1kZbV5DzGGedRVSsNxDIckhMKZZ
         5kR8HYv7ng3k6/AfiiXVSdkQx/c2nTJaYRSUEoLejpVpiONxgwoYBUu+BCD8k/J7J61b
         siSg==
X-Gm-Message-State: AOAM532KQ+ZgTd1ESXf8Rc6znpJE9dqDxCpHidVKXcHa47T9qy2Ve4FK
        bB3RmWywjR/iLaAZRofvchbKsQ==
X-Google-Smtp-Source: ABdhPJxwlEnNX6WziSND5XDadBAq7e+9AzVId1LMRU/SL9DrOge0DxF36SE2K647M2SxhGavMXGalg==
X-Received: by 2002:a05:6602:21cc:: with SMTP id c12mr385935ioc.81.1601334293133;
        Mon, 28 Sep 2020 16:04:53 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id 137sm1009039ioc.20.2020.09.28.16.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 16:04:52 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 03/10] net: ipa: kill unused status exceptions
Date:   Mon, 28 Sep 2020 18:04:39 -0500
Message-Id: <20200928230446.20561-4-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200928230446.20561-1-elder@linaro.org>
References: <20200928230446.20561-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the deaggregation status exception type is ever actually used.
If any other status exception type is reported we basically ignore
it, and consume the packet.  Remove the unused definitions of status
exception type symbols; they can be added back when we actually
handle them.

Separately, two consecutive if statements test the same condition
near the top of ipa_endpoint_suspend_one().  Instead, use a single
test with a block that combines the previously-separate lines of
code.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index e5e64ca244cbd..df7cd791bb408 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -51,13 +51,6 @@ enum ipa_status_opcode {
 enum ipa_status_exception {
 	/* 0 means no exception */
 	IPA_STATUS_EXCEPTION_DEAGGR		= 0x01,
-	IPA_STATUS_EXCEPTION_IPTYPE		= 0x04,
-	IPA_STATUS_EXCEPTION_PACKET_LENGTH	= 0x08,
-	IPA_STATUS_EXCEPTION_FRAG_RULE_MISS	= 0x10,
-	IPA_STATUS_EXCEPTION_SW_FILT		= 0x20,
-	/* The meaning of the next value depends on whether the IP version */
-	IPA_STATUS_EXCEPTION_NAT		= 0x40,		/* IPv4 */
-	IPA_STATUS_EXCEPTION_IPV6CT		= IPA_STATUS_EXCEPTION_NAT,
 };
 
 /* Status element provided by hardware */
@@ -1082,7 +1075,7 @@ static bool ipa_status_drop_packet(const struct ipa_status *status)
 {
 	u32 val;
 
-	/* Deaggregation exceptions we drop; others we consume */
+	/* Deaggregation exceptions we drop; all other types we consume */
 	if (status->exception)
 		return status->exception == IPA_STATUS_EXCEPTION_DEAGGR;
 
@@ -1428,11 +1421,10 @@ void ipa_endpoint_suspend_one(struct ipa_endpoint *endpoint)
 	if (!(endpoint->ipa->enabled & BIT(endpoint->endpoint_id)))
 		return;
 
-	if (!endpoint->toward_ipa)
+	if (!endpoint->toward_ipa) {
 		ipa_endpoint_replenish_disable(endpoint);
-
-	if (!endpoint->toward_ipa)
 		(void)ipa_endpoint_program_suspend(endpoint, true);
+	}
 
 	/* IPA v3.5.1 doesn't use channel stop for suspend */
 	stop_channel = endpoint->ipa->version != IPA_VERSION_3_5_1;
-- 
2.20.1

