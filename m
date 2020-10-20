Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD93C2842AF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 00:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgJEWyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 18:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgJEWyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 18:54:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0150C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 15:54:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so253732pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 15:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6kYPidesDrPpkfu9bAf1thvUGBXxbaosRDcQ6Yl6UD0=;
        b=l35VrlxxzRCHmT4nTjBivNAlxfq+ceEXUSvn3LeWA5SW8/81k+drOlPsRVNFX68OAo
         GbzAUoFKyiK/syvBdnWKLMyvQR8kC/0FNFTmej99FkfHnkBak8OXYZ1HMPN4fJJJ24Uf
         6BJmM0rDYONfxUTPFoybWNyMjiXjhPQ7KHe2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6kYPidesDrPpkfu9bAf1thvUGBXxbaosRDcQ6Yl6UD0=;
        b=rJkkEcSkO4P3WEIz5RrYR4KIYvU0zyb7jj5lynbeLQVFbZBKrtnRQUeV4x2haS/NmX
         NzDQbjSaQXG4AnqfrN1clmbtRm4zkJPvVgAyS29PJvgWcUd0JntnLFMBHzkQnqknkxNc
         zl/nMwlxcK1rYLVmYmyqxLL9kJvYwbbY7Jdp7ZWShXD/DAPmMxde0whCnM3EZhRUrmF8
         VJaYiS71+XDJ1lbzuOBsB6ON40kttL8qxtSzK2iWuSsYRLpKEz3XYpbhsfz2tYYT+BXA
         z6p7HyCrK+diOmrFehlkIg4pK6/XLuM2roxXtoxi4eM6KOqj/o8SUAEURPVgfV3mjc0n
         FxHA==
X-Gm-Message-State: AOAM532SdptEJGlH24hOhyclLlNvD+bEczbwUoD3zqUX9rp+wJJpSzmq
        MPsfESMH8jXrVUd99fps/XlPug==
X-Google-Smtp-Source: ABdhPJzVoAKWMvinAua02fba0iow8ESJoWh/Us36b096hU0GKxEVwCAuIfYhSncgj0pJuEGPMW/GBA==
X-Received: by 2002:a17:902:7687:b029:d2:8d1f:1079 with SMTP id m7-20020a1709027687b02900d28d1f1079mr644542pll.2.1601938446076;
        Mon, 05 Oct 2020 15:54:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 204sm1026392pfz.74.2020.10.05.15.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 15:54:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH] MAINTAINERS: Change hardening mailing list
Date:   Mon,  5 Oct 2020 15:53:20 -0700
Message-Id: <20201005225319.2699826-1-keescook@chromium.org>
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
the MAINTAINTERS file and the .mailmap to accomplish this, so that
linux-hardening@ can be treated like any other regular upstream kernel
development list.

Link: https://lore.kernel.org/linux-hardening/202010051443.279CC265D@keescook/
Link: https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Get_Involved
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I intend to include this in one of my trees, unless akpm or jon want it?
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
index adc4f0619b19..44d97693b6f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7216,7 +7216,7 @@ F:	drivers/staging/gasket/
 GCC PLUGINS
 M:	Kees Cook <keescook@chromium.org>
 R:	Emese Revfy <re.emese@gmail.com>
-L:	kernel-hardening@lists.openwall.com
+L:	linux-hardening@lists.openwall.com
 S:	Maintained
 F:	Documentation/kbuild/gcc-plugins.rst
 F:	scripts/Makefile.gcc-plugins
@@ -9776,7 +9776,7 @@ F:	drivers/scsi/53c700*
 LEAKING_ADDRESSES
 M:	Tobin C. Harding <me@tobin.cc>
 M:	Tycho Andersen <tycho@tycho.pizza>
-L:	kernel-hardening@lists.openwall.com
+L:	linux-hardening@lists.openwall.com
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git
 F:	scripts/leaking_addresses.pl
-- 
2.25.1

