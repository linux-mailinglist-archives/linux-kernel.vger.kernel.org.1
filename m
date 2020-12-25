Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F85E2E2C38
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgLYUUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgLYUUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:20:41 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C1AC061757
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:01 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i18so4584430ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S0zr3fTuUqiNGvEc+A9Rfuoi49EyUiS13ifcKBRykhY=;
        b=S3ClbGJA9pITO3xio1x0UGDXDYUckWojsj0v+GVZtfThk1s7fkk/k8fy7TJvvNlDIo
         RKN3F/qpKPvMGGNP20ihAI3P7lbs4kPwhsO0lw5Exg0ziZs9nO5T5t0mJ1XithMTknI4
         GgBLHHJPMR3FnCxvs0zZJKIcXgG1mtNiSUCeud0hMAMry0hfsUCwKwGW97jct72HMn1C
         wsJxCV9VFOZUmy8XOGmQpe1HUgDxCpTcydcZ5ItAEoPoApwC5o7WkeGbfsCVcgyRunqy
         vhI3VNUdo0HcZiPOmJF+rbTMPeZy4nS/La9zpruHKqMloLLNuW6oBr3r8AniDMBSvIm3
         4nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S0zr3fTuUqiNGvEc+A9Rfuoi49EyUiS13ifcKBRykhY=;
        b=kRvkiCJZCD+s2F5Bz3n828MobMpTWTauP2ieDHm3zZHAyCqpmWh+c7xj6l7gCuFNM6
         YHC7thqY6MP0f27MuFgx5D0zTpJORSTYafxtq3oQjjdnNpVhyGfZl60THcMmfAPTNkGq
         c70N4LdIP5o5hbhqNapqeHmZkaoAD6v27lyAzjKiLL/zbawcksZy50SogYYuEt7JeN80
         rJEn1sb8HFhk0/7hU/pSERPnrxn+FSE+o56evafSwOrPF2H5Zbk3joGQeZIJuieZoRnc
         nholEZhtUWHmmIw7eBE15kTjg2I/sQ2GC8kk785MIJNu6quMAqNnyrt7p4dCO4P9qt7D
         J4Iw==
X-Gm-Message-State: AOAM531h/iJVmbBSuszrgN2Dz0bvpmTihNGUnW/2t64Hqu4lDsujI8f7
        4QYmiKWOfOEy9yTdFn4G+wwOzRJ1jqiixw==
X-Google-Smtp-Source: ABdhPJwRAPTGs5f/3oZBqMZL9wACOECWJ/0j1T2DpKTbkLTdMqA728YywwjAibwFsUG6tpzid3P0FQ==
X-Received: by 2002:a05:6638:5b2:: with SMTP id b18mr30680204jar.69.1608927599421;
        Fri, 25 Dec 2020 12:19:59 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:19:58 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 00/19] dynamic debug diet plan
Date:   Fri, 25 Dec 2020 13:19:25 -0700
Message-Id: <20201225201944.3701590-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, we're mostly overeating, but we can all look forward to a diet
in January.  And more exersize.

dyndbg's compiled-in data-table currently uses 56 bytes per prdebug;
this includes 3 pointers to hierarchical "decorator" data, which is
primarily for adding "module:function:line:" prefixes to prdebug
messages, and for enabling and modifying those prdebugs selectively.

This patchset decouples "decorator" data, and makes it optional, and
disposable.  By separating that data, it opens up possiblities to
compress it, swap it out, map it selectively, etc.


In more detail, patchset does:

1- split struct _ddebug in 2, move "decorator" fields to _ddebug_callsites.

while this adds a pointer per site to memory footprint, it allows:

a- dropping decorations and storage, for some use cases.
   this could include DRM:
   - want to save calls to drm_debug_enabled()
   - use distinct categories, can map to format-prefixes, ex: "drm:kms:"
   - don't need "module:function:line" dynamic prefixes.
   - dont mind loss of info/context in /proc/dynamic_debug/control

b- ddebug_callsites[] contents are hierarchical, compressible.
c- ddebug_callsites[] in separate section is compressible as a block.
d- for just enabled prdebugs, could allocate callsites and fill from zblock.

2- make ddebug_callsites optional internally.
   This lets us drop them outright, for any reason, perhaps memory pressure.

3- allow dropping callsites by those users.
   echo module drm +D > /proc/dynamic_debug/control
   this doesnt currently recover __dyndbg_callsites storage

4- drop _ddebug.site, convert to _ddebug[N].property<x> lookup.
   RFC is mostly here.

rev1: https://lore.kernel.org/lkml/20201125194855.2267337-1-jim.cromie@gmail.com/

rev2 differs by dropping zram attempt, making callsite data optional, etc.


Jim Cromie (19): against v5.10

  dyndbg: fix use before null check
1 dyndbg: split struct _ddebug, move display fields to new
    _ddebug_callsite
    
2 dyndbg: refactor part of ddebug_change to ddebug_match_site
  dyndbg: accept null site in ddebug_match_site
  dyndbg: hoist ->site out of ddebug_match_site
  dyndbg: accept null site in ddebug_change
  dyndbg: accept null site in dynamic_emit_prefix
  dyndbg: accept null site in ddebug_proc_show
  
  dyndbg: optimize ddebug_emit_prefix
  dyndbg: avoid calling dyndbg_emit_prefix when it has no work
  
3 dyndbg: refactor ddebug_alter_site out of ddebug_change
  dyndbg: allow deleting site info via control interface
  
4 dyndbg: verify __dyndbg & __dyndbg_callsite invariant
  dyndbg+module: expose dyndbg_callsites to modules
  dyndbg: add ddebug_site_get/put api with pass-thru impl
  dyndbg: ddebug_site_get/put api commentary
  dyndbg: rearrange struct ddebug_callsites
  dyndbg: add module_index to struct _ddebug
  dyndbg: try DEFINE_DYNAMIC_DEBUG_TABLE

 drivers/gpu/drm/i915/i915_drv.c   |   3 +
 include/asm-generic/vmlinux.lds.h |   4 +
 include/linux/dynamic_debug.h     |  97 ++++++++---
 kernel/module-internal.h          |   1 +
 kernel/module.c                   |   9 +-
 lib/dynamic_debug.c               | 271 +++++++++++++++++++++---------
 6 files changed, 283 insertions(+), 102 deletions(-)

-- 
2.29.2

