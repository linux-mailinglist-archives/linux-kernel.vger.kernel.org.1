Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D418928BED7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404070AbgJLRMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403884AbgJLRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:12:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1F4C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:12:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id u8so24272369ejg.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HRzR7+kCYLtxvcWWyR+9mvbAFuN88fj9J1guKXhLosA=;
        b=QLdY9ZuC2fXdfjZcorb8t6RJT5/l/S8H1g7pNajMFBmztyPlRehWfkubxPB4OGkPKC
         a623ooyaCEV+lN7jBrlRLYcy9UOwNpXx+N3QiYa89LS0wApu72T1fP//sZGVPZJDGgiJ
         bvNFybkUjY2TqrEp4hua+Gw7xF6btx0ltXJWL/1vnV924GDxlSmVKdsfKumkXM6+Yp/6
         pjR2bXr2Y1M7b4WO8u1K5M0kt5PXHqaQzttlKe60RgYSNJGoNxZQv6tC4RoBW5QFG2wA
         Yzl8pdZpJe2oufagatD+fSLEYAnJ5b/R9Wo31ME7P63ozJyzxRXVoCjNOubMhiWywz1Q
         +Ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=HRzR7+kCYLtxvcWWyR+9mvbAFuN88fj9J1guKXhLosA=;
        b=JruAJhjTWVuMONFqybaQ1pT+mBGBjTGWx3fQmm4DDmjuCQgAL6E5Du13PY/jsr26QX
         yTFDyRoF2v8ztSdgVqJKlCKUfQISRfWBy0LoHiuamBUKXz5T8JAuz3UX0G1Lc6kNOuyS
         bUca39zufeXncFuQObwnP0M7zZ23EzgUJRslvIjfQNyWc4e4W4PaQmtHvHyLi5GD/BwR
         Z10WztsBrAnClZN7zkU9Ni2OJodiE0H3Z1yOOlh/v1sYr9FMiAYwfxuuaFwNiSgkMJmS
         1xFaA+pXxvKvB9YpU/e1sUNJXrplHh7MJHX3GbzsUeBh9VXd7EXwxnB0PdHx4qsFBmYd
         EiGw==
X-Gm-Message-State: AOAM533hlP5NrzepjAZyI2o90gPTk0BK1MCRzeg7aszlThj82w+KJH9I
        6dsJ+XseF9KePGBpZhf4VRM=
X-Google-Smtp-Source: ABdhPJwKtI1Tytf37tYQagM2DBjRjOC/OvD61Nj+HoWFB0YxQJQhhmFMokz1g3LPw6PmKK8K2oAGwQ==
X-Received: by 2002:a17:906:640d:: with SMTP id d13mr28385407ejm.223.1602522720884;
        Mon, 12 Oct 2020 10:12:00 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id g9sm10833510edv.81.2020.10.12.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 10:12:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 19:11:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] x86/kaslr changes for v5.10
Message-ID: <20201012171158.GA2831196@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/kaslr git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kaslr-2020-10-12

   # HEAD: 76167e5c5457aee8fba3edc5b8554183696fc94d x86/kaslr: Replace strlen() with strnlen()

This tree cleans up and simplifies the x86 KASLR code, and
also fixes some corner case bugs.

 Thanks,

	Ingo

------------------>
Arvind Sankar (22):
      x86/kaslr: Make command line handling safer
      x86/kaslr: Remove bogus warning and unnecessary goto
      x86/kaslr: Fix process_efi_entries comment
      x86/kaslr: Initialize mem_limit to the real maximum address
      x86/kaslr: Fix off-by-one error in __process_mem_region()
      x86/kaslr: Drop redundant cur_entry from __process_mem_region()
      x86/kaslr: Eliminate 'start_orig' local variable from __process_mem_region()
      x86/kaslr: Drop redundant variable in __process_mem_region()
      x86/kaslr: Drop some redundant checks from __process_mem_region()
      x86/kaslr: Fix off-by-one error in process_gb_huge_pages()
      x86/kaslr: Short-circuit gb_huge_pages on x86-32
      x86/kaslr: Simplify process_gb_huge_pages()
      x86/kaslr: Drop test for command-line parameters before parsing
      x86/kaslr: Make the type of number of slots/slot areas consistent
      x86/kaslr: Drop redundant check in store_slot_info()
      x86/kaslr: Drop unnecessary alignment in find_random_virt_addr()
      x86/kaslr: Small cleanup of find_random_phys_addr()
      x86/kaslr: Make minimum/image_size 'unsigned long'
      x86/kaslr: Replace 'unsigned long long' with 'u64'
      x86/kaslr: Make local variables 64-bit
      x86/kaslr: Add a check that the random address is in range
      x86/kaslr: Replace strlen() with strnlen()


 arch/x86/boot/compressed/kaslr.c | 238 +++++++++++++++++----------------------
 arch/x86/boot/compressed/misc.h  |   4 +-
 2 files changed, 107 insertions(+), 135 deletions(-)
