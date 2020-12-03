Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7399A2CDF2F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgLCTvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:51:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45411 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgLCTvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:51:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id t4so3083714wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=X2sJjf4rgVoTYeRjWgx/Ub3m34veUfOcx8dQYIctFxw=;
        b=VGUdULXOY0U94EQeC9QtAe935dga7oMqCL0BXMSV7FcoX1RmIhu0uT2z5SjDLj38Nr
         fKmAgqTFX0KR1B0c124SvW+xrBg6uXsBlDOYZgF6XobtdjaTiXu1OTvIQglhwC5eYY0o
         WAN/ZVrMfkrCPv9Rsxn/lhhPHtCYe660yw7I/rvaqvsTQFixBup0alc677B6zQKbBmGi
         2wtvg0dv0TX0sAEme5QQNHmD9RCY4Nk8dfW7VCVoinzZ2EE+dUXXIhVloai+RhmgBThz
         E3Gs7A3qgBAIvp9wbPHyz2rqtcroWDuOffpceqVHRsVJ9DT8al6ZSQgjvfcCHR/yOjit
         h7BQ==
X-Gm-Message-State: AOAM530PzQgphkELmE5VCMx0Njupigm/6IDrAKlkbZ7EGRmHPBScZA3j
        5F6LJLgXWWLno3a+O17R+Rw=
X-Google-Smtp-Source: ABdhPJyfsPBdYDGguP/sCzXs4LIQiAGtpaD/uX1/KBO6z1qFGuTTkmUz2C+FOvXUurAvBiWZ6cU0mA==
X-Received: by 2002:adf:a495:: with SMTP id g21mr873975wrb.213.1607025032556;
        Thu, 03 Dec 2020 11:50:32 -0800 (PST)
Received: from [10.9.0.26] ([185.248.161.177])
        by smtp.gmail.com with ESMTPSA id 20sm439140wmk.16.2020.12.03.11.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 11:50:31 -0800 (PST)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH RFC v2 2/6] mm/slab: Perform init_on_free earlier
To:     Alexander Potapenko <glider@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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
        Daniel Micay <danielmicay@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Machek <pavel@denx.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>, notify@kernel.org
References: <20200929183513.380760-1-alex.popov@linux.com>
 <20200929183513.380760-3-alex.popov@linux.com>
 <CAG_fn=WY9OFKuy6utMHOgyr+1DYNsuzVruGCGHMDnEnaLY6s9g@mail.gmail.com>
From:   Alexander Popov <alex.popov@linux.com>
Message-ID: <1772bc7d-e87f-0f62-52a8-e9d9ac99f5e3@linux.com>
Date:   Thu, 3 Dec 2020 22:50:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAG_fn=WY9OFKuy6utMHOgyr+1DYNsuzVruGCGHMDnEnaLY6s9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.09.2020 15:50, Alexander Potapenko wrote:
> On Tue, Sep 29, 2020 at 8:35 PM Alexander Popov <alex.popov@linux.com> wrote:
>>
>> Currently in CONFIG_SLAB init_on_free happens too late, and heap
>> objects go to the heap quarantine being dirty. Lets move memory
>> clearing before calling kasan_slab_free() to fix that.
>>
>> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>

Hello!

Can this particular patch be considered for the mainline kernel?


Note: I summarized the results of the experiment with the Linux kernel heap
quarantine in a short article, for future reference:
https://a13xp0p0v.github.io/2020/11/30/slab-quarantine.html

Best regards,
Alexander

>> ---
>>  mm/slab.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/slab.c b/mm/slab.c
>> index 3160dff6fd76..5140203c5b76 100644
>> --- a/mm/slab.c
>> +++ b/mm/slab.c
>> @@ -3414,6 +3414,9 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
>>  static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
>>                                          unsigned long caller)
>>  {
>> +       if (unlikely(slab_want_init_on_free(cachep)))
>> +               memset(objp, 0, cachep->object_size);
>> +
>>         /* Put the object into the quarantine, don't touch it for now. */
>>         if (kasan_slab_free(cachep, objp, _RET_IP_))
>>                 return;
>> @@ -3432,8 +3435,6 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
>>         struct array_cache *ac = cpu_cache_get(cachep);
>>
>>         check_irq_off();
>> -       if (unlikely(slab_want_init_on_free(cachep)))
>> -               memset(objp, 0, cachep->object_size);
>>         kmemleak_free_recursive(objp, cachep->flags);
>>         objp = cache_free_debugcheck(cachep, objp, caller);
>>         memcg_slab_free_hook(cachep, virt_to_head_page(objp), objp);
>> --
>> 2.26.2
>>
> 
> 

