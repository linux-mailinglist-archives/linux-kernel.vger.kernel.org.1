Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02C7280D4B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 08:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgJBGJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 02:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgJBGJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:09:23 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C86C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 23:09:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p9so323068ejf.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 23:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ErDIuUWMtALu7PV5gTspIOaPecBO2jLlFmry3dq1eBo=;
        b=rBhLzpe9AaLtN/2VQTeF4ZLBJk0wEwLO1iXW7SFdIMCovz/n+bZLB7IAveG1e9ur8g
         YRDBg+0/O3HVIFt9+77VO4vz1qRhWN0N5JLUJkLHeKN0Fq2FV1sS8zieRMheOhUf5bVF
         9qAS9mTkKdzWHR4dJan0mJZrLW9vG6XzX1iipaUrffpCB3CFAGIdFAOD70DlWd/BV/00
         YeempllyPkiOQYQTjPfz7FvV8Zq35XFb+EARWaMiaC9negdQ9wmS4SToBah7FpromM0/
         j46OcFr+y/fWE9HUSVM5XGUXZ/ifypV3vicbNueD/Gkh591QW2pcf6xwTpu/Kqy1srWq
         wZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErDIuUWMtALu7PV5gTspIOaPecBO2jLlFmry3dq1eBo=;
        b=I6AaMS8lzZmxfzl2t+jxxVIQVYNwLFrgmEDO9eB95qZMWW2oo6jd2KG01IMVW4XuRC
         /068Qt3+s4vDkos/+bal5PRFzHmxQgrKqiSOmzpiIw62OI78nou9D2wVZnpJX8B2VOSb
         SjfhU+Stn+seI/B2gvW+fqGlZVJqUJ74AKdP/z/APLdwbjvHdmuUUZuJmd6Wn55qX5Z+
         H5iZO2gvzLuLqYXlHyMGgKrgh32TilJtn4H3GIl+R89TSodHQcWT6i5XVkNMJCI80tm+
         8qyvYVjh1Tg2NOFMIBSd+CbCgogTef+mY9/uwV3TOKSKf1Y2Ro4thpQ2WJ1hy9Q2eK4n
         ySFA==
X-Gm-Message-State: AOAM530Vy6BVQz97IBL5Cj0QyVVklrCY4yPkXT2gJinFj7Wy4LVsRhKv
        ph9j1q/sHrcWe43+J67dP0iqNtQ21e9Ezqb1jdwzOw==
X-Google-Smtp-Source: ABdhPJyX8T+V5wOYpGANjLoJVq9hy+yf3n4BHwp6BilkYq6bai5LeCuRrBuF1aQ5IgShwbEHdu8lTpaX6/0OCPdGKR4=
X-Received: by 2002:a17:906:394:: with SMTP id b20mr570705eja.513.1601618959814;
 Thu, 01 Oct 2020 23:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-3-elver@google.com>
In-Reply-To: <20200929133814.2834621-3-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Oct 2020 08:08:53 +0200
Message-ID: <CAG48ez2yH+9jX40YdzkeiGk2vdwquw3U=GZY8S6WXrCEH+73Sw@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] x86, kfence: enable KFENCE for x86
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
        Ingo Molnar <mingo@redhat.com>, Jonathan.Cameron@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 3:38 PM Marco Elver <elver@google.com> wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the x86 architecture. In particular, this implements the
> required interface in <asm/kfence.h> for setting up the pool and
> providing helper functions for protecting and unprotecting pages.
[...]
> diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
[...]
> +/* Protect the given page and flush TLBs. */
> +static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +{
[...]
> +       flush_tlb_one_kernel(addr);

flush_tlb_one_kernel() -> flush_tlb_one_user() ->
__flush_tlb_one_user() -> native_flush_tlb_one_user() only flushes on
the local CPU core, not on others. If you want to leave it this way, I
think this needs a comment explaining why we're not doing a global
flush (locking context / performance overhead / ... ?).
