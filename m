Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6B32B1803
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 10:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgKMJRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 04:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKMJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 04:17:32 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A02C0613D1;
        Fri, 13 Nov 2020 01:17:32 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x15so4293271pll.2;
        Fri, 13 Nov 2020 01:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1a1lBoMKaF9SveclJWs+RsYOR0BXSQKnr2c/16CY6gk=;
        b=IAeYavo4X8xJrI11Qr1AQf5+93NOW39lTX8Dg7D9+u3H0u6AZCZWejVRWtcapUiAmb
         Iwx0ZwyIAPFBh/55ahQx5y3bovKpfh0GFfWn3FJhsEfC5XowDoUQxZ8japhVoytKc97T
         vwvQbF9/WVHEHgvlyrAi20SSuVgraPLfngZSHsJR64JJe1tetVs/f38ObEgSMZE1cN/k
         K2D/nhhrJ2qig/V7PfoDQAZ9G34BMkYbGt52auszMuoRLAI/jcfXVyFMXEUEywUInvLG
         JCxQaHe4jKllooZystVYqxRNHb499NaH54thUCl0rJ0uefHTUgYJwJgc/7UDR0L3gHuW
         GmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1a1lBoMKaF9SveclJWs+RsYOR0BXSQKnr2c/16CY6gk=;
        b=n6KALPbqQ0mKEOPwWIPmw7EX10zcOPw8Lg/ddBZtbNpIqeZdeY/pwTZmYarqZyUzuj
         3LwEIfrl9+FTZe8xRX/c8tSyeMH4ufCJP7Z8uK0pJzhLF+xWaMBrMRYEmZOXGNCg3SN2
         gL4NsSkon11tzafgwvHPWjzZ1+pv6axXdF4Mj70tfAygx6v+qbLCR5Y0rCUGO8WVkVaQ
         h2EzZDg/fxh2tvN4+nUsIBxtaOAU2W1MrmoBgMw2DHMIzvmQhQ4IXKvvJweu75Fgm7FG
         joWDUlQTNnFVw0uuwP1/tkByO4oXn7XfV1siFG+/Z0Gp5hoPKY4XlLTCyejC1Ygu6yHT
         LflA==
X-Gm-Message-State: AOAM530itI19Z3hWvvo4/45PiIYGRIWWGp4bVYGNswKq/qTXh++6Zt54
        zFWH58RlNBm6ukO6osKpIJo=
X-Google-Smtp-Source: ABdhPJx8WfuAmSuc/zlJNZ64hvVSyHDyT3IEN24XS+IqLlvJTd3J3ckc8Izw+AejF7375DzUdmmogg==
X-Received: by 2002:a17:902:8d93:b029:d8:d8ee:e275 with SMTP id v19-20020a1709028d93b02900d8d8eee275mr271468plo.71.1605259052110;
        Fri, 13 Nov 2020 01:17:32 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id o67sm8936666pfb.109.2020.11.13.01.17.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 01:17:31 -0800 (PST)
From:   chenlei0x@gmail.com
X-Google-Original-From: lennychen@tencent.com
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lei Chen <lennychen@tencent.com>
Subject: [PATCH] Remove unnecessary invoking of wbt_update_limits in wbt_init
Date:   Fri, 13 Nov 2020 17:17:04 +0800
Message-Id: <1605259024-21764-1-git-send-email-lennychen@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lei Chen <lennychen@tencent.com>

It's unnecessary to call wbt_update_limits explicitly within wbt_init,
because it will be called in the following function wbt_queue_depth_changed.

Signed-off-by: Lei Chen <lennychen@tencent.com>
---
 block/blk-wbt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index fd41008..0321ca8 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -835,7 +835,6 @@ int wbt_init(struct request_queue *q)
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
 	rwb->wc = 1;
 	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
-	wbt_update_limits(rwb);
 
 	/*
 	 * Assign rwb and add the stats callback.
-- 
1.8.3.1

