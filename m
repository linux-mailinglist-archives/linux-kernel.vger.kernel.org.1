Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C04278F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgIYROj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgIYROj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:14:39 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EA1120936;
        Fri, 25 Sep 2020 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601054078;
        bh=7c+/aUouCIhoN252DDnGiTWe7TCcYqeUOpv/kSATLnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSPeDBr/ecinZYSW7vpLj0gvkqUSIwBNrJfA6D5cocctOSaQJjZyEB/SnvMKIBK4I
         KliHOxRuNSYe38uf9DFlJB1WISvWQsOuoed2WmFWztHS/IfWy0TNySvJ4KEeO75IuS
         rBTp4EZEJ1PoynYjx97qnevzUuIfetiQBwR7ew8s=
Date:   Fri, 25 Sep 2020 10:14:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix uninit-value in f2fs_lookup
Message-ID: <20200925171436.GC3315208@gmail.com>
References: <20200925151926.2658-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925151926.2658-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:19:26PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> As syzbot reported:
> 
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x21c/0x280 lib/dump_stack.c:118
>  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
>  __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:219
>  f2fs_lookup+0xe05/0x1a80 fs/f2fs/namei.c:503
>  lookup_open fs/namei.c:3082 [inline]
>  open_last_lookups fs/namei.c:3177 [inline]
>  path_openat+0x2729/0x6a90 fs/namei.c:3365
>  do_filp_open+0x2b8/0x710 fs/namei.c:3395
>  do_sys_openat2+0xa88/0x1140 fs/open.c:1168
>  do_sys_open fs/open.c:1184 [inline]
>  __do_compat_sys_openat fs/open.c:1242 [inline]
>  __se_compat_sys_openat+0x2a4/0x310 fs/open.c:1240
>  __ia32_compat_sys_openat+0x56/0x70 fs/open.c:1240
>  do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
>  __do_fast_syscall_32+0x129/0x180 arch/x86/entry/common.c:139
>  do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
>  do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
>  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> 
> In f2fs_lookup(), @res_page could be used before being initialized,
> because in __f2fs_find_entry(), once F2FS_I(dir)->i_current_depth was
> been fuzzed to zero, then @res_page will never be initialized, causing
> this kmsan warning, relocating @res_page initialization place to fix
> this bug.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/dir.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 703cf8e21fc0..83630341ffa3 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -357,16 +357,15 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>  	unsigned int max_depth;
>  	unsigned int level;
>  
> +	*res_page = NULL;
> +
>  	if (f2fs_has_inline_dentry(dir)) {
> -		*res_page = NULL;
>  		de = f2fs_find_in_inline_dir(dir, fname, res_page);
>  		goto out;
>  	}
>  
> -	if (npages == 0) {
> -		*res_page = NULL;
> +	if (npages == 0)
>  		goto out;
> -	}
>  
>  	max_depth = F2FS_I(dir)->i_current_depth;
>  	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {

Can't the assignment to *res_page below be removed too?

        for (level = 0; level < max_depth; level++) {
                *res_page = NULL;
                de = find_in_level(dir, level, fname, res_page);
                if (de || IS_ERR(*res_page))
                        break;
        }
