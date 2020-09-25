Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33025279066
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgIYSbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbgIYSbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:31:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B572EC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:31:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so3283329pgo.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z5xy1HmEK3Cb2cGuOZNBEue37qSrHj+Vnq/OwfaPORg=;
        b=sBlYShu+9vN6ayWh4BrzZFB3L8UBBVdI0bE+jUCCnUWfYdR0Dfg9rRQ+jLtIUsVd3W
         NWIUbQROcUaoftLHhbGfzJi5Rg/eJtmLfrYcfS4X05/YqwKtVXCVikqj+/hQT6QBFoAg
         ollSSj2k+OMDAnEUAMH1GJw2W/ijQHZGchwJj3jUIVyQL+rLR5y1CLy1+uJXBAy0AtP9
         W+1E0pWNzJp23zMt2nAXk/J3tCSXHYpvKzZMeURXPZPxgk8RyCBHqU70Gd3CCoq76WRa
         xlNgbHuw62gQekcuNM8L38Mq6kYGTZMHiIyOjyXSy5RTNjEqf8yBp2h/A9zLm2Roe+Rs
         I29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z5xy1HmEK3Cb2cGuOZNBEue37qSrHj+Vnq/OwfaPORg=;
        b=SNz+F6MDiCBXdULs2F87dCTaNoQADogIXKOLR14EqjPKVKQw50H4QoIKOfpcHrtoCm
         eqxJuh9+wE2SLJ0iY2JlKDpDrCMlr3uwDxLZyr7QLhEaxnCGqV+EroYUde+/om47mgwt
         dJX95KzI52TKjDB2llqbHDiXmZcJ1jy8TEnQ657rS2FKBRpg6YILhN8jjxocImZxDXE4
         fAvumWWFWFFKxUmVw4Zjg/glJ5e9cnTuNgJ3Yfi4iSz+Dg578d1drM2ro74HCBYYCDyE
         ObbOyzEP7AKgFj5FN+tmXHdrgK672/72ubVOWvIansENfRk33MrOGCfWQJGZejflcFjD
         NzyA==
X-Gm-Message-State: AOAM532e6zkBuwmBZwUrksoBfHwUINMGWChnZGwmqwF8a219/HbssRCL
        FCHR3p+WSWAYq+W30YKQfe9bUg==
X-Google-Smtp-Source: ABdhPJwdn4XhS1Fuqdi3Nmv5dQHDo9mWrn2Zwo9AuP7EkwR9dIm+/lhIaXMse5TDA/s6sztjt+48wg==
X-Received: by 2002:a65:6104:: with SMTP id z4mr250114pgu.184.1601058695275;
        Fri, 25 Sep 2020 11:31:35 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r16sm2554546pjo.19.2020.09.25.11.31.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 11:31:34 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC v2 03/47] staging: media: zoran: datasheet is no longer available from zoran.com
Date:   Fri, 25 Sep 2020 18:30:13 +0000
Message-Id: <1601058657-14042-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
References: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply remove this broken reference

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_device.c b/drivers/staging/media/zoran/zoran_device.c
index 04162be80420..79da964c678b 100644
--- a/drivers/staging/media/zoran/zoran_device.c
+++ b/drivers/staging/media/zoran/zoran_device.c
@@ -265,9 +265,6 @@ jpeg_codec_reset (struct zoran *zr)
  *   Set the registers for the size we have specified. Don't bother
  *   trying to understand this without the ZR36057 manual in front of
  *   you [AC].
- *
- *   PS: The manual is free for download in .pdf format from
- *   www.zoran.com - nicely done those folks.
  */
 
 static void
-- 
2.26.2

