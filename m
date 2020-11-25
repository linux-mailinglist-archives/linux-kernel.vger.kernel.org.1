Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC89E2C488A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgKYThk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgKYThb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:37:31 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F297AC061A51
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:37:24 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id m9so3252707iox.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kvaPSRJY7Wr+XTGZOilxIQoBZMtArG1tAWxocteVnYY=;
        b=Kumbp0V4EzoxbFOpFkMzx33Q0lHEl7NAKxIz7UZ9Zpu6hd8NylGG+hsoBDpFjuMYA0
         CJ6sXrCJVglW8hD3wC+p7KjSIiMgVKtI7b3Qhxgo2CL2oEM5kGLhDsTeqUkE/mYxtxVF
         H5LzkuE3obnUYi4yX5YYqknyVPBxzJyxPS9wW6PhRjZBup7qFqg1QLMLUgJVkf2WRoS/
         p5fNrwYcz+cvSPoDFHPXzt4YxpEO/xltiX2ICpMOwcahS9XHrv8QOsYJoGrK5DkUB3RI
         V1LZ136Kby0M7hb4g/xG5+ifqMcjsnDPzvpRwSRPhWwVygYbxFtB6wz7e+8cz5R8XgNq
         HkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kvaPSRJY7Wr+XTGZOilxIQoBZMtArG1tAWxocteVnYY=;
        b=Y5124Gf1mxoital2TxR12dZX5T49uDlnRYI6Q6oN0zf8V1DW8euZOwbWheFsouJJi3
         RXJwap4GxB9sfRalNbfUFBhTHwr+B3eIC7WhSo2eAc7zd4qwpNqnRLdbIuc0dOUX2iTZ
         2hE+KaXoN9ZUyql1pwdfChYNbXjtdcqN1kRRyz+NCJrf5O3k7d8Um8Gsjwa/wX5Yv6xP
         +wlAFpoTv1AHdZPDAcJpH6hZ2wVD/gx30PYLtMEluwht8tt5qjgUWplAKHnHThWr5fIg
         zYfYlDSx/9RzAyb8Z/wgTRC7eMS8iwFvQgATgnY8CDaxjaTluWCC3+96t+bLRgGkuT00
         chxg==
X-Gm-Message-State: AOAM531HVgEY5x7K2kkfxaY/TBBNx/wb/wHmM+lPHMcgFDZg2bmxzH4n
        qxSSy9czKLly6PVpQS7pzRWD0zxJSUNVVg==
X-Google-Smtp-Source: ABdhPJzvhTups6o4RaesshRE+4F+KrQk7RXYpT05c6z88d9eM+S/aWGJQpGrQ5JTCPqf2suE4OVe0Q==
X-Received: by 2002:a02:82cb:: with SMTP id u11mr4844619jag.0.1606333044377;
        Wed, 25 Nov 2020 11:37:24 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id f8sm1435548ioc.24.2020.11.25.11.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:37:23 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-mm@kvack.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Changbin Du <changbin.du@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] dyndbg: select ZPOOL,ZS_MALLOC in Kconfig.debug DYNAMIC_DEBUG_CORE
Date:   Wed, 25 Nov 2020 12:36:23 -0700
Message-Id: <20201125193626.2266995-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201125193626.2266995-1-jim.cromie@gmail.com>
References: <20201125193626.2266995-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dyndbg will next need zs_malloc and friends, so add config reqs now,
to maybe avoid churny remakes later.

ZPOOL,ZSMALLOC are now required for DYNAMIC_DEBUG_CORE, as theyre
needed to get value (mem use reduction) from the upcoming
dyndbg/callsite split.

---

ZS_MALLOC is done with "depends on" instead of "select" to break a
recursive dependency.  I think this doesnt quite sort things out for
other config permutations, TBD.

-v2 fixup -> _CORE
Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/Kconfig.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c789b39ed527..7eb7b43037d9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -170,6 +170,8 @@ config DYNAMIC_DEBUG_CORE
 	bool "Enable core function of dynamic debug support"
 	depends on PRINTK
 	depends on (DEBUG_FS || PROC_FS)
+	select ZPOOL
+	depends on ZSMALLOC
 	help
 	  Enable core functional support of dynamic debug. It is useful
 	  when you want to tie dynamic debug to your kernel modules with
-- 
2.28.0

