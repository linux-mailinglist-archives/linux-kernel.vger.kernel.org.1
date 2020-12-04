Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298372CED9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbgLDLzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:55:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40198 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgLDLzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:55:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id a3so6758222wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 03:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wHqmBeW2IFxVt4oHJizfcV3fQQX4Hgdaz39Wp4K7c0A=;
        b=qlp9PhdRghtfGxUhq6Yr02LvnLfDF8oruWwkFQQhz/iNOf3aHArn4YqYLIKck2FIcL
         /yx1KGpv+OpqPIfteu7Rjm/URHLYV/0cPj2AzWEfM+aNd7b7dRpuJ957oai1ARNGw4HO
         Oie+gJNx5I6hWIoJaWE7LPKSgKho7hj6VwTRMT0ryvxmLGXVKwMOkaMPTXmDr1iPfwHT
         sGe1hz8ul3W+bfYUzwmBnG/KB4QYM7d9ydWOEJZEMDRk87De7ACTMa0dR5bdtXhv/WT3
         QOdlaA4xaVtStVrXw8huAWLzjt+CM5BZlG6GDsstFwpwCekscBYcrl957b0denBM+2WJ
         iuLQ==
X-Gm-Message-State: AOAM5307tnpoNRasq8PBYZeZn3lIFuq1hOAe/6I+sCxDSOXkTV9Wgz92
        DryxQuLGmsBPl2XIjWsNRxw=
X-Google-Smtp-Source: ABdhPJz3k3/M4l7ovBWHXv3cerqd8tc5RbeKIr8k7pXjJ8RslEzOgI+FhEYt0rRwwhaYS4XH6t8M9g==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr3791014wmh.153.1607082872591;
        Fri, 04 Dec 2020 03:54:32 -0800 (PST)
Received: from [10.9.0.26] ([185.248.161.177])
        by smtp.gmail.com with ESMTPSA id u26sm3027316wmm.24.2020.12.04.03.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 03:54:31 -0800 (PST)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH RFC v2 2/6] mm/slab: Perform init_on_free earlier
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
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
 <1772bc7d-e87f-0f62-52a8-e9d9ac99f5e3@linux.com>
 <20201203124914.25e63b013e9c69c79d481831@linux-foundation.org>
From:   Alexander Popov <alex.popov@linux.com>
Message-ID: <9b9861c0-4c94-a51f-bbac-bd5e9b77d9e0@linux.com>
Date:   Fri, 4 Dec 2020 14:54:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201203124914.25e63b013e9c69c79d481831@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.12.2020 23:49, Andrew Morton wrote:
> On Thu, 3 Dec 2020 22:50:27 +0300 Alexander Popov <alex.popov@linux.com> wrote:
> 
>> On 30.09.2020 15:50, Alexander Potapenko wrote:
>>> On Tue, Sep 29, 2020 at 8:35 PM Alexander Popov <alex.popov@linux.com> wrote:
>>>>
>>>> Currently in CONFIG_SLAB init_on_free happens too late, and heap
>>>> objects go to the heap quarantine being dirty. Lets move memory
>>>> clearing before calling kasan_slab_free() to fix that.
>>>>
>>>> Signed-off-by: Alexander Popov <alex.popov@linux.com>
>>> Reviewed-by: Alexander Potapenko <glider@google.com>
>>
>> Hello!
>>
>> Can this particular patch be considered for the mainline kernel?
> 
> All patches are considered ;) And merged if they're reviewed, tested,
> judged useful, etc.
> 
> If you think this particular patch should be fast-tracked then please
> send it as a non-RFC, standalone patch.  Please also enhance the
> changelog so that it actually explains what goes wrong.  Presumably
> "objects go to the heap quarantine being dirty" causes some
> user-visible problem?  What is that problem?

Ok, thanks!
I'll improve the commit message and send the patch separately.

Best regards,
Alexander
