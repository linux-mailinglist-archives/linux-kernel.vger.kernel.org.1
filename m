Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2442F4DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbhAMOwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbhAMOwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:23 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB299C06135F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t16so2417984wra.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzS3qZvHYgaPOU1XJ8pzaZK9gKJ87LqYUfVBvla6rAk=;
        b=r5T8a1xoDb37mL9jIaJql8CuqF65c13F0JN0BADlmBJtoOSiLcHLQQE0zXy42jaISG
         L+mOCdoDYshlaFwezWabUiL61Rpla5d4FFyMQCCDUECkUNO1e6hFSngniGnbMl3TwRw+
         0YBTdOFYXyzAsLFnu8j9xEbDQHDJuqj6YN1tK1TxHEmTQvc5vFrEV8J9bQUUCzhlQc/L
         uEKFperGkCjqCYYjupjJDiL5O1pf0WMWVTyoYuZMKqCrDTJBlNsucq2nS6FxjcouMcm8
         ZJnYRxOZO/pAbljJIw7+ZWc1fEo6pqh7BSCCdYtMIEOpTqkl93Az01qWCSLh9dnj+3/e
         0yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzS3qZvHYgaPOU1XJ8pzaZK9gKJ87LqYUfVBvla6rAk=;
        b=hOFxlm0IHf/HYW1z0ncIR4ejEUPGrYghtnspbpMkuabOYFTdLEy+u1RzrXEtBrHeUz
         jVtQsd1fmyAlTD8afyBJiZQyELcwtOO0y+nopL4Q7FpbWXgx04OzBaeqnCQBcpnxQj85
         JhzKiduatBC05/4WSc4mozsq7HaVnfr1tZ8evpZ6+ffiO1hxQcXIetu1N7/eBbH+9U46
         90KFRaWdwhDvMnfdb6ClHVVExtk5p/E4flRfx1InZl0Q/EL1uadKB/1EzbVAVPXjhUdn
         fGn0ptTjIj1S7NL0XoY6knnlLbtiWbcAaN/LnU1Bnu/s7T/Wq2vLxBunuBeAPiBjYvhh
         OxeA==
X-Gm-Message-State: AOAM530x5p1upolWnK79olP/D9Pr1NP/5cT+nHrfjKR1Tt1l6iTSu0Uq
        eHpoG8EEL/CpitNjGCTKprnisg==
X-Google-Smtp-Source: ABdhPJwWW8Mh0VQz40rTJwa/0e7kE/8p2NvxyZJuFij95jhV38CZu46wo+9mK5ByYWZwB9G7KRUEhQ==
X-Received: by 2002:a5d:5227:: with SMTP id i7mr3134555wra.68.1610549454505;
        Wed, 13 Jan 2021 06:50:54 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Ben Dooks <ben@simtec.co.uk>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 29/31] video: fbdev: s1d13xxxfb: Function name must be on the 2nd line in kernel-doc
Date:   Wed, 13 Jan 2021 14:50:07 +0000
Message-Id: <20210113145009.1272040-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/s1d13xxxfb.c:515: warning: Cannot understand  *

Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: Thibaut VARENE <varenet@parisc-linux.org>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/s1d13xxxfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index e6e8bc74412c6..b21627c07f8d0 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -512,7 +512,6 @@ s1d13xxxfb_bitblt_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 }
 
 /**
- *
  *	s1d13xxxfb_bitblt_solidfill - accelerated solidfill function
  *	@info : framebuffer structure
  *	@rect : fb_fillrect structure
-- 
2.25.1

