Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7D529D97E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389831AbgJ1Wzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389797AbgJ1Wz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:55:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE0AC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:55:27 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d3so773156wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctzgjv+NmABx1Kt3m2tDVwm2LGH0KuiBAUYDbPhDv1Q=;
        b=gV58zQ7bh4+ztDSwyh2p5Aqif/Pag750BWBT8Py2nSDCISM6Unz+z27j16xVcBQbNE
         hjvcViqHWR/L7BtIkZnthPnJ2CJ6z3qgAEMLUtU2lIElxal1mAqnniCxVHx3+ElDsMxO
         jANfc2MOEaSJ4xP5hR7BtOpiSyOoKBayf4UxlRj7G4gqApUM2g0jMOEaLbT4JW4JUZEq
         Lgrod5Zv6t1uKsv3IcmkOE2w/30StqfebZopmwDllb6UNI65U5ImhUIO09K9eo6Q41EI
         TGLz0FX49l0KvJohNis8hdD4NCGOyA19ubHAqd3yfpZfgx2hwpiy7NKm/5Vuo+ds7vFX
         sthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctzgjv+NmABx1Kt3m2tDVwm2LGH0KuiBAUYDbPhDv1Q=;
        b=nZpdNj1PnpEItFCFfUBIvoyhcUg5fWsMnSb1kfaS7+IBEMceQ6hlXE8pUHuBc4L0Mw
         l7+42zdbQQjrQ8/dr7uYwS45IibEq4m5oXSv+9GS2NmQntpZgx0X0Y7JTMOfgF7OITS1
         qYlJK5OKuLHxJFbzv4rtEguCB33hbYM08fBzL0F0x62/oh10bicBm/Nu5DK8F5G2blO7
         g010g+h8rSpT+5qYaCKqEHh6p4a4yMxVnmBv8drIwyGC7uf+40htwkmp4YxlzVemNRlP
         xP8/KMXgsPDl1x2/QFV2+wMJ2XPLR81RjKKXWrfiJUYqiK/VWoQXBfUypo8bhFVSVVAD
         Docw==
X-Gm-Message-State: AOAM532iXwXUILOjHO/HIzQQ19KtxV4sBWbA+f2NZaRpfTGdu4xthJ9b
        6dvklrrQ51XT++HBM6747hY+tAFudH4eHg==
X-Google-Smtp-Source: ABdhPJwcaqp3i4eiwneqkNGjFUh8FzXBxoYJHVg6VFa94j4eRxJJuLa5s7T5KrPNDyh0rG8MALMp+Q==
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr8803418wmk.43.1603899829707;
        Wed, 28 Oct 2020 08:43:49 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u9sm7884114wrp.65.2020.10.28.08.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:43:49 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoc: codecs: wcd9335: Set digital gain range correctly
Date:   Wed, 28 Oct 2020 15:43:40 +0000
Message-Id: <20201028154340.17090-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201028154340.17090-1-srinivas.kandagatla@linaro.org>
References: <20201028154340.17090-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

digital gain range is -84dB min to 40dB max, however this was not
correctly specified in the range.

Fix this by with correct range!

Fixes: 8c4f021d806a ("ASoC: wcd9335: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index f2d9d52ee171..4d2b1ec7c03b 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -618,7 +618,7 @@ static const char * const sb_tx8_mux_text[] = {
 	"ZERO", "RX_MIX_TX8", "DEC8", "DEC8_192"
 };
 
-static const DECLARE_TLV_DB_SCALE(digital_gain, 0, 1, 0);
+static const DECLARE_TLV_DB_SCALE(digital_gain, -8400, 100, -8400);
 static const DECLARE_TLV_DB_SCALE(line_gain, 0, 7, 1);
 static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 25, 1);
 static const DECLARE_TLV_DB_SCALE(ear_pa_gain, 0, 150, 0);
-- 
2.21.0

