Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02232A1B5B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 01:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgKAAUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 20:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgKAAUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 20:20:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE37C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 17:20:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d24so10989734ljg.10
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 17:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=somia-fi.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gb/J6pBTC+U79s+Too2NVqGf5ftZkxTHSHF78mWqzDw=;
        b=TfVWvTb/uUJdxfYW5VobHdQCqYzSpD0QO5ICYOXPUCi2HuCQQfDPZCbq3lh28+m51J
         fd9Mn1hrHDigXVGxmvtZpPLYqn/bzyH0/wdgFErf/uioNrgL3SDAjVZzEZ54MPN3RKL1
         JXgi91z/mXWVCmqEbhjThxZ9Mba19sXp5F7kY2Wx1j7CFNFX+KA+6tpBvrMazHhilixP
         uuY3BZoRQhNijCHeHBb3eL/gwmgS8bI8l0cp1Zv1s2xXVfF/ZTV6o6twxI37ImVnmHpj
         d5MHfBobFZP5dIVgCLkyYwHcXqo/I6aNgH4uATWkqKBZjJhQBwHKzhLMRIvZJa347N58
         Icow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gb/J6pBTC+U79s+Too2NVqGf5ftZkxTHSHF78mWqzDw=;
        b=PXWiWjoYbFYy3Q1kkYDOrHN6URrQ8NOdsHgpESGth40rl5AJVP0nWtZK3QTf/sdOlm
         chs8PLSyaOqKYApUNZyoCXbk5FOkGSYyw3X7bxSqP6iU3Jecaadn1ojZjFYcy3hg2lFp
         2cvOVLeO9cU4ds8ex/92zAMZKIfI32UZOjjEZq5xGTsMwpv2vw0PCYn5ZQoLr2Oezdlb
         Zs4uBoBdH33u+eezNNuQXZ/J1O264zuzXfYG9kIG/uvjoi8DWXTx2IKfTcZU5V+eJOWe
         U8z5q/CU1NxxW8ndtpgkAMICbl0de2p4/qcHOatP9PdAQP1XihoLv4WDKJMHrRwDvXQG
         HStA==
X-Gm-Message-State: AOAM530r2nRpDA4dsH+KuQ21fM+Echb1QcSH128LaVA27+Mn9J6zEMpy
        oqZCeKNjgduo6o5OkxS1gfgVOLYTm8hHGt0E2aAZBQ==
X-Google-Smtp-Source: ABdhPJwBwAVgFbijYR3dZ2iWYVxrgF40gZwx2I+/lofd5+mwhGbetATjbiVxg/P0XNgHr+ckI0Tgrw==
X-Received: by 2002:a05:651c:510:: with SMTP id o16mr3766337ljp.409.1604190040276;
        Sat, 31 Oct 2020 17:20:40 -0700 (PDT)
Received: from localhost.localdomain (cable-hki-50dc37-152.dhcp.inet.fi. [80.220.55.152])
        by smtp.gmail.com with ESMTPSA id s18sm1165065lfc.284.2020.10.31.17.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 17:20:39 -0700 (PDT)
From:   Hassan Shahbazi <hassan.shahbazi@somia.fi>
X-Google-Original-From: Hassan Shahbazi <hassan@ninchat.com>
To:     linus.walleij@linaro.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Hassan Shahbazi <hassan@ninchat.com>
Subject: [PATCH] staging: fbtft: fb_watterott: fix usleep_range is preferred over udelay
Date:   Sun,  1 Nov 2020 02:20:10 +0200
Message-Id: <20201101002010.278537-1-hassan@ninchat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the checkpath.pl issue on fb_watterott.c. write_vmem and
write_vmem_8bit functions are within non-atomic context and can
safely use usleep_range.
see Documentation/timers/timers-howto.txt

Signed-off-by: Hassan Shahbazi <hassan@ninchat.com>
---
 drivers/staging/fbtft/fb_watterott.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
index 76b25df376b8..afcc86a17995 100644
--- a/drivers/staging/fbtft/fb_watterott.c
+++ b/drivers/staging/fbtft/fb_watterott.c
@@ -84,7 +84,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			par->txbuf.buf, 10 + par->info->fix.line_length);
 		if (ret < 0)
 			return ret;
-		udelay(300);
+		usleep_range(300, 310);
 	}
 
 	return 0;
@@ -124,7 +124,7 @@ static int write_vmem_8bit(struct fbtft_par *par, size_t offset, size_t len)
 			par->txbuf.buf, 10 + par->info->var.xres);
 		if (ret < 0)
 			return ret;
-		udelay(700);
+		usleep_range(700, 710);
 	}
 
 	return 0;
-- 
2.25.1

