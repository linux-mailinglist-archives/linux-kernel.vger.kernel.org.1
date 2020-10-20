Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22F293AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405859AbgJTMKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:10:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:46670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404053AbgJTMKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:10:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23316ABD1;
        Tue, 20 Oct 2020 12:10:10 +0000 (UTC)
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Linux MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200925211206.423598568@goodmis.org>
 <20200925211819.908745401@goodmis.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/3 v2] mm/page_ref: Convert the open coded tracepoint
 enabled to the new helper
Message-ID: <f42807f7-2ad8-3f91-06ce-328e197a5fad@suse.cz>
Date:   Tue, 20 Oct 2020 14:10:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20200925211819.908745401@goodmis.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/20 11:12 PM, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> As more use cases of checking if a tracepoint is enabled in a header are
> coming to fruition, a helper macro, tracepoint_enabled(), has been added to
> check if a tracepoint is enabled or not, and can be used with minimal header
> requirements (avoid "include hell"). Convert the page_ref logic over to the
> new helper macro.
> 
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Michal Nazarewicz <mina86@mina86.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>   include/linux/page_ref.h | 42 ++++++++++++++++++++--------------------
>   1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index d27701199a4d..f3318f34fc54 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -7,13 +7,13 @@
>   #include <linux/page-flags.h>
>   #include <linux/tracepoint-defs.h>
>   
> -extern struct tracepoint __tracepoint_page_ref_set;
> -extern struct tracepoint __tracepoint_page_ref_mod;
> -extern struct tracepoint __tracepoint_page_ref_mod_and_test;
> -extern struct tracepoint __tracepoint_page_ref_mod_and_return;
> -extern struct tracepoint __tracepoint_page_ref_mod_unless;
> -extern struct tracepoint __tracepoint_page_ref_freeze;
> -extern struct tracepoint __tracepoint_page_ref_unfreeze;
> +DECLARE_TRACEPOINT(page_ref_set);
> +DECLARE_TRACEPOINT(page_ref_mod);
> +DECLARE_TRACEPOINT(page_ref_mod_and_test);
> +DECLARE_TRACEPOINT(page_ref_mod_and_return);
> +DECLARE_TRACEPOINT(page_ref_mod_unless);
> +DECLARE_TRACEPOINT(page_ref_freeze);
> +DECLARE_TRACEPOINT(page_ref_unfreeze);
>   
>   #ifdef CONFIG_DEBUG_PAGE_REF

Not that it matters much, but the declarations could be below the #ifdef, AFAICS.

>   
> @@ -24,7 +24,7 @@ extern struct tracepoint __tracepoint_page_ref_unfreeze;
>    *
>    * See trace_##name##_enabled(void) in include/linux/tracepoint.h
>    */
> -#define page_ref_tracepoint_active(t) static_key_false(&(t).key)
> +#define page_ref_tracepoint_active(t) tracepoint_enabled(t)

The full comment above could now be deleted too?

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!
