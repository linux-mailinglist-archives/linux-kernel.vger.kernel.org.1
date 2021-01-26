Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF33B304571
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392381AbhAZRgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389581AbhAZHlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:41:35 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AECCC06178C;
        Mon, 25 Jan 2021 23:25:37 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id e9so1719007pjj.0;
        Mon, 25 Jan 2021 23:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk9pnNZ5obD/T8QA79mJUHCuyWkqUdM0WLfHz7cSxhY=;
        b=icuaSu5b5dkKvThQ806mLAEJSkPlLpNO9y8UmyIeofHWS1yvzn5DlTyUdyuN4j0Cwb
         SxNOrXtlz+5BIAgjBZonMVuUGnatpy3t4Vnz0R5bbcMZhbZR9l37jaoaBFgyf74Ut/Xl
         RjHH/SX5+tyvQivGtljcG60KWtdUq/DPCz2c+txer8mhR/vq+ei9YyzOsAGXjMDEzJFA
         zq81/ZYi9kyLFeuS0rt1VZOsiZb0xjuXvxFugV0oZAwuRmlhCgyGXQonV6zgV8Uigy/R
         bZJ2QJmOfjocpQAftOBS/5rz6fDpOQvSrOiztXeNx62SmUtQtK5ZyTQl0z8ZuvpnZq/L
         luhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk9pnNZ5obD/T8QA79mJUHCuyWkqUdM0WLfHz7cSxhY=;
        b=mQAj673XH8C9j0oC48Xj+upjXmoG79zD2UZvp+dnO03On0yEB7EMKZqvLgtULCTxJm
         vVa0fibvSYPaMsMOaw5oq73BZOCsfLJss/ja/BPWaytv8qbr2LhB4RRyYEbBYdUR67vO
         lnNSljHd890icRgOUrfTJaLrK2aK9Sk6kHhFXy0x54ta4CQ/C9a/WdEDlCRWfsPY3eho
         iixp+Ebk9qYs05RRHy3cEhx/EXQjPUW31raNcgXGlWPOZIACedtb26ZZu+KIR3QvReA1
         T6fjXeboM5NVIWeiunnqk884kVL2vqSP2jpFh7mqCXFjEc1MduHNplUhtkboBMvyNwZp
         M2fA==
X-Gm-Message-State: AOAM532mxjuHN3YXCP3KyUTs9NGo8qL1xr9ptlsmMnRjuwfBxZoRIMrv
        II6KXXofPL6YRz8AXRk7H/Sre8cZ1QVycHlFe44=
X-Google-Smtp-Source: ABdhPJwKC6IX/fdEW11McnaCen0feEyxJxbPbpVxW3S7ZskO8Lh9gugPBLBkp+AsjjHU86XmMLub2w==
X-Received: by 2002:a17:90a:448f:: with SMTP id t15mr4831030pjg.159.1611645936956;
        Mon, 25 Jan 2021 23:25:36 -0800 (PST)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l12sm1320256pjg.54.2021.01.25.23.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 23:25:36 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     corbet@lwn.net, vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] docs: path-lookup: no get_link()
Date:   Tue, 26 Jan 2021 15:24:40 +0800
Message-Id: <20210126072443.33066-10-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126072443.33066-1-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no get_link() anymore. we have step_into() and pick_link().

walk_component() will call step_into(), in turn call pick_link,
and return symlink name.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 8572300b5405..915c9ffe22c1 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1106,12 +1106,10 @@ doesn't need to notice.  Getting this ``name`` variable on and off the
 stack is very straightforward; pushing and popping the references is
 a little more complex.
 
-When a symlink is found, ``walk_component()`` returns the value ``1``
-(``0`` is returned for any other sort of success, and a negative number
-is, as usual, an error indicator).  This causes ``get_link()`` to be
-called; it then gets the link from the filesystem.  Providing that
-operation is successful, the old path ``name`` is placed on the stack,
-and the new value is used as the ``name`` for a while.  When the end of
+When a symlink is found, ``walk_component()`` calls ``pick_link()``,
+it then gets the link from the filesystem returning new path ``name``.
+Providing that operation is successful, the old path ``name`` is placed on the
+stack, and the new value is used as the ``name`` for a while.  When the end of
 the path is found (i.e. ``*name`` is ``'\0'``) the old ``name`` is restored
 off the stack and path walking continues.
 
-- 
2.30.0

