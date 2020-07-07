Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E1B21741E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 18:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgGGQgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 12:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:36:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAD6C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:36:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so43476915wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eXFmux5X1whu1JBdcynlDddC5+sJq/4aA7zZPxnTZOA=;
        b=uLrJ/B+zL3ZjyzHkLvOuGvamrzrBzDHge6qjBz/hFLcTSxqdbrcuzOcLI+n8bLwE2f
         TZBi7a3z8Oj81fJyTn6QjU8mpe/0mz0GyxyFfPXRsWAiRMCLnAtkgb8sAxnn+2iNIJWI
         WfkBlPRU3WhTZgGKvanFhJstFplDxkrjAzhsanUcgaYsqhPxZx1xN8NsONZSvXx2uqi/
         UbtJtTNv7Bo43yJ/Z8wMZG0vccKp0XnQklb4ab9ZZKRvBsug4azlvVWNTz0VjK7p4Djg
         xwPe24SOwRLtWXtyDp8syBrAA01me3ase+Do2AlKkp4L7PMVR5GHA56hSPNZC6iCQa2C
         yy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eXFmux5X1whu1JBdcynlDddC5+sJq/4aA7zZPxnTZOA=;
        b=IFzGMWLmXXMuxQ92RDP+pltZFZzFnK9Z+0AzwHuK6tYCRAzh/JbxFZjc3jIcAlbxX9
         pL4VELDpuQa8vq1gJoQxs6SJNhSNP3vayDABCcOApcz9Brj++SsPv68+k2RJfq7CDO/A
         NCK1xVIrSH0IXUrcq2EzH7a0FktmVTI3+hjxepAkR0N6X2e3aV4JfhH4nmj62gjBFj/A
         rX2xQ/H8qKn0+s8lYIW34oCzF7+9pi3Q+W7gItLgWwGxyUoieevE1lZ8vVBgrKktQTYM
         Ovdps9cufQNEeLK8LOWFxKEzO7C6YAPysjLHaMIZjAeVaYAXMO3gzM6ovMhfD32M913c
         zQpQ==
X-Gm-Message-State: AOAM532Slq11rtw6Uzz2Ithv60f/2Wf4ibQnCdjYi1/DweRw1v7H4j6n
        muHG7wwCyyTc9phy62U1jq3+EQ==
X-Google-Smtp-Source: ABdhPJwQUC2lPy1B1jfVkVhjQrvBloYN9Zm6x0E4go8cfkV/wUheZl/QcmCcBOwbz/t4/v0q0FPbBw==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr52303665wrs.270.1594139810886;
        Tue, 07 Jul 2020 09:36:50 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p14sm1925874wrj.14.2020.07.07.09.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 09:36:50 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/11] ASoC: q6asm: add command opcode to timeout error report
Date:   Tue,  7 Jul 2020 17:36:31 +0100
Message-Id: <20200707163641.17113-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the error reporting more useful by adding opcode to it.
Without this its almost impossible to say which command actually
timed out.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index ae4b2cabdf2d..e0983970cba9 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -311,7 +311,7 @@ static int q6asm_apr_send_session_pkt(struct q6asm *a, struct audio_client *ac,
 					5 * HZ);
 
 	if (!rc) {
-		dev_err(a->dev, "CMD timeout\n");
+		dev_err(a->dev, "CMD %x timeout\n", hdr->opcode);
 		rc = -ETIMEDOUT;
 	} else if (ac->result.status > 0) {
 		dev_err(a->dev, "DSP returned error[%x]\n",
@@ -891,7 +891,7 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
 	rc = wait_event_timeout(ac->cmd_wait,
 				(ac->result.opcode == hdr->opcode), 5 * HZ);
 	if (!rc) {
-		dev_err(ac->dev, "CMD timeout\n");
+		dev_err(ac->dev, "CMD %x timeout\n", hdr->opcode);
 		rc =  -ETIMEDOUT;
 		goto err;
 	}
-- 
2.21.0

