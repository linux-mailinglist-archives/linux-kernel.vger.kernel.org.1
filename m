Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C242D2444
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgLHHWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLHHWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:22:05 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A74C061794
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 23:21:25 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id e13so13597151qvl.19
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 23:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=5FaheHz7vxhPJh5+cv83N5dJ1ZDX5NnpP7PL3kzvlXI=;
        b=UaObGW572S5cABuocxvccGtN+hEYLn84NAh7cRa/1ir/UOBVqu8Yh+TZ0KmXHKAd9h
         orTKXdrU5Xcodr/JiTGmGb9ad83G+Wdly3EnSHCjdspUkP2+TUwbPfriGDqUNT+zo6jD
         a+A1XV/n0FJ1dyYoq+XcuV+XjPRvQ8ju55AGF0orAiJ2DV3QWC0fqfrf2cfB5MHP57SM
         JYJ9WTl4+bVaR4wQT/HgPrrWLx9GS518wbNKeszhzecm4wUMzmlRrx6GQJr9xWsh4xT3
         fG10ntXz+tObbOdcvBX7hyKII5YYrvav0VpsbEZ0v+vHzV3bRJTmGXIYGDEymnU8Jt5h
         k88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=5FaheHz7vxhPJh5+cv83N5dJ1ZDX5NnpP7PL3kzvlXI=;
        b=EWMvgFNeTcBhyFwB5J7O8mTXrwj/0W3VCgvmKxnggh60I/lBmQ7/NFPwDCD1YBpB6a
         NiabnVAJPVNpt/ImZyk7B8LOth16+7u1cEOea18WiYET/PMs3D3Po0qfPbYCmG17kbPG
         xJwA6vwTplmg10ayQ6r6Nqv5HhpOhhiuyIYKyKRm9ZpVwvS+BmfoMlWZK79wONsRPRZO
         8CPdQE465eHlf/V4M0mWsVUZa6U6JBhH2H5Z3wluc64ulwrhbZL+dC7IX7e5QMO2vpC5
         3pqckbEfBviRrNFJzWbTC67SamCCYZhGqLSORpBppw3XYwdWzDfOnjQsHexpUbYNKmqY
         2hOw==
X-Gm-Message-State: AOAM530Wk17M7UtV3mWygmIDExoQfFwav0NQOe3lIhqbhzFV+dSbu9rd
        2bsdMAr2IeYRiDE9AGAjV42ryweEj6tXLVa8sH1CaRNgnSsoAigSOa50iDFHgGaAK8c2ZzIjDmR
        YaSb7QzyJof3K+UQ5Bgg63V4xR4sbxAl628IVcXy0Ynw1XtGoEwETXWHbllMtbdzzNrjDgAdM
X-Google-Smtp-Source: ABdhPJxPYBBQb4W2rVkhIhrfuaGMZIYqXpbnQdiz8G3Ue26WR8SLvGjTksb1IkNoUD/Tpb3dZF6aCp7LZj+q
Sender: "gthelen via sendgmr" <gthelen@gthelen.svl.corp.google.com>
X-Received: from gthelen.svl.corp.google.com ([2620:15c:2cd:202:8edc:d4ff:fe33:9605])
 (user=gthelen job=sendgmr) by 2002:a0c:8d47:: with SMTP id
 s7mr25470245qvb.17.1607412084369; Mon, 07 Dec 2020 23:21:24 -0800 (PST)
Date:   Mon, 07 Dec 2020 23:21:19 -0800
In-Reply-To: <20201208034157.9KFja%akpm@linux-foundation.org>
Message-Id: <xr93o8j4kbkg.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20201208034157.9KFja%akpm@linux-foundation.org>
Subject: Re: + revert-mm-filemap-add-static-for-function-__add_to_page_cache_locked.patch
 added to -mm tree
From:   Greg Thelen <gthelen@google.com>
To:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        mkubecek@suse.cz, jrdr.linux@gmail.com, josef@toxicpanda.com,
        jmforbes@linuxtx.org, daniel@iogearbox.net, ast@kernel.org,
        alex.shi@linux.alibaba.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@linux-foundation.org wrote:

> The patch titled
>      Subject: revert "mm/filemap: add static for function __add_to_page_cache_locked"
> has been added to the -mm tree.  Its filename is
>      revert-mm-filemap-add-static-for-function-__add_to_page_cache_locked.patch
>
> This patch should soon appear at
>     https://ozlabs.org/~akpm/mmots/broken-out/revert-mm-filemap-add-static-for-function-__add_to_page_cache_locked.patch
> and later at
>     https://ozlabs.org/~akpm/mmotm/broken-out/revert-mm-filemap-add-static-for-function-__add_to_page_cache_locked.patch
>
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
>
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
>
> The -mm tree is included into linux-next and is updated
> there every 3-4 working days
>
> ------------------------------------------------------
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: revert "mm/filemap: add static for function __add_to_page_cache_locked"
>
> Revert 3351b16af494 ("mm/filemap: add static for function
> __add_to_page_cache_locked") due to build issues with
> CONFIG_DEBUG_INFO_BTF=y.
>
> Link: https://lkml.kernel.org/r/CAADnVQJ6tmzBXvtroBuEH6QA0H+q7yaSKxrVvVxhqr3KBZdEXg@mail.gmail.com
> Cc: Michal Kubecek <mkubecek@suse.cz>
> Cc: Justin Forbes <jmforbes@linuxtx.org>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Thanks.

Tested-by: Greg Thelen <gthelen@google.com>

> ---
>
>  mm/filemap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/mm/filemap.c~revert-mm-filemap-add-static-for-function-__add_to_page_cache_locked
> +++ a/mm/filemap.c
> @@ -827,7 +827,7 @@ int replace_page_cache_page(struct page
>  }
>  EXPORT_SYMBOL_GPL(replace_page_cache_page);
>  
> -static noinline int __add_to_page_cache_locked(struct page *page,
> +noinline int __add_to_page_cache_locked(struct page *page,
>  					struct address_space *mapping,
>  					pgoff_t offset, gfp_t gfp,
>  					void **shadowp)
> _
>
> Patches currently in -mm which might be from akpm@linux-foundation.org are
>
> revert-mm-filemap-add-static-for-function-__add_to_page_cache_locked.patch
> kthread_worker-document-cpu-hotplug-handling-fix.patch
> mm.patch
> mm-remove-the-unuseful-else-after-a-return-checkpatch-fixes.patch
> mm-prevent-gup_fast-from-racing-with-cow-during-fork-checkpatch-fixes.patch
> mm-swap_state-skip-meaningless-swap-cache-readahead-when-ra_infowin-==-0-fix.patch
> mm-vmallocc-__vmalloc_area_node-avoid-32-bit-overflow.patch
> mm-cma-improve-pr_debug-log-in-cma_release-fix.patch
> mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
> lib-cmdline_kunit-add-a-new-test-suite-for-cmdline-api-fix.patch
> ilog2-improve-ilog2-for-constant-arguments-checkpatch-fixes.patch
> lib-test_bitmapc-add-for_each_set_clump-test-cases-checkpatch-fixes.patch
> checkpatch-fix-typo_spelling-check-for-words-with-apostrophe-fix.patch
> resource-fix-kernel-doc-markups-checkpatch-fixes.patch
> linux-next-rejects.patch
> kmap-stupid-hacks-to-make-it-compile.patch
> init-kconfig-dont-assume-scripts-lld-versionsh-is-executable.patch
> set_memory-allow-set_direct_map__noflush-for-multiple-pages-fix.patch
> arch-mm-wire-up-memfd_secret-system-call-were-relevant-fix.patch
> kernel-forkc-export-kernel_thread-to-modules.patch
