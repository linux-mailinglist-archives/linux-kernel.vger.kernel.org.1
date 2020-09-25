Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512F0278EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgIYQgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgIYQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:35:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD92C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:35:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so4259330wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kFHi/Lnlt8f1kQDKiGDd11Cptp9H00xnl26W3F/tZaI=;
        b=QftbfSRhc9RJbjqj2FGPZckdcjn/yMYTBEzTjgy3SeATCPxuZswj0/GK4vByczRtu7
         LwkStd+D2xxSr5/g7eU2P8ZDHTc67ZodPKerkMtkO5S3eMRDTdphXErY9xG+GJl9OWwd
         +T60/crKY5Q0DldxVYYyPnOwlIikybVQ7NCtYrsYKbQCugyG4z9dN5o0ZnvHtfTPoXTy
         s7QlaSQsIsx+DzkDS2L/FSPiqQJONOyovX8r47ve+nqSCpHNLHM9ujvSY7+Nqhv2cANL
         d4nj4UY42/ZtFin2Kx5qb3MlP0vgp35WIe8Ii8fr/0HxX8Gm6ksnELcmN/tL6trt7ekZ
         qtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kFHi/Lnlt8f1kQDKiGDd11Cptp9H00xnl26W3F/tZaI=;
        b=MBjlvhwG0knaVslkvy/ga2i/qWiSeQ+z6KxbWjiPqcNd/T4Hy7v/lNuOxI9VVH3bvb
         CCtWQ2woxGUNoLx8fRDeA+TuuEBTOGiWOpaSp9PDqsy6KOiLyDPSgLiuWmm5iAZpPmpC
         c29cz1Xn81M15EIa7U/71mg1uYCZ4vky4yKPc6hcI2pHGdgQvkwgJuzEYchp/LaXogjQ
         9yNm2hf/WtJicwe4r5NSFLGxnZ7R4nPXxq5lWhJ2a4j3V/ktGzqZVaUOM9bWdAL3++3q
         SeOXcrPEco0Wjl3dekeJx3TQS+fH5MXuH3s648EBrqTKoMSXrZP6rAfowMz8usv7D7T6
         jI2Q==
X-Gm-Message-State: AOAM532zxE8KDK8y/oeHo5zHHwsClpLchiTVEw8+IOfqlqyk14PP1B1B
        g0i6n2mmxfXn2a3ChIrKSNpDiQ==
X-Google-Smtp-Source: ABdhPJwDUNZy1TRZ9PrSR+BOSCCszXZM2mAcvg9nXER2+5EpX7pDXX6x3SrXpFgEaorXLaSXqG88bQ==
X-Received: by 2002:adf:8544:: with SMTP id 62mr5416564wrh.262.1601051757907;
        Fri, 25 Sep 2020 09:35:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m4sm3733883wro.18.2020.09.25.09.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 09:35:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/2] ASoC: q6asm: fix kernel doc warnings
Date:   Fri, 25 Sep 2020 17:35:52 +0100
Message-Id: <20200925163552.20717-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925163552.20717-1-srinivas.kandagatla@linaro.org>
References: <20200925163552.20717-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below kernel doc warnings on not describing all the parmeters

sound/soc/qcom/qdsp6/q6asm.c:927: warning: Function parameter or member
 'stream_id' not described in 'q6asm_open_write'
sound/soc/qcom/qdsp6/q6asm.c:927: warning: Function parameter or member
 'is_gapless' not described in 'q6asm_open_write'
sound/soc/qcom/qdsp6/q6asm.c:1053: warning: Function parameter or member
 'stream_id' not described in 'q6asm_run'

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 790abc135223..c547c560cb24 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -915,9 +915,11 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
 /**
  * q6asm_open_write() - Open audio client for writing
  * @ac: audio client pointer
+ * @stream_id: stream id of q6asm session
  * @format: audio sample format
  * @codec_profile: compressed format profile
  * @bits_per_sample: bits per sample
+ * @is_gapless: flag to indicate if this is a gapless stream
  *
  * Return: Will be an negative value on error or zero on success
  */
@@ -1042,6 +1044,7 @@ static int __q6asm_run(struct audio_client *ac, uint32_t stream_id,
  * q6asm_run() - start the audio client
  *
  * @ac: audio client pointer
+ * @stream_id: stream id of q6asm session
  * @flags: flags associated with write
  * @msw_ts: timestamp msw
  * @lsw_ts: timestamp lsw
-- 
2.21.0

