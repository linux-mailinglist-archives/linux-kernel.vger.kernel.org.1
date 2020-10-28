Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C0D29E172
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgJ1Vth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgJ1VrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0FEC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:47:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so651879wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8jiFD96u1vsSshJT2G6FxWinttPuhbJMDO1vlNStSZQ=;
        b=ue43BboFstD7BslgWL5NP2j9f4R7dBrO0gVxQwM2ZSxZpjgYdygi40RQnisUbZ9cxY
         Mvy9FwvzZt4F8NRUHVF9Fi1adgNvQnrI4G38mpKFGjUJhoxxXCc/R5CLZXzlsJUL6Qg9
         qLyLuhVpB0bvcgrfLHIUrjoWlLsJToZsgxsXhf9X6bcUwgbQJauiPsuev302BrYGKTv6
         30HA7N57KM/dPVmZUqBeJENDnT55rrCqPs4/Pkh9XAauc71W2t+FW8g9hhTX8EkX1Dz9
         yg7p2MdRoVBoKqAf4UnVcehIv4YO9M1pK7Ko658cyHLGGQkOC1p24G8oGwOZ2Anvkvjf
         E4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8jiFD96u1vsSshJT2G6FxWinttPuhbJMDO1vlNStSZQ=;
        b=Yk2YDObugakQf3paFC0TLHa0pNBb5p8r5YLydfodyxNZPgILMCK4pNq7Wk9dzeGHYS
         H1ZJKy9RbBTHLSpkF53fulebLwqEGm/XgLI8UwRcPlDrnjK94g8A3v5RY34miN72vgaa
         1UWzBga3zKVCXQVhUCWQyzjEDPI7glLuMT61anXNb/oJ/0WAVPJ52jOS3TtLPDgcIopf
         qblXH6NYTu7Vr7Bx6jvPFdeB7jW05xWKxvylZWxTYuo6+68VwoO0KZ52/uwpo/I4g2Hv
         hMmkCW5JeQ/xSSSxB4ao1urT1CaUsKUhjt8cK7kgXcx6a6askdPjbHIaTWQH0ULPfRDP
         TC1g==
X-Gm-Message-State: AOAM532E9ZTERyn6sskiQJhEUEeaeimbpOd21IP+gIkeXcBStOjE8FMH
        xvtmBjj/QPsGnjCk9EWLuHLkfF9eEUO3xQ==
X-Google-Smtp-Source: ABdhPJwCNhUQpvs6QaTPF7N+31qqRF0YSXToRPPhMSIZJbIert0f/um74RENbM3UepdhAcEA3MdRQA==
X-Received: by 2002:a05:600c:2041:: with SMTP id p1mr8846861wmg.15.1603899828374;
        Wed, 28 Oct 2020 08:43:48 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u9sm7884114wrp.65.2020.10.28.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:43:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: codecs: wcd934x: Set digital gain range correctly
Date:   Wed, 28 Oct 2020 15:43:39 +0000
Message-Id: <20201028154340.17090-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

digital gain range is -84dB min to 40dB max, however this was not
correctly specified in the range.

Fix this by with correct range!

Fixes: 1cde8b822332 ("ASoC: wcd934x: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 35697b072367..40f682f5dab8 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -551,7 +551,7 @@ struct wcd_iir_filter_ctl {
 	struct soc_bytes_ext bytes_ext;
 };
 
-static const DECLARE_TLV_DB_SCALE(digital_gain, 0, 1, 0);
+static const DECLARE_TLV_DB_SCALE(digital_gain, -8400, 100, -8400);
 static const DECLARE_TLV_DB_SCALE(line_gain, 0, 7, 1);
 static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 25, 1);
 static const DECLARE_TLV_DB_SCALE(ear_pa_gain, 0, 150, 0);
-- 
2.21.0

