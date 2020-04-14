Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8D61A7744
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 11:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437614AbgDNJXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 05:23:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:45804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437562AbgDNJXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:23:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6AD76AEF5;
        Tue, 14 Apr 2020 09:23:37 +0000 (UTC)
Date:   Tue, 14 Apr 2020 11:23:37 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Muchun Song <songmuchun@bytedance.com>
cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, mingo@kernel.org, peterz@infradead.org,
        shile.zhang@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/unwind: Make some variables static
In-Reply-To: <20200413144727.51258-1-songmuchun@bytedance.com>
Message-ID: <alpine.LSU.2.21.2004141123030.6508@pobox.suse.cz>
References: <20200413144727.51258-1-songmuchun@bytedance.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020, Muchun Song wrote:

> The variables are local to the source and do not need to be
> in global scope, so make them static.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/x86/kernel/unwind_orc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index e9cc182aa97ee..0dbabc469ce2d 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -16,11 +16,11 @@ extern struct orc_entry __start_orc_unwind[];
>  extern struct orc_entry __stop_orc_unwind[];
>  
>  static DEFINE_MUTEX(sort_mutex);
> -int *cur_orc_ip_table = __start_orc_unwind_ip;
> -struct orc_entry *cur_orc_table = __start_orc_unwind;
> +static int *cur_orc_ip_table = __start_orc_unwind_ip;
> +static struct orc_entry *cur_orc_table = __start_orc_unwind;
>  
> -unsigned int lookup_num_blocks;
> -bool orc_init;
> +static unsigned int lookup_num_blocks;
> +static bool orc_init;
>  
>  static inline unsigned long orc_ip(const int *ip)
>  {
> -- 

Already fixed in 
https://lore.kernel.org/lkml/63b5cab2e28b9c08854fc57f5b512a9ccf76ad95.1584033751.git.jpoimboe@redhat.com/

Thanks,
Miroslav
