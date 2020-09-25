Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7984F278C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgIYPZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgIYPZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:25:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D786C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 08:25:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so4069775wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7t4fEIEyVBsi/fjg9YkHb+gy/WAE7FgQtIkyl4FSCQ=;
        b=KM9OZ7Biuv/yQe+fyjAagbCVboVA9WGPjj/1U97fdkl6Hfxv+A5iWZSmt8hlFVjOPc
         W1HaNnR+6fTIz7NL3gQHy3UV0XhUJg8vM0a8mglzpBCR3uRNsQwXwHuMdrLHAWGGacmV
         IX84JJFO7YtnQ2OjSWbktlicNpCpTN0PlbP89Hpn2GwE5TxGjH7A9/Dk/WuX/Z0EZC72
         sBGlM35ZjCNN9OpaNA735G37RlDJokox2C6Qp7QuRfZjcGjX0qSqF+B3aEZpq1dvzHSt
         7reRdjaq6udHpT3S+OUHZoGiFz/6BBju4nvnXhR+va4WZuG9zAWx/DvRF/F7WFcIkz5K
         HnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7t4fEIEyVBsi/fjg9YkHb+gy/WAE7FgQtIkyl4FSCQ=;
        b=A2AU4cX2SkzrmCToVZ3wfEroV+y0HkitQbPh6lLfttlbBHE3WMbXY3M1RhoVp9EgcK
         QulWH7ndKH24uT2Ury78ClDp7KbQrUn5yZ8PUmyc0lhkKhGM/M+NWTYxXUWhoKIQKWKh
         FfWF7fcSEZgz3sbDhJkHcqOJ8MBkHVdrvA408gyiUAokflVWRXsvufy4mdyLkpWki4vp
         ss0WmgtQOw2Va7KjiuzHDSKMZZvk97uwzAWPjHCPjTpLLwwENUIPjoS1UsaRtO+xc0s+
         P31uflK/4Pyk6Eb41AR/sUpntUvLL01ascxgRCGak17SLNTHrN6bBL109d1Ya5soCznX
         l/Ug==
X-Gm-Message-State: AOAM5333jFJxG1qVN1udxLGZHRR0g6tw+N1VOwyFnpjVdGG2KT8LxB4Z
        JaXUuaQEeKN7ZoP4KuiCFDtDIKa8L3SzIqzpwvWeNA==
X-Google-Smtp-Source: ABdhPJyZC6LaW4EhV/2oZznYx/893DZokEKtYHJPWcYE5I0O+k12BELKilXwNkpXCMze/LLQrSVCvwKYmQSG2pDbA6M=
X-Received: by 2002:a5d:4581:: with SMTP id p1mr5255102wrq.345.1601047522816;
 Fri, 25 Sep 2020 08:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com> <20200921132611.1700350-4-elver@google.com>
 <20200921143059.GO2139@willie-the-truck>
In-Reply-To: <20200921143059.GO2139@willie-the-truck>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 25 Sep 2020 17:25:11 +0200
Message-ID: <CAG_fn=WXknUnNmyniy_UE7daivSNmy0Da2KzNmX4wcmXC2Z_Mg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] arm64, kfence: enable KFENCE for ARM64
To:     Will Deacon <will@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan.Cameron@huawei.com, Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will,

> Given that the pool is relatively small (i.e. when compared with our virtual
> address space), dedicating an area of virtual space sounds like it makes
> the most sense here. How early do you need it to be available?

How do we assign struct pages to a fixed virtual space area (I'm
currently experimenting with 0xffff7f0000000000-0xffff7f0000200000)?
Looks like filling page table entries (similarly to what's being done
in arch/arm64/mm/kasan_init.c) is not enough.
I thought maybe vmemmap_populate() would do the job, but it didn't
(virt_to_pfn() still returns invalid PFNs).
