Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60B32F4DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbhAMOwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbhAMOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21272C06134A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:48 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i9so2419474wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8R8CrMmu7yuBA/ZNIQZlAyfMprfiOkPW3GpI5ayBsWg=;
        b=q1+kp8rlc5YHssN6Eq89+XBI9+3PExs7mtj+vKpE1TFKE1rjX2///yzy+zDTZKSmOo
         veDWfzfkp2jlcqkWf6hyrhxd4ZIDNoNqF9HS7ddPt4booh+FDzx3O5uQ2G8rdhZHcVp3
         PA1ZgIYstzQ14gHP1p8JOg40/+Qe5fqobxdt9bJb49f5X37fSTQnByGZCt6BqgU83z6p
         QzAtbnYyN0YvKG7g442YVr2E98ZQvzgo4BnA5yP33ogF0/EDLppn6AMEy+q/dBx0eQ5f
         Im6lCkgNGn1IZSkhzSUaYdClRbl34RHO4jN1MiOjnXDBZW66eOJRiiEjwIv769RVoAR7
         qlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8R8CrMmu7yuBA/ZNIQZlAyfMprfiOkPW3GpI5ayBsWg=;
        b=lIpw4zds7wdSUs8bQU3jXRnDKNzx1biyLLPX/ZOXwANSi08oVr/g74KgBVwrpejVxb
         c7XFjWQTvD0Hlb5GvHNbe+iO5wFKLGh5A5qmNSevJm4EkQZ3a073yskUlsWqfAJ4XaEx
         TJrOyGo0wbcItxWENYQnXrduwrsqjNgCBGjn01w0NXe20ZJMYBtCstE3WysUk1KukrEc
         Ngc63JCF9ikGSJWs/sb/RNtD/4KzfixwuzctPBwhPTlYNHouFnYPHI6ACeRSW+b2+ZB1
         DUCTBwA5giFGO1dSP8RzssB7cdCRNtIJ58GeY9w8uYGcD00GttX3z6TEJpVxNWZ2eIc0
         uYiA==
X-Gm-Message-State: AOAM532IpSDzojSMAKfzkiieLVeO0TGGG0TQvuDRX0cAC1SqFUhVtbfe
        PuZ1dZiHbwNAmmlE21jdP0yLTw==
X-Google-Smtp-Source: ABdhPJwF8QB82NwqEyn+scjHeSXF56DRGMKoUHEnV/4pPFJaM/1IosDrCdd2x+tLam8CZhkoj23PHQ==
X-Received: by 2002:a5d:4d50:: with SMTP id a16mr2926797wru.43.1610549446928;
        Wed, 13 Jan 2021 06:50:46 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Ben Dooks <ben@simtec.co.uk>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 23/31] video: fbdev: s1d13xxxfb: Mark debug variables as __maybe_unused
Date:   Wed, 13 Jan 2021 14:50:01 +0000
Message-Id: <20210113145009.1272040-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can't declare these under the same clause as their use, since
debugging is enabled manually with an '#if {0,1}', so mark them as
__maybe_unused instead to notify the compiler that this behaviour is
expected.

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/s1d13xxxfb.c: In function ‘s1d13xxxfb_fetch_hw_state’:
 drivers/video/fbdev/s1d13xxxfb.c:644:16: warning: variable ‘is_dual’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/s1d13xxxfb.c:643:11: warning: variable ‘lcd_bpp’ set but not used [-Wunused-but-set-variable]

Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: Thibaut VARENE <varenet@parisc-linux.org>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/s1d13xxxfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index 4541afcf9386e..e6e8bc74412c6 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -640,8 +640,8 @@ static void s1d13xxxfb_fetch_hw_state(struct fb_info *info)
 	u16 offset;
 	u32 xres, yres;
 	u32 xres_virtual, yres_virtual;
-	int bpp, lcd_bpp;
-	int is_color, is_dual, is_tft;
+	int bpp, __maybe_unused lcd_bpp;
+	int is_color, __maybe_unused is_dual, is_tft;
 	int lcd_enabled, crt_enabled;
 
 	fix->type = FB_TYPE_PACKED_PIXELS;
-- 
2.25.1

