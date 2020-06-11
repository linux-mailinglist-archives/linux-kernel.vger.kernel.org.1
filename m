Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786DD1F67FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 14:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFKMmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 08:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgFKMmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:42:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57353C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:42:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d128so4905212wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lNnQU7nlgCvrEQswoURWL2iF3lzneMUM2jWkpbiMSAc=;
        b=s+lJoAWoRoGJECYvMbW8eS/y8a2BEeRfBiogjqYTcMstMMl7ZBj476aHb5zduSoo24
         DhxTUxmMo+hA8OCL6ST7FXGEwcN948WQv+kRteqTdRgvasABBsCX9HF7QQqDrMATptLd
         d8ilNO/Nry4j3FAsUc63vIcwPGEi3DBOrQRczcS6WzdYa4vJEE6e1tGKRMYMtl1n92U4
         LcZ2WVSXPPVOKlH6VMVJ3G8fqL/x45GHuWv/BomoGUWkx85bCl5KZLi5X7jwd5B4VFK7
         bMuqc2z/GRX283M/5TNBML1rQSYQydNS8wDaOExtL6+0LgD6Pv0QxgVWhuERRDfltuJj
         2j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNnQU7nlgCvrEQswoURWL2iF3lzneMUM2jWkpbiMSAc=;
        b=TnzRwDH0iD6UDM8ccyT7sApp6GQlGeRbfhHosHrfRrkGr84aGCWk/iPVCt52YfrcWG
         QiS3WANwFuzi7aVyKnZ6n8GQn1Q+N2IyZ9pJXcXzBvOmWmYaQvkU4zVyS3n5YKl2TntA
         3EQ3TZPnMzt7hHlQEcxwcOQ50OW++2sjdBiwfHwtembusWyIXuNeTR2BqdPDkR4135x8
         uMIo2XagOgIT6C5HWA8LBJH2lYbauBOw7Q4hKhtCnQQ2NzdsbNkSKY94J2S2tp9iMQvp
         D3DP8lzQo50nu7w+T38MknaO9tj75B/KwksmYjMsVwSogy2t2gGgVfJ21AABxgis6e/o
         xLug==
X-Gm-Message-State: AOAM530/icFLFmfakiqrM+L2i2/6Cv1bUtzDg2HOQQKNS2CvuTH8ibjx
        Gm8avC3aD9go91IvcNWUpZ8WYg==
X-Google-Smtp-Source: ABdhPJz7eRsLXz/F+4yfNMex4BXcCn7ORtYkMIb8eBgCBk6GnfDF2bQvZjqBX4S5IMwWJr37i6aSMg==
X-Received: by 2002:a1c:b386:: with SMTP id c128mr8469524wmf.133.1591879331058;
        Thu, 11 Jun 2020 05:42:11 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q13sm4810355wrn.84.2020.06.11.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:42:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/8] ASoC: q6asm-dai: check available buffer size before sending
Date:   Thu, 11 Jun 2020 13:41:58 +0100
Message-Id: <20200611124159.20742-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
References: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add simple check before sending data buffer to dsp which will
ensure that we are not sending any buffers which are not already available.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 892411f81613..7aba3c07810b 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -534,13 +534,12 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 		prtd->copied_total += bytes_written;
 		snd_compr_fragment_elapsed(substream);
 
-		if (prtd->state != Q6ASM_STREAM_RUNNING) {
+		avail = prtd->bytes_received - prtd->bytes_sent;
+		if (prtd->state != Q6ASM_STREAM_RUNNING || avail <= 0) {
 			spin_unlock_irqrestore(&prtd->lock, flags);
 			break;
 		}
 
-		avail = prtd->bytes_received - prtd->bytes_sent;
-
 		if (avail >= prtd->pcm_count) {
 			q6asm_write_async(prtd->audio_client, prtd->stream_id,
 					   prtd->pcm_count, 0, 0, 0);
-- 
2.21.0

