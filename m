Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5668F3035DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbhAZFzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:55:40 -0500
Received: from foss.arm.com ([217.140.110.172]:46654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbhAYM3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:29:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C32EED1;
        Mon, 25 Jan 2021 03:31:40 -0800 (PST)
Received: from [10.37.8.33] (unknown [10.37.8.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25E963F66E;
        Mon, 25 Jan 2021 03:31:38 -0800 (PST)
Subject: Re: [PATCH] kasan: export kasan_poison
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210125112831.2156212-1-arnd@kernel.org>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <d15786d7-b7cd-86ae-adac-5a581e683be1@arm.com>
Date:   Mon, 25 Jan 2021 11:35:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125112831.2156212-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/21 11:28 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The unit test module fails to build after adding a reference
> to kasan_poison:
> 
> ERROR: modpost: "kasan_poison" [lib/test_kasan.ko] undefined!
> 
> Export this symbol to make it available to loadable modules.
> 
> Fixes: b9b322c2bba9 ("kasan: add match-all tag tests")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks I just stumbled on the same issue ;)

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  mm/kasan/shadow.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index de6b3f074742..32e7a5c148e6 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -94,6 +94,7 @@ void kasan_poison(const void *address, size_t size, u8 value)
>  
>  	__memset(shadow_start, value, shadow_end - shadow_start);
>  }
> +EXPORT_SYMBOL_GPL(kasan_poison);
>  
>  void kasan_unpoison(const void *address, size_t size)
>  {
> 

-- 
Regards,
Vincenzo
