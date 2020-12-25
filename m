Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A982E2C42
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgLYUVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbgLYUVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:37 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC2CC0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:30 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id t8so4545403iov.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OPo22U6WOTLetWvxILNxNSm71si4B10ucSyJCbCim4A=;
        b=R0iTefIBIBYP7eRYj8TLw/gKB+FmShSQhjrRYO3QjNI1MJ5NPiCSPbd3tfzMAGbzVU
         /xCuZVCIIP8ZrsR5G17kKb2tNRV96H3Km79TqeQWQgAqTizPdtKj500EyVv9QU+ZiMyo
         /fxNC1r0ZLArs+wsAz+CiuflzI+IIwcxCv7dxTX+PuAGtOpahH8wCNMerYJC6r1hwX1Z
         ICqCaQpbk/NNSKCpMwiF374OHvseQvqyRAU/LfSYSv1bOKT3WKyvuf9/Vs0HHmtSeVQO
         AjmCOg/sVryEb6g50nGElfUaG9jF5RBOMLU1tPKV91vSwh60SOwNEq/14AqdINqCSzhj
         hHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPo22U6WOTLetWvxILNxNSm71si4B10ucSyJCbCim4A=;
        b=HVcb85REIptEMI8u98DSd92iEFxkxeJYE2sHa1hXOB80dhD9OhuIOiYc3n7QMRiwhX
         er0+C2mL0ZTKMm/GAF9TajexjpQYDCrH4X32NIB8AS/CWx4BdUqvw4ox5/6w6IaLhYIB
         w/1FWq8a1iNRXcmDYff86mymUhUvJA3HsboKXr1qJLlQB1k/tSq6EWMRG/GwNSQiG42Z
         N2iHNNAaX8sVCVjBF3XJyfiEl3XjOm20bUue/6T3rcUZCDXKXFAUqpt84WLzB+zKBqxv
         QB3evf8D96USlihrjsd2Jvle2RkMFHIeBtUZZMORHph3mXJUViAr3eEu+aA3K6CKwngh
         rXBA==
X-Gm-Message-State: AOAM532YbGgodhO/M628ol7AENQRXAaZ9tsrBGZis84LNpXKm9NlUvqF
        0IWGS/jK1NdQ1SnRrECkxPI=
X-Google-Smtp-Source: ABdhPJysMl97789VxqzuNP2sd+S9H/EKFfpk+CqxufmT36IaWnqlXNgOUImQCaoatxEHDjhz1cpO4Q==
X-Received: by 2002:a02:cba7:: with SMTP id v7mr30188486jap.133.1608927629487;
        Fri, 25 Dec 2020 12:20:29 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:28 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 16/19] dyndbg: ddebug_site_get/put api commentary
Date:   Fri, 25 Dec 2020 13:19:41 -0700
Message-Id: <20201225201944.3701590-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paths forward: (not mutually exclusive)

A: !site -> fill from backing store

1st try at this is/was using zram.  At init, it copied each callsite
into a zs-allocation, and all site-> refs afterward went thru
_get/_put to zs-map on demand, and zs-unmap the site info.  This
worked until I tried to keep callsites mapped while they're enabled.

Another approach is to compress the new linker section, using some
algo thats good at indexed decompression.  I tried to test this a bit,
using objcopy, unsuccessfully:

   objcopy --dump-section __dyndbg_callsites=dd_callsites vmlinux.o

From vmlinux.o it was mostly empty, vmlinux didnt have the section.

B: callsite as a set of property vectors, indexed by 'N'

We know dp is in a vector, either in the builtin __dyndbg_callsite
linker section, or the same from a modprobed one.  The builtin section
has all builtin module sub-sections catenated dogether.

At init, we iterate over the section, and "parse it" by creating a
ddebug_table for each module with prdebugs.  ddebug_table.num_debugs
remembers the size of each modules' vector of prdebugs.

We need a few things:

- _ddebug.index field, which knows offset to start of this sub-vector.
  this new field will be "free" because the struct has padding.
  it can be initialized during init, then RO.

- a back-pointer at the beginning of the sub-vector, to the
  ddebug_table "owning" (but not containing) this sub-vector of
  prdebugs.

If we had both, we could get from the ddebug element to its vector
root, back up to the owning ddebug_table, then down to the _callsite
vector, and index to the right element.  While slower than a pointer
deref, this is a cold path, and it allows elimination of the
per-callsite pointer member, thus greater density of the sections, and
still can support sparse site info.

That back-pointer feels tricky.  It needs to be 1st in the sub-vector

is to reserve the 0th slot

ing its spot at the
front of

each module's ddebug sub-vector.

getting space in the
section for it.  Initializing it is easy.

prdebugs are added to section when DECLARE_DYAMIC_DEBUG_METADATA is
compiled; its unclear whether they are intrinsically sorted during
compile, or whether thats a linker thing.

Ideally, a MODULE-mumble declaration can be coaxed into declaring a
module singleton in the section(s), either naturally at the top (or
bottom) or sorted into place.

If that doesn't work, a "preload if module is different" strategy
could maybe work, but I dont know how to do that in macros.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 25f49515c235..ec28c113a361 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -146,7 +146,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 
 static struct _ddebug_callsite *ddebug_site_get(struct _ddebug *dp)
 {
-	return dp->site;
+	return dp->site; /* passthru abstraction */
 }
 static inline void ddebug_site_put(struct _ddebug *dp)
 {
-- 
2.29.2

