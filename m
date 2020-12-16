Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61282DBC58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 08:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgLPHtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 02:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgLPHtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 02:49:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF21C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 23:49:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id y23so1457812wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 23:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=8QAARv8T844Az5mg42y+k9mUZFK5IptDD93reuvHgH0=;
        b=O0pIrgvE3s3kWCKBBoiXHXsQExxWbJZenUhe3K/grxvZoRPvRFjD3yL8sPbFgMxUKa
         RrSgJ9qK/KoN2ew2S4EDhjFLQFqxOkfxQxj1koO0NA7f2yCM4qaWyBQGX5Aaclqd8H0d
         6UIalvTgtBI9rDSO9xiXQlRZH92YC6+8xTfk51sQ6pUoE+Md0q0dmPoUUJmEaQYbxtNM
         C3qT+DTbRPNJp+m62sbwRUC8ybwg0qYGvbAl98LtyVxtBqxUHcFp+fkzV8UnI7+WwaTn
         /E886CItgy6zvPMqY51VgpmrZfL18DoXTX/NXv/6EKy98kIbEliRsHXM1B3Qhz6qxyrh
         UmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=8QAARv8T844Az5mg42y+k9mUZFK5IptDD93reuvHgH0=;
        b=gEAvsTnaZYDjHQBKBzPXSqBF20hlB7qOG46jjCSXTK17C3YGf5EUWDAnjFVD3655GG
         jiOcO+AfLlxb8drG3/66gT7szycZGxXq1NzweDvvWzEakwe60bgM5oI5p4L6kGDL6l/v
         s+AFGtOmvKZVdDavRgXSwN5hQlOEYVCHQyVpckgrooZlGjN9uHWtGxsZ0kwiiyj5VfJa
         +xDy+puAQ9HSYMJ6UvzW0HHn2kTD0Yg5eFy/04A4o4TnLEkvpcrybnscJOaRJtyC0KgO
         hYwFYm7/Pqdo1ws+9WRslLH0n1W/K2qsa9Uf8HgwiZCw03+p2BtzGWbIw71K2dYGWk99
         LpUg==
X-Gm-Message-State: AOAM530zDdr5M8n0YntHNlIuPlkHU5wbbF6QchZNGsX2kMsIz7NuykUh
        /zlimElmGMeOoGQ3FRleKvn8x5ct+eC12sbk
X-Google-Smtp-Source: ABdhPJxsDCyncc+zAcQkm06b0TnNKYkAVi1lgiMSpQx059mlSl/QHMm0Ey9yr+QPSBKzPn5rTS8sLg==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr1928684wmd.70.1608104951153;
        Tue, 15 Dec 2020 23:49:11 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id q1sm1914011wrj.8.2020.12.15.23.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 23:49:10 -0800 (PST)
Date:   Wed, 16 Dec 2020 07:49:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] Backlight for v5.11
Message-ID: <20201216074908.GD4776@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

Careful, it's a big one!

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.11

for you to fetch changes up to 789eb04b6c569e3e5007afd040bef5d7216d2f3a:

  backlight: pwm_bl: Fix interpolation (2020-11-04 15:54:57 +0000)

----------------------------------------------------------------
 - Bug Fixes
   - Fix interpolation issues by switching to a linear algorithm; pwm_bl

----------------------------------------------------------------
Alexandru Stan (1):
      backlight: pwm_bl: Fix interpolation

 drivers/video/backlight/pwm_bl.c | 70 ++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
