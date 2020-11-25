Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701032C48C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgKYTy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbgKYTy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:54:58 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FADC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:54:48 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f17so3340249pge.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=Ckr23nQHY31Kq8p9ufQAXHGQbVrixMKzTDQRBuH9ApM=;
        b=kWRrWXdFoHsSoOpcSRxkQLSnGun9Aq+XPwC1CQ9uqitCGtnYNspRos7IMI2gJMuLge
         jzRobg9pdrHC81nEt+SNe0qFJealICniylrtfRWfSnrDjTyKcI+ygOlHJhBmkNFCQzMW
         mS6H7S9YkWl3QnAutRWfhYKOFcPYTz/akKuhURGn42Ky192YF1Bt0BXDJCXYnQ50T19W
         hR+Xv44/OmAkylM+34jdIcuttl3XZee+Ntwh+rURbFpqLe0JYgtz+zfG5vr3f61NYHrz
         GuItRotSi5e+H/g/JfK66JuWEDHpTGAoNP823yyLNV4bVBzmaYjU+HOQm6QG9QAJ1fxf
         /iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Ckr23nQHY31Kq8p9ufQAXHGQbVrixMKzTDQRBuH9ApM=;
        b=KY26yMvK35TXTH0ZC6gJ2gosydzz9TR4gzpsfWy5upep1hhWpUs8WokZ/ZoYvIRpBK
         YaMk1Vv6aEMAsf+ntPftVsHIoGovNtoZGsaNqHc8ppi8MdbpG70LgfQ+PinPz5ZOmhZZ
         s8Yaz0MrBhGAHfJvQ9EakhdXqRfl2yFpi7KrlxJ+W+0YCy71oSTG+LOir0Wu+gDiru0+
         KHX3UFhi7j1XBV52xF1d+7yyaKr8jDKiATCtILAj7o7GYMKNeCOkljd2EL5AAbcMMRnL
         FPzArGxgb3fM+Dj7Q1p5+tVeD3MVRgCyjFcc4hkAyt17R1GVWnhQBSKYm472ZWmwXcLG
         C+CQ==
X-Gm-Message-State: AOAM530IsTnqYdMutiLB+ydH7h69N0f2KQClLgWiWc2Pz4PNd2bcctZM
        LbGIthco6R1eq3w7e6wxeJRKi3Wi9GGW5SC7
X-Google-Smtp-Source: ABdhPJwASZarixa4Q31DYLjJHsv79WkCj0X9lMH+WVDIi3yMghi6OUyMz13QZOmvj8dJsZ1O3eCtlw==
X-Received: by 2002:a62:8448:0:b029:197:9ab7:9fdb with SMTP id k69-20020a6284480000b02901979ab79fdbmr4542017pfd.49.1606334087840;
        Wed, 25 Nov 2020 11:54:47 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c134sm130552pfc.200.2020.11.25.11.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:54:47 -0800 (PST)
Subject: [PATCH] MAINTAINERS: Add myself to the Goldfish RTC entry
Date:   Wed, 25 Nov 2020 11:53:42 -0800
Message-Id: <20201125195342.3778744-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     miodrag.dinic@mips.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

This is used by the RISC-V virt board in QEMU, which is currently the only
widely available Linux system.  Removing it right now would cause us some
headaches in the short term, so I'd like to keep it around.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

---

I lost the thread here, so if someone else has signed up to maintain this then
I'm happy to leave things alone.  I don't see anything in Linus' tree as of
right about now, though, so I figured I'd send something along just in case the
plan was still to leave it otherwise unmaintained.

IIRC we picked this in QEMU just because it was simple and had a driver we
didn't need to maintain, so maintaining it does somewhat defeat that decision.
There isn't a whole lot here so it shouldn't be prohibitive for me to maintain
the driver, but I will start a discussion in QEMU about whether moving the
boards that use it over to something else would be appropriate.  Anything like
that would be a long time away, though, so I'd anticipate keeping this around
for the foreseeable future.

I definitely don't want this going away right now, though, as that would break
the only RISC-V setup I actually have :)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a008b70f3c16..21f7cdfc89dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1169,6 +1169,7 @@ F:	drivers/irqchip/irq-goldfish-pic.c
 
 ANDROID GOLDFISH RTC DRIVER
 M:	Miodrag Dinic <miodrag.dinic@mips.com>
+M:	Palmer Dabbelt <palmer@dabbelt.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
 F:	drivers/rtc/rtc-goldfish.c
-- 
2.29.2.454.gaff20da3a2-goog

