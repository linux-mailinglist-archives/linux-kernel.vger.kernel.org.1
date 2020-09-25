Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF695278321
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgIYItm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgIYIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:49:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ED3C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:49:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so2661173wrx.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qms1gS4lsjyq2EFAJKsceqVkipGb5r5O0I7UP489Fdo=;
        b=BBP+yI6T825MLog7mvJ2vPGBwhstGthx3TiYbLE+w4tC+KUeJrjlznXJdb2pJGr/eK
         nGCix7rYk/S85var/SyzggRGil9X64GgXXmegH0YJ9B0kkLT0T6Qu9y/gHH1e7tfbrfG
         eK2JtFV44g5y5SWZT+5ZiJG8wXq+oJN23qN5t/xgjABTcJqDpBVg6fpw0whlMCsQitdJ
         9GVlreIwbD94a8srsHqEnEf5Fgr2lSx6gWfaLWxdinjheICfaKyqrf9iv0+9BFouVLt/
         QgiWwgRT6ja5UV5zViXMC0jHqzDGhW0LFcsK2trOEcbmtvoWYYGUSLN/uDtN2JNGN8/W
         Q6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qms1gS4lsjyq2EFAJKsceqVkipGb5r5O0I7UP489Fdo=;
        b=Qumyb/JidWCH3hrsa08qHpYNvXmecBMsqwaEtjwEsjBgbNkWFlGiUAwr0nBTAgwrau
         isEA2BPAfeqQrbY97pM2KC3khL35fGDSN+TjaAF7mCWiwRdFtCybaQd97Pz6Be5p5wIU
         edJ9S5+xZMZl2+2/htykrPiNTdgbzrf8UFWXUhTYSn26avVOn6ZhLMBl7hbwgDwm+S1F
         FKsnZ7+JxR7nQREKc4M6I97EHuBB39lLXPED3r/LSOD8mh/vybTID0PsXh2aHGpxpweT
         w1X4cdoC/qzcRJbx3rK0LOvbJf7zpMUjuQuSje0nmuJz28Yu3wRNvbpXLxrPXMyOvsak
         GMYw==
X-Gm-Message-State: AOAM532yvAQG7iVYk21VWgIN5TRMd+c+280I3edvBds9ayD7wW+LtDei
        Ats1/qWPrugiwhcoRusKlxg8tA==
X-Google-Smtp-Source: ABdhPJxLFlslsmO+Ox1jM3w42tqn00wRtzs/jJ3tbNAy+X7g7nDVd+oB16s/z79eu4Gd5JZTqB+V+w==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr3159750wrs.281.1601023776824;
        Fri, 25 Sep 2020 01:49:36 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u66sm2048623wme.12.2020.09.25.01.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 01:49:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: q6asm: fix kernel doc warnings
Date:   Fri, 25 Sep 2020 09:49:25 +0100
Message-Id: <20200925084925.26926-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
References: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
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
index 34a6e894242e..91999c9f016c 100644
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

