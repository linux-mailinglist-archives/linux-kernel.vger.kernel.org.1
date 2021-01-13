Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6B92F4DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbhAMOwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbhAMOwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:23 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E1BC06135D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:54 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g10so1856275wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xOmpZJSJcGjkWdwzXh/1wdxHxk1qdbTp529iSzZw+A=;
        b=MymSG+nXTdHHBzQGPOze7DAAa+ej555u1BcqPgKwDdULmCR+9lifj/RBMgwbwLjlyt
         elvEBNHzvmvW/yms4fg79Qi5WzxgrFr7YClQKZgIpcNwnQ6ljdR5HdRdcTX3fA10rdIO
         aO30H/7nbBKrI5hxOWH6sSs6sEMtOANO1pinWzByh2d2GV3m/EpoTjowTDqX+0kZ8xaX
         liF75WImH8LTXSQqNUBp9HlqfewIAHFYh7spBcCRwDuq6cWAwda7+vnAqeuvQNX58v7P
         03COI9tjDj1PG/ZMJxlUk7Sxq24UPa6mvTMs6nk8c9qwdcBQeIG7i50znWEf+3nSQ5RB
         JzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xOmpZJSJcGjkWdwzXh/1wdxHxk1qdbTp529iSzZw+A=;
        b=lwRPWRumiBEKo/QU7rceSdmh/oRS6Cqcynho621wQItvBadrhQk7NgZaGtWLyOht/6
         MiqPOARKXwnD83Cs2yylunOXKGMox7eEYmzn/ManB7Qc7ki7Idw0NTcAwkx7Rf8vXsUS
         VSt+BKkXknX00A53nCxTZsV6D7Iv3af+Qux0Yd05DSTiJg/1EulR/AGAxQAbDJuZiVDb
         6Onu9AzqgbxOPuUjHJvdX+TMU1vjCoj16rmT2mMAUb0w9QOu1BTsvNN2+xGX6MYoYQWp
         ZGTAP/afrMbwcwJ0tEXeTkAIljKMFSVSWyvDBZuh0ybD/EW1rc/DURSB9V+DbMoWg2Nc
         Yi5g==
X-Gm-Message-State: AOAM533TxbsD9NTjxdiI6nu21Gt1lxGTxIjHL7DeIGl4baexHDkTwd8f
        DYrLuzY+93Y6SfzMyud5TzE67A==
X-Google-Smtp-Source: ABdhPJy1eR+KY9VjvEkheIzVcqWp7XoiAxVirwoH+ntCmyxPC42Czfx3zHGSaOqSDxojIeI3efM6eQ==
X-Received: by 2002:a05:600c:29cc:: with SMTP id s12mr1724821wmd.180.1610549453390;
        Wed, 13 Jan 2021 06:50:53 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 28/31] video: fbdev: cirrusfb: Add description for 'info' and correct spelling of 'regbase'
Date:   Wed, 13 Jan 2021 14:50:06 +0000
Message-Id: <20210113145009.1272040-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/cirrusfb.c:2815: warning: Function parameter or member 'info' not described in 'cirrusfb_dbg_print_regs'
 drivers/video/fbdev/cirrusfb.c:2815: warning: Function parameter or member 'regbase' not described in 'cirrusfb_dbg_print_regs'
 drivers/video/fbdev/cirrusfb.c:2815: warning: Excess function parameter 'base' description in 'cirrusfb_dbg_print_regs'
 drivers/video/fbdev/cirrusfb.c:2859: warning: Function parameter or member 'info' not described in 'cirrusfb_dbg_reg_dump'
 drivers/video/fbdev/cirrusfb.c:2859: warning: Function parameter or member 'regbase' not described in 'cirrusfb_dbg_reg_dump'
 drivers/video/fbdev/cirrusfb.c:2859: warning: Excess function parameter 'base' description in 'cirrusfb_dbg_reg_dump'

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/cirrusfb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index f05160fa34da9..bb2cc753c1cf5 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -2800,7 +2800,8 @@ static void bestclock(long freq, int *nom, int *den, int *div)
 
 /**
  * cirrusfb_dbg_print_regs
- * @base: If using newmmio, the newmmio base address, otherwise %NULL
+ * @info: frame buffer info structure
+ * @regbase: If using newmmio, the newmmio base address, otherwise %NULL
  * @reg_class: type of registers to read: %CRT, or %SEQ
  *
  * DESCRIPTION:
@@ -2847,7 +2848,8 @@ static void cirrusfb_dbg_print_regs(struct fb_info *info,
 
 /**
  * cirrusfb_dbg_reg_dump
- * @base: If using newmmio, the newmmio base address, otherwise %NULL
+ * @info: frame buffer info structure
+ * @regbase: If using newmmio, the newmmio base address, otherwise %NULL
  *
  * DESCRIPTION:
  * Dumps a list of interesting VGA and CIRRUSFB registers.  If @base is %NULL,
-- 
2.25.1

