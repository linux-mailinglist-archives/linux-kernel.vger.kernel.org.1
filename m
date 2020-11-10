Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D072AE24C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbgKJV7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbgKJV7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:59:30 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1BAC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:59:29 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id k1so20409ilc.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3n+KuGGWOwtr6gyDragDVV6mH7NQ4XmxKx3ZS3TxMI=;
        b=vuwiPZ5GLNF1JgdQBQNw5wsDre1BG8rhDeXZpeUmzggiwb5SL2q20ujg0QluCbMSPZ
         B/7VgDtYjAypBUdbFIehhvIaED4OmJNc46/e1IU5IyJ18RdUCHF38sjb1+yyIxAmmwVu
         X1tnlOO/k3AhIllmXu5lMTyZ/rqmx3ujvMmIWeZEwxS4nY6I81bKv7o7nU7d6KJi5V6C
         nRezcHpOQ8cH/geFrLt4xlUrXHOGpxZUtlVh6nohJbuz4BKcmVqB6HjpHzQoj/ocomh7
         /cTeC2KIjtFrsCh5MGBpNXxHB4SFo1mEhThREs20jkUUZhdqi/UzPih1HWlFoE9OUPGk
         QKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3n+KuGGWOwtr6gyDragDVV6mH7NQ4XmxKx3ZS3TxMI=;
        b=ctBIY0xYGy3uG8gz3QV8keO5HLeEKrJSu0GwkjsDA0QQ9MQxjREs+4P533MWGmRN5C
         XerZlkD+MxmDF91SImWejC054x+F/gaIUgGM8ZyVRRBBQYd3Y/tG+WQOJg7kOhBMWYQn
         bwAAFmWkvW737PMqhmVwJ0PD0tlfjDgcNzKZXOD/mw+sl+Iuv9pEw4Oelz1odAyyqdgy
         sXQqKrZ4QLg2/ErwwELWZGbOio7mwMK+H5/iPtxr3vfrbqXLzMPiu6exNr4y9qKatxsv
         fbFpTsbxEYtlwO0ws/I6EjylL94Dyo2pfTMcyI6vqHEUVXMc1PjcM4qdEbPckDYpEI0H
         Au9g==
X-Gm-Message-State: AOAM533laM7IrlOIK86XktOAYCf00iE67rcBDhbOwaGKrF/HgoimlPI5
        jZnMhC/OCGvR7pJ3IY/u8OXvvWUzeQB/eJ+/
X-Google-Smtp-Source: ABdhPJxJ8E7G2VJkxgSrzXNAc5jlkEm2DZjXsqJ5fZrEQbtDHEqLE2BiFyopL3kQ6X48nll98ZaaGg==
X-Received: by 2002:a92:d688:: with SMTP id p8mr14564989iln.183.1605045568895;
        Tue, 10 Nov 2020 13:59:28 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id d142sm102010iof.43.2020.11.10.13.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:59:28 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/6] net: ipa: use common value for channel type and protocol
Date:   Tue, 10 Nov 2020 15:59:18 -0600
Message-Id: <20201110215922.23514-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201110215922.23514-1-elder@linaro.org>
References: <20201110215922.23514-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The numeric values that represent the event ring channel type are
identical to the values that represent the matching protocol used
for a channel.  Use a new gsi_channel_type enumerated type to
represent the values programmed for both cases, using "CHANNEL_TYPE"
in member names in place of "EVT_CHTYPE" and "CHANNEL_PROTOCOL".

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 273529b69d39c..8b476e51ab78e 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -127,20 +127,12 @@ enum gsi_err_type {
 	GSI_ERR_TYPE_EVT	= 0x3,
 };
 
-/* Hardware values used when programming an event ring */
-enum gsi_evt_chtype {
-	GSI_EVT_CHTYPE_MHI_EV	= 0x0,
-	GSI_EVT_CHTYPE_XHCI_EV	= 0x1,
-	GSI_EVT_CHTYPE_GPI_EV	= 0x2,
-	GSI_EVT_CHTYPE_XDCI_EV	= 0x3,
-};
-
-/* Hardware values used when programming a channel */
-enum gsi_channel_protocol {
-	GSI_CHANNEL_PROTOCOL_MHI	= 0x0,
-	GSI_CHANNEL_PROTOCOL_XHCI	= 0x1,
-	GSI_CHANNEL_PROTOCOL_GPI	= 0x2,
-	GSI_CHANNEL_PROTOCOL_XDCI	= 0x3,
+/* Hardware values used when programming a channel or event ring type */
+enum gsi_channel_type {
+	GSI_CHANNEL_TYPE_MHI			= 0x0,
+	GSI_CHANNEL_TYPE_XHCI			= 0x1,
+	GSI_CHANNEL_TYPE_GPI			= 0x2,
+	GSI_CHANNEL_TYPE_XDCI			= 0x3,
 };
 
 /* Hardware values representing an event ring immediate command opcode */
@@ -684,7 +676,8 @@ static void gsi_evt_ring_program(struct gsi *gsi, u32 evt_ring_id)
 	size_t size = evt_ring->ring.count * GSI_RING_ELEMENT_SIZE;
 	u32 val;
 
-	val = u32_encode_bits(GSI_EVT_CHTYPE_GPI_EV, EV_CHTYPE_FMASK);
+	/* We program all event rings as GPI type/protocol */
+	val = u32_encode_bits(GSI_CHANNEL_TYPE_GPI, EV_CHTYPE_FMASK);
 	val |= EV_INTYPE_FMASK;
 	val |= u32_encode_bits(GSI_RING_ELEMENT_SIZE, EV_ELEMENT_SIZE_FMASK);
 	iowrite32(val, gsi->virt + GSI_EV_CH_E_CNTXT_0_OFFSET(evt_ring_id));
@@ -791,8 +784,8 @@ static void gsi_channel_program(struct gsi_channel *channel, bool doorbell)
 	/* Arbitrarily pick TRE 0 as the first channel element to use */
 	channel->tre_ring.index = 0;
 
-	/* We program all channels to use GPI protocol */
-	val = u32_encode_bits(GSI_CHANNEL_PROTOCOL_GPI, CHTYPE_PROTOCOL_FMASK);
+	/* We program all channels as GPI type/protocol */
+	val = u32_encode_bits(GSI_CHANNEL_TYPE_GPI, CHTYPE_PROTOCOL_FMASK);
 	if (channel->toward_ipa)
 		val |= CHTYPE_DIR_FMASK;
 	val |= u32_encode_bits(channel->evt_ring_id, ERINDEX_FMASK);
-- 
2.20.1

