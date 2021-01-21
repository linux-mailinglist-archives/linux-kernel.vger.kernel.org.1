Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB6B2FF7C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbhAUWNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbhAUWMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:12:54 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E62C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:12:13 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b26so4760669lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KPxlu742QoNGnQZoUKH6S6ca6SSajmjdRBKvsB2jv0M=;
        b=dESmoQhs98S5Ou6yaIItbvtAvGEoEPqdikbXZMH8QGsJssGlFovF04uBay1bRtXIRM
         4+aGwoksykql2vSCknaWlEtMPKN5GqI1jbIP3PmKHZwr1tMUjZgDMBzIn6mP21RnPQZ+
         zXIS2+3f9aAsVPOeIzgme2afzcTLmPRktVwWJ5HCC7/xMmXqrYLySjEq6vRNOd+DHCe5
         pWUZRzIpSyL2FJ0efKDFW8FmnFA5UgvKSUvNhvo5QAlAPuINE+czO1bE51YvdlFOsF1t
         EJIm6ci1aWbMigCWvTMAQPfcPFedjGP8U35l4sRnRojuRoPbZIVFbphTkmnYXHqrh4i+
         /mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KPxlu742QoNGnQZoUKH6S6ca6SSajmjdRBKvsB2jv0M=;
        b=G/qALlvGmb7f8WqXxvtYZffNLekEZ/4sOQNHG1+mATNvC9FBSFgLGivi+2D9HFeq7o
         pyTQ+ksLprXmN3/HjllOpIWZ79CPGyIaHOhMyIznqu7abyd1MrCTM+9IZM1KEPjsl7jt
         tZhPKDjxh23X19M4h6Fr0iyMKFCZGUxM3Qulfv1TG7VucUVp4qKJwtCJKNDRwnzfwyka
         ppxS1Zte4dvjfmayGYPhstHwxISQiQpJTy+NeHHOSUy6WJTKo6P5vqYsyXYLvBosk9RS
         QcJyiOUhKFBLF9Ln6yTcpwwH48C/C5c4jPjXYT6dkHFFgJQj/13DQ7njTBuREBefogOX
         Di8A==
X-Gm-Message-State: AOAM533oGP4b5sWJjsY2h0t2SxqLMsMADH+BS0MpdCU/srVy+PjTn8cS
        5q3Q2qnBb3KQ0DY4lqBw47kw+ryYwDs=
X-Google-Smtp-Source: ABdhPJxORAKcC9MivVp3teMoKPjtf2B6k5ch5NMP6jCSATOyiB9A1bTOiBreR1wJy4VnJEdC9g5BVw==
X-Received: by 2002:ac2:4c2f:: with SMTP id u15mr615266lfq.163.1611267132091;
        Thu, 21 Jan 2021 14:12:12 -0800 (PST)
Received: from grain.localdomain ([5.18.91.94])
        by smtp.gmail.com with ESMTPSA id 187sm682689lfo.20.2021.01.21.14.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 14:12:10 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 6D8EB560134; Fri, 22 Jan 2021 01:12:07 +0300 (MSK)
Date:   Fri, 22 Jan 2021 01:12:07 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrey Vagin <avagin@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] prctl: allow to setup brk for et_dyn executables
Message-ID: <20210121221207.GB2174@grain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keno Fischer reported that when a binray loaded via
ld-linux-x the prctl(PR_SET_MM_MAP) doesn't allow to
setup brk value because it lays before mm:end_data.

For example a test program shows

 | # ~/t
 |
 | start_code      401000
 | end_code        401a15
 | start_stack     7ffce4577dd0
 | start_data	   403e10
 | end_data        40408c
 | start_brk	   b5b000
 | sbrk(0)         b5b000

and when executed via ld-linux

 | # /lib64/ld-linux-x86-64.so.2 ~/t
 |
 | start_code      7fc25b0a4000
 | end_code        7fc25b0c4524
 | start_stack     7fffcc6b2400
 | start_data	   7fc25b0ce4c0
 | end_data        7fc25b0cff98
 | start_brk	   55555710c000
 | sbrk(0)         55555710c000

This of course prevent criu from restoring such programs.
Looking into how kernel operates with brk/start_brk inside
brk() syscall I don't see any problem if we allow to setup
brk/start_brk without checking for end_data. Even if someone
pass some weird address here on a purpose then the worst
possible result will be an unexpected unmapping of existing
vma (own vma, since prctl works with the callers memory) but
test for RLIMIT_DATA is still valid and a user won't be able
to gain more memory in case of expanding VMAs via new values
shipped with prctl call.

Reported-by: Keno Fischer <keno@juliacomputing.com>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Dmitry Safonov <0x7f454c46@gmail.com>
CC: Andrey Vagin <avagin@gmail.com>
CC: Kirill Tkhai <ktkhai@virtuozzo.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
---
Guys, take a look please once time permit. Hopefully I didn't
miss something 'cause made this patch via code reading only.

Andrey, do we still have a criu container which tests new kernels,
right? Would be great to run criu tests with this patch applied
to make sure everything is intact.

 kernel/sys.c |    7 -------
 1 file changed, 7 deletions(-)

Index: linux-tip.git/kernel/sys.c
===================================================================
--- linux-tip.git.orig/kernel/sys.c
+++ linux-tip.git/kernel/sys.c
@@ -1943,13 +1943,6 @@ static int validate_prctl_map_addr(struc
 	error = -EINVAL;
 
 	/*
-	 * @brk should be after @end_data in traditional maps.
-	 */
-	if (prctl_map->start_brk <= prctl_map->end_data ||
-	    prctl_map->brk <= prctl_map->end_data)
-		goto out;
-
-	/*
 	 * Neither we should allow to override limits if they set.
 	 */
 	if (check_data_rlimit(rlimit(RLIMIT_DATA), prctl_map->brk,
