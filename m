Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400B22F83E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbhAOSOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733311AbhAOSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C84CC06179A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w5so10179738wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpHmuC5+6mrLTxCF96eU2jys1HshdL5VNQtWWDrXTEc=;
        b=xZIH7SwI6Fbbu2RKOQ3Emd0mDzyDXntheoo+T/kqfqEo8d5VJgHNI0gYye37CB7WwI
         T6Fqnprv+zHjajpyH+7J0eE5X89LiDsWKh5p43VT1uK9niZVeF6c2ks6yd0LI0mwPPv8
         /tL+KSim+ajMJwBegccStwEHWZ1+94Afsz2yZfzsFiY62lLvOwgL8K1v0HSWBV639nfT
         Mg3WUxmoypi+KvEVm8XlnUdWMmqkKeZPi8NjMHjMZl1XahqRv9TuxFvWZmGVUZH4pRoN
         6RfeHl6eHVpW7LExiU4xc1myTcYTPV+jR+p/7A6R3RYscZAwo9BMPmDKFkZoqkQesHRV
         FeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpHmuC5+6mrLTxCF96eU2jys1HshdL5VNQtWWDrXTEc=;
        b=sLs6laTDC5WRPkx1AudbfX4Zjp9Bmd1x0E2UhjTJoembB3onrOmFbqiFMFIt6TzTvX
         zTMIF7HUdt9uNXtd7LMK7M74oQ68oH5uMMDSP2UlTnwaucSxCo9bwsxNdZq7vYYAfa+l
         kkxYKH4f4JWFUFgKK56Dkup8b5bMAxI/pOa+AIzx0kKp0BhqrtxaQ/Bky0fT/QOPpPaZ
         65GJDNHMl6gFPbzdaenk3qL5qidRh/EibGCjKJPlEWpdVEblO6mnS7D30GfV/1Ul+vXg
         slWOT1KZtSD58noQHITvFQH9IwAhujecJvLsus/DZL4rbAqkUlQnP8u1VYv6L3QAQrRk
         sMXQ==
X-Gm-Message-State: AOAM530qNuRqyhYJ7tR/lmsFEFY2OE5wcHDoE/L1g1Hpr+y/gs60UY3l
        hNurGtYv3Btj8CHl0ySzjHVUs+4VyXcojfPI
X-Google-Smtp-Source: ABdhPJz1rIOt/fxVq/kJAg8SWgzfhLOw/V4zUIlwuFz/czfyJGKZv2ghuwQDTzYqMiJpet5Er7cJwg==
X-Received: by 2002:adf:c444:: with SMTP id a4mr10945203wrg.164.1610734404198;
        Fri, 15 Jan 2021 10:13:24 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/40] drm/mga/mga_ioc32: Fix some formatting issues in 'mga_compat_ioctl's header
Date:   Fri, 15 Jan 2021 18:12:39 +0000
Message-Id: <20210115181313.3431493-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mga/mga_ioc32.c:171: warning: Function parameter or member 'filp' not described in 'mga_compat_ioctl'
 drivers/gpu/drm/mga/mga_ioc32.c:171: warning: Function parameter or member 'cmd' not described in 'mga_compat_ioctl'
 drivers/gpu/drm/mga/mga_ioc32.c:171: warning: Function parameter or member 'arg' not described in 'mga_compat_ioctl'

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/mga/mga_ioc32.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mga/mga_ioc32.c b/drivers/gpu/drm/mga/mga_ioc32.c
index fd2160ea71fe1..4fd4de16cd328 100644
--- a/drivers/gpu/drm/mga/mga_ioc32.c
+++ b/drivers/gpu/drm/mga/mga_ioc32.c
@@ -159,13 +159,13 @@ static struct {
 };
 
 /**
- * Called whenever a 32-bit process running under a 64-bit kernel
- * performs an ioctl on /dev/dri/card<n>.
+ * mga_compat_ioctl - Called whenever a 32-bit process running under
+ *                    a 64-bit kernel performs an ioctl on /dev/dri/card<n>.
  *
- * \param filp file pointer.
- * \param cmd command.
- * \param arg user argument.
- * \return zero on success or negative number on failure.
+ * @filp: file pointer.
+ * @cmd:  command.
+ * @arg:  user argument.
+ * return: zero on success or negative number on failure.
  */
 long mga_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-- 
2.25.1

