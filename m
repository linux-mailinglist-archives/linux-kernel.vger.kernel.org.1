Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535E5304F37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404622AbhA0BoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbhAZS5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:57:39 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD34C061354
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:57:13 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id u17so35865509iow.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqgjR1e4tTC1elH7UbXJeMsKuzidjS4eT9TJei8uecI=;
        b=k6QnN9TSLdyknJUo/KYu119xbTnkAKHFsG89MhiaiH7cADfUCdDx2RmvHNSQGiOJUT
         HyK7qPOSPeULD+c/Zng6bGm/0ECGpuISlA0dJwDytBc5DFssm5I956K9T5+YkV08nggU
         xV42BDDsryUg3USHphrzLIM5QcNrXu9ooZ/Z5uEJV+1IW4S1C/MsosebPB85a4+7BygL
         dsWv26EFyqGPzN4UXawp6Ova4xlTRgXSQYEn6VtsM4OjiZSEgfBxa9p1sfbRWSi9gHuu
         BRWjSvNa0PvTJcg1tbQmuTdG700420X6p4ORSKZcsPlCxAeIC/HUtgWFCCC4N+A6J0CB
         WV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqgjR1e4tTC1elH7UbXJeMsKuzidjS4eT9TJei8uecI=;
        b=CX/YP2o3AWbROM03H3D3/5zjcf0AjxR0W8ur9kKurGNmgI+Zs9xak3l7ypfRbuQWLO
         0ZwZz2Gii3c86OK1DBjCilEudFMkQE/F6zaDTxxh5yHhfEXxKc7qk+Vy8B7Lzgp2PZKF
         dzhPOMwJgQKKM+UXShZtcaJOcYh+Y/zhuLwOvLnoIu2LCXaZhl2qrWJurAcavzW9BwKc
         Ht4gT1R6AM+gutkg2WMAwdMZQx16E/tYF26rXpzkqP0rVwEqN17bvnOntPRCLjilj/5e
         CDV1KaFMWv49POeWA5E7+qumjKYLV4jPnYgDxftrUfUVsgQJ15aHYXU7LqZGVxp6mtBV
         4lkw==
X-Gm-Message-State: AOAM530LDT+DRVPvtdG3PlmVk0HaA8bo1jCsm+lqxb3drOGl6uvYy9h7
        b1ZE2lIQxaWOdJ5SXOeelOkWhQ==
X-Google-Smtp-Source: ABdhPJxqDAfXLF53aN4vhnSnwQ+y/EzJvOJmZxd6VWIZr1LzaSJwwNz5uTmJDuh3etTdgLkDEgX2ng==
X-Received: by 2002:a05:6e02:1c8c:: with SMTP id w12mr5569595ill.78.1611687432748;
        Tue, 26 Jan 2021 10:57:12 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id l14sm13060681ilh.58.2021.01.26.10.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:57:12 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/6] net: ipa: don't pass tag value to ipa_cmd_ip_tag_status_add()
Date:   Tue, 26 Jan 2021 12:57:02 -0600
Message-Id: <20210126185703.29087-6-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126185703.29087-1-elder@linaro.org>
References: <20210126185703.29087-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only send a tagged packet from the AP->command TX endpoint when
we're clearing the hardware pipeline.  And when we receive the
tagged packet we don't care what the actual tag value is.

Stop passing a tag value to ipa_cmd_ip_tag_status_add(), and just
encode 0 as the tag sent.  Fix the function that encodes the tag so
it uses the proper byte ordering.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_cmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_cmd.c b/drivers/net/ipa/ipa_cmd.c
index 7df0072bddcce..eb50e7437359a 100644
--- a/drivers/net/ipa/ipa_cmd.c
+++ b/drivers/net/ipa/ipa_cmd.c
@@ -529,7 +529,7 @@ void ipa_cmd_dma_shared_mem_add(struct gsi_trans *trans, u32 offset, u16 size,
 			  direction, opcode);
 }
 
-static void ipa_cmd_ip_tag_status_add(struct gsi_trans *trans, u64 tag)
+static void ipa_cmd_ip_tag_status_add(struct gsi_trans *trans)
 {
 	struct ipa *ipa = container_of(trans->gsi, struct ipa, gsi);
 	enum ipa_cmd_opcode opcode = IPA_CMD_IP_PACKET_TAG_STATUS;
@@ -543,7 +543,7 @@ static void ipa_cmd_ip_tag_status_add(struct gsi_trans *trans, u64 tag)
 	cmd_payload = ipa_cmd_payload_alloc(ipa, &payload_addr);
 	payload = &cmd_payload->ip_packet_tag_status;
 
-	payload->tag = u64_encode_bits(tag, IP_PACKET_TAG_STATUS_TAG_FMASK);
+	payload->tag = le64_encode_bits(0, IP_PACKET_TAG_STATUS_TAG_FMASK);
 
 	gsi_trans_cmd_add(trans, payload, sizeof(*payload), payload_addr,
 			  direction, opcode);
@@ -583,13 +583,13 @@ void ipa_cmd_pipeline_clear_add(struct gsi_trans *trans)
 	 * command says to send the next packet directly to the exception
 	 * endpoint without any other IPA processing.  The tag_status
 	 * command requests that status be generated on completion of
-	 * that transfer, and that it will contain the given tag value.
+	 * that transfer, and that it will be tagged with a value.
 	 * Finally, the transfer command sends a small packet of data
 	 * (instead of a command) using the command endpoint.
 	 */
 	endpoint = ipa->name_map[IPA_ENDPOINT_AP_LAN_RX];
 	ipa_cmd_ip_packet_init_add(trans, endpoint->endpoint_id);
-	ipa_cmd_ip_tag_status_add(trans, 0xcba987654321);
+	ipa_cmd_ip_tag_status_add(trans);
 	ipa_cmd_transfer_add(trans, 4);
 }
 
-- 
2.20.1

