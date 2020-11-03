Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25452A59ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 23:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgKCWSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 17:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbgKCWSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 17:18:08 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3286FC061A04
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 14:18:08 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id h6so24400342lfj.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 14:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZRbguQ1x9dT0hAvOuP/VOG3YF2apB5kK77xWV7GZj8=;
        b=e64Bz7BE2EMfuJBK4v0zmQPnFN9lNFRh9kkgkxlITo7rvrh4p1X05aLqaDZJSCwgqf
         NkeYbCBk8ymR4KZ5eZ+T66JiIkjjMwGwgn9upz0vlatttnaRTo8CD6zYhX2kd7tIqPYW
         brnBkGNp71HDWqcjeGkuHw1qA/1Y/KgRTXT9IDiMHfaeLlnr7KXPEhveqxLCwahO8XB1
         jKWgHrwbjsUmMQUlYFTygFpkHnBCxT6s04QdNzXg6iWssqG+3KJiWmRM/5nMGf3jGKrZ
         FSx7sS6fS0MxkiItNy0e+PB9mNqHK/XFbxPInS/zqp1SIdiN6cFuaNybFI7yGGCRMe1v
         pDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZRbguQ1x9dT0hAvOuP/VOG3YF2apB5kK77xWV7GZj8=;
        b=FPkIw+y7Lw6SQlyZIjsOVZ4B+/xT0kmVO/kYDAOnpRsu8ZUUycu99dKVWzkfwoabCD
         asNHWMEGHi0J14IphAJ4E9nVKp3lbCnhmi3eUitwYW6zFB/uZjC+bR9wd/qY9DmYUxEI
         D7DvM6LdaC3Z75DSfui+xqvWWqBgCxw01qFSVPB2vzga0Yj3C3yWQQKlJQU9i+BbaBir
         UbOeOY6piqGfwNPRLoQ0XYnT6IYmcXyyZrvB4+LU6zmgUK2V/iTBecRSgldM1RC8WZNZ
         jCaNmwJLIahdYJyicHN6Hl1lQYLbkppg8DZ45crJLCBUKMJLOTp4c9u9L52HN5QgU0KN
         eTtw==
X-Gm-Message-State: AOAM532raJKokRtPjmMpo6QjeeLJbN6RhQPHVS7Jnb8EPHimbrDAyFb8
        WJjKjuJIB2cw1jtJujvtS/CT6ayEKN8hzUYVggEm2w==
X-Google-Smtp-Source: ABdhPJxNMJdmM5bO0n1X/nCLwlnn2NzVmKdN9XM7NV2nBD3hCpQn9Lo3KTe5+IezyPBL6NgtbGJbT2zP0+jEAYS0fZ0=
X-Received: by 2002:a19:83c1:: with SMTP id f184mr7817703lfd.97.1604441886422;
 Tue, 03 Nov 2020 14:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20201103175841.3495947-1-elver@google.com> <20201103175841.3495947-9-elver@google.com>
In-Reply-To: <20201103175841.3495947-9-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 3 Nov 2020 23:17:39 +0100
Message-ID: <CAG48ez0040+=Grn6nELgPfV4VntStm8iXTC62+ouiF29=9K_rg@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] kfence: add test suite
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
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 6:59 PM Marco Elver <elver@google.com> wrote:
> Add KFENCE test suite, testing various error detection scenarios. Makes
> use of KUnit for test organization. Since KFENCE's interface to obtain
> error reports is via the console, the test verifies that KFENCE outputs
> expected reports to the console.
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Co-developed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Jann Horn <jannh@google.com>
