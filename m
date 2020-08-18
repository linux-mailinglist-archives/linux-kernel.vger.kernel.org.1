Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4057D248FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 22:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHRUuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 16:50:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33966 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgHRUud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:50:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id bs17so16363059edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5uvLQdwA9XnjdyJ8uI+0lrr22ouPyu6AUfsbqa6bRP0=;
        b=ByPtSVJlGFz8PRA3bAtG6Gmc5uw14vdrM+nwVCHSOemoC1OSCxv2hAL3iaIIT+IQcj
         A8ZW32zNs9cgGX4WjD/yVHP18Gq1C/1UVehFwxWhX7NH/LOdKNp8DIQJSxtpQYPLMywk
         zNnLPk7aYltrK5xDz+rDVbmMfjoGBqEVyV1BC455yhzCd/6i7mULd9UHS+cNE4bU5OQB
         SKTB90hMLbWbjMKXbg+5oHxCD+OOSQLE6FyM9dKSEyTEY025ljQig3wBmw/y/oknXsat
         7YN637sceIi39SX79k+Uwa617jmpN1N4Hnc1xs1loqxdxNJShD37k4HKKRzrLdwHIH7S
         of8w==
X-Gm-Message-State: AOAM533zr4bzDCvK/kyFMFuuC1PvPJJ0JBwpM4hEmDgOJyxYel2AaQ2y
        a7iRDaX//0OPayhst4t+Gbe3QWKyEHCzEA==
X-Google-Smtp-Source: ABdhPJx7YSCjxJSt+xa1i/ZiHnHETNTHmOqROdabsUzZEHHjOE/VrsmdYwrBlROpEuLGqggHpWfCag==
X-Received: by 2002:a05:6402:174d:: with SMTP id v13mr20748953edx.231.1597783830798;
        Tue, 18 Aug 2020 13:50:30 -0700 (PDT)
Received: from [10.9.0.18] ([185.248.161.177])
        by smtp.gmail.com with ESMTPSA id s16sm17277427ejr.31.2020.08.18.13.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 13:50:29 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH RFC 1/2] mm: Extract SLAB_QUARANTINE from KASAN
To:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel-hardening@lists.openwall.com,
        LKML <linux-kernel@vger.kernel.org>, notify@kernel.org
References: <20200813151922.1093791-1-alex.popov@linux.com>
 <20200813151922.1093791-2-alex.popov@linux.com>
 <202008150939.A994680@keescook>
 <82edcbac-a856-cf9e-b86d-69a4315ea8e4@linux.com>
 <CAAeHK+z9FPc9dqHwLA7sXTdpjt-iQweaQGQjq8L=eTYe2WdJ+g@mail.gmail.com>
From:   Alexander Popov <alex.popov@linux.com>
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 j3lCqPk=
Message-ID: <b15d41a5-034c-6fb5-dedf-5fd75d609ccf@linux.com>
Date:   Tue, 18 Aug 2020 23:50:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+z9FPc9dqHwLA7sXTdpjt-iQweaQGQjq8L=eTYe2WdJ+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.2020 18:45, Andrey Konovalov wrote:
> On Mon, Aug 17, 2020 at 7:32 PM Alexander Popov <alex.popov@linux.com> wrote:
>>
>> On 15.08.2020 19:52, Kees Cook wrote:
>>> On Thu, Aug 13, 2020 at 06:19:21PM +0300, Alexander Popov wrote:
>>>> Heap spraying is an exploitation technique that aims to put controlled
>>>> bytes at a predetermined memory location on the heap. Heap spraying for
>>>> exploiting use-after-free in the Linux kernel relies on the fact that on
>>>> kmalloc(), the slab allocator returns the address of the memory that was
>>>> recently freed. Allocating a kernel object with the same size and
>>>> controlled contents allows overwriting the vulnerable freed object.
>>>>
>>>> Let's extract slab freelist quarantine from KASAN functionality and
>>>> call it CONFIG_SLAB_QUARANTINE. This feature breaks widespread heap
>>>> spraying technique used for exploiting use-after-free vulnerabilities
>>>> in the kernel code.
>>>>
>>>> If this feature is enabled, freed allocations are stored in the quarantine
>>>> and can't be instantly reallocated and overwritten by the exploit
>>>> performing heap spraying.
>>>
>>> It may be worth clarifying that this is specifically only direct UAF and
>>> doesn't help with spray-and-overflow-into-a-neighboring-object attacks
>>> (i.e. both tend to use sprays, but the former doesn't depend on a write
>>> overflow).
>>
>> Andrey Konovalov wrote:
>>> If quarantine is to be used without the rest of KASAN, I'd prefer for
>>> it to be separated from KASAN completely: move to e.g. mm/quarantine.c
>>> and don't mention KASAN in function/config names.
>>
>> Hmm, making quarantine completely separate from KASAN would bring troubles.
>>
>> Currently, in many special places the allocator calls KASAN handlers:
>>   kasan_cache_create()
>>   kasan_slab_free()
>>   kasan_kmalloc_large()
>>   kasan_krealloc()
>>   kasan_slab_alloc()
>>   kasan_kmalloc()
>>   kasan_cache_shrink()
>>   kasan_cache_shutdown()
>>   and some others.
>> These functions do a lot of interesting things and also work with the quarantine
>> using these helpers:
>>   quarantine_put()
>>   quarantine_reduce()
>>   quarantine_remove_cache()
>>
>> Making quarantine completely separate from KASAN would require to move some
>> internal logic of these KASAN handlers to allocator code.
> 
> It doesn't look like there's quite a lot of KASAN-specific logic there.
> 
> All those quarantine_*() calls are either at the beginning or at the
> end of some kasan annotations, so it should be quite easy to move
> those out. E.g. quarantine_reduce() can be moved together with the
> gfpflags_allow_blocking(flags) check and put before kasan_kmalloc()
> calls (or maybe also into some other places?), quarantine_put() can be
> put after kasan_slab_free(), etc.
> 
>> In this patch I used another approach, that doesn't require changing the API
>> between allocators and KASAN. I added linux/mm/kasan/slab_quarantine.c with slim
>> KASAN handlers that implement the minimal functionality needed for quarantine.
>>
>> Do you think that it's a bad solution?
> 
> This solution doesn't look clean. Here you provide a second KASAN
> runtime implementation, parallel to the original one, which only does
> quarantine. It seems much cleaner to put quarantine logic into a
> separate module, which can be either used independently, or together
> with KASAN built on top of it.

That sounds reasonable, I agree. Thanks, Andrey.
Added to TODO list.

At first I'm going to focus on exploring security properties of the quarantine.
And then I'll do the refactoring that you and Kees propose.

Best regards,
Alexander
