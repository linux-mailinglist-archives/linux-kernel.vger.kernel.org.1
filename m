Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707142A59DF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 23:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgKCWRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 17:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgKCWRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 17:17:40 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07088C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 14:17:39 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 11so1229149ljf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 14:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1oYKXAN5GCNK52qKASABkZS4MsOww72x3szPS4VEUtM=;
        b=oDO+8A43pqsEdpFwep2lqes7WkU1VVBO3F6WnCbaHxb3MX4QnoEw9cx5MceFMPFccv
         w/Spe4LXupBhmXcIEiHoP6MNqnoRimNc+UWR6RGvVYasygrQdgTXfWRwbY/ApwsoSKSB
         MOFARBshPTNfVOtqJLAArPNY7eq0fe402dEWg3GeBu21SisinttG6Ro/KF7G9Zv+51/v
         8pLLm7Czirbm2NGXxg7j8H3jTEOq+YZPyih9FiXDM2bsIQ27EXa+qkaVZ3DVgMQ8kONa
         1VhMutiL6QyCTzpeH21STdkZ6ab4guePdNBu6c7qjXpMHJdoth41JoReEpIEklcZa14o
         pIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oYKXAN5GCNK52qKASABkZS4MsOww72x3szPS4VEUtM=;
        b=I+GSfHnlYEVKIqJCWTTBI2KbBYQMGLxwkqT/tfyxnFTuwjtINM3zNsByK4FjY56omu
         cy1kkIF2odwQgFdxVrI2iIy7g9s3+YQ6LHYHGAC6uoHqcvrXvFc/rvhjCy7G5PjPw31w
         WG3bzGGSZc+1CMDnqgiIxXvlWcEpxZoZ5qu1m/bxUIM7ujGhOwitAhG3aCESMzLdbMVB
         MQCZ5RvLt3KmKiDSRZdH0ybfNe5PwW3ulpud7nuPq4W2s2fzGaaoZ3VXhE+FpODWcxXK
         KV3khtGbX1JVFcFGf7jmOjTrvh2ptyBVfEmLag/jyHFPfjGSpqX2RJQDfAqybi53tWD8
         C62g==
X-Gm-Message-State: AOAM530LID8kp6wFfhnqi3BOm/kTWZHhJtcQdaUCWMM3l9NUwzEUpPj8
        EeyTUoicOe6nEB8PKkz4X9wft/Y2qmuieFfqLKa3uA==
X-Google-Smtp-Source: ABdhPJzxANwwy8DCO260MRj79UklNQaawFfHnT4W/UwZLqOVM8XdlsOH3LfgzXzugsbmFvH5JnQM130bEYQPeCf+jqc=
X-Received: by 2002:a2e:9a17:: with SMTP id o23mr10126372lji.242.1604441858170;
 Tue, 03 Nov 2020 14:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20201103175841.3495947-1-elver@google.com> <20201103175841.3495947-2-elver@google.com>
In-Reply-To: <20201103175841.3495947-2-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 3 Nov 2020 23:17:11 +0100
Message-ID: <CAG48ez3rNvqRuU7o1f_Jd3sNZVD+nLSry4rbwMR_VHEXmj6pvA@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] mm: add Kernel Electric-Fence infrastructure
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 6:58 PM Marco Elver <elver@google.com> wrote:
> This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> low-overhead sampling-based memory safety error detector of heap
> use-after-free, invalid-free, and out-of-bounds access errors.

Reviewed-by: Jann Horn <jannh@google.com>
