Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3FA28431E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgJFAA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgJFAAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:00:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72111C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 17:00:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ds1so659602pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 17:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lMOsfwi87KqTZTytxIFmtZd/oiM8x07q/Mp8jyPAAXI=;
        b=TR41v40N3c0mT6iKV7st9SNhlg9QTdUELsrtGct+/7ED4AfArTHDYCsYjVMUkQrTa3
         TjLWrSiIYucTjdyPSil2F0f1UtirIgTuT1jSdLl4ISjQqsqs7BRoB50aBYiQw+Y7p0xW
         YlXFC0yuaCZWWhtfaFXRua4TpMPmDF+5ayx4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lMOsfwi87KqTZTytxIFmtZd/oiM8x07q/Mp8jyPAAXI=;
        b=V3cTrm8fxULa5Fmu53V8wXblSfZ+LnLvw/b7Guopauf5ual7h6ZjhhOri1PkdJ3s4u
         AAqQZHjmFncdSOp21+/zwo0kXp/jD/5UgoWjWPoMUfofKTdHkjnxNPxw4TZXR71spavE
         CuN9r8D0Ae1WjKsK9hkFOHlbz+m0tdl0DrVjfg+d7WDYJR3dKBjfTBYvRU5okEnOlKfm
         yfGyag6VA7oRroV85TF6FBeGOx/qVlPUmnX5T4LTvwAcP8GjmoO+uW7o819XVomhZ7ta
         3OzfMxHzWoLvH+JELu/SLi84eo7P+DT6h8jwWjfWtXxnIJrqike51S9oVQVE1gP3cjSu
         uFTw==
X-Gm-Message-State: AOAM533MwZ23nlSqn5lRWkKm57dgEsaUmJLbOVVB/cvVciHSDK3PQs/w
        p15ZszInM59c7h854NBXf42j6w==
X-Google-Smtp-Source: ABdhPJwWiBEIxSg5nqXR/ySYj20GAHUNH/4qqdyUS4ujisiRNJr16ZDSNzx/7HeR6hfmV6aR90nuLA==
X-Received: by 2002:a17:90a:3fcb:: with SMTP id u11mr1785643pjm.128.1601942415868;
        Mon, 05 Oct 2020 17:00:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j25sm1070281pfn.212.2020.10.05.17.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 17:00:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Emese Revfy <re.emese@gmail.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v2] MAINTAINERS: Change hardening mailing list
Date:   Mon,  5 Oct 2020 17:00:12 -0700
Message-Id: <20201006000012.2768958-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As more email from git history gets aimed at the OpenWall
kernel-hardening@ list, there has been a desire to separate "new topics"
from "on-going" work. To handle this, the superset of hardening email
topics are now to be directed to linux-hardening@vger.kernel.org. Update
the MAINTAINERS file and the .mailmap to accomplish this, so that
linux-hardening@ can be treated like any other regular upstream kernel
development list.

Link: https://lore.kernel.org/linux-hardening/202010051443.279CC265D@keescook/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 50096b96c85d..91cea2d9a6a3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -184,6 +184,7 @@ Leon Romanovsky <leon@kernel.org> <leonro@nvidia.com>
 Linas Vepstas <linas@austin.ibm.com>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
+<linux-hardening@vger.kernel.org> <kernel-hardening@lists.openwall.com>
 Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
 Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
 Lukasz Luba <lukasz.luba@arm.com> <l.luba@partner.samsung.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index adc4f0619b19..8fa1d8ce2188 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7216,7 +7216,7 @@ F:	drivers/staging/gasket/
 GCC PLUGINS
 M:	Kees Cook <keescook@chromium.org>
 R:	Emese Revfy <re.emese@gmail.com>
-L:	kernel-hardening@lists.openwall.com
+L:	linux-hardening@vger.kernel.org
 S:	Maintained
 F:	Documentation/kbuild/gcc-plugins.rst
 F:	scripts/Makefile.gcc-plugins
@@ -9776,7 +9776,7 @@ F:	drivers/scsi/53c700*
 LEAKING_ADDRESSES
 M:	Tobin C. Harding <me@tobin.cc>
 M:	Tycho Andersen <tycho@tycho.pizza>
-L:	kernel-hardening@lists.openwall.com
+L:	linux-hardening@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git
 F:	scripts/leaking_addresses.pl
-- 
2.25.1

