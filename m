Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18A31D9F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 20:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgESSeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 14:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:34:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E43C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:33:56 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id o14so843254ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uULKDjBEjsMtByw+4iGwU9ffUZoBNpjzfWNmhhAXeHw=;
        b=Fs0VIPoI9odDQJHZmFcJ1P8SES83Orpb3l0ofzweWC7Zco3Ya3UH2dgv0MuGc5o8LV
         2IyAUuwsUslMyfykUybxtSnXl7DFcaDdIUcHLO8++Q/0D9hqh+fscr4CMGVoSPG9o03/
         AfKGwqxaj9az9xb0XWfkxzSG9FQ98O1D5e9U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uULKDjBEjsMtByw+4iGwU9ffUZoBNpjzfWNmhhAXeHw=;
        b=ZrpIXeeh+AU0uTVejcOc3RvoPokNrd3yaqiJvkCzkIMIFpC8h424t6hV75UCeVQm9D
         toMGZMVA8xPX6FouEtjHvLkYDpuBrPV+47KqEDgxBWYfy10CsI2EIcLhANzicao0zuXJ
         XAKVl++YAAFsX6RmIzmFHt6EEZOY1UD7N8L+VKONHick4NIsx9WzRg6Vb/XThJnLEUHk
         2hLL66lo85KDQ8Q6GwxsWnm8O4Bm99o3YKQbK7ZBXy2iv75XJWxmaTs8qp5zOwOybOW7
         8zCucenD0vDfUYboaE4xPWkgWq0G3i3uF4FmZ0qkOh6HlGKDgHpEEbLsD5etjVjxq4JU
         UDOw==
X-Gm-Message-State: AOAM531Pm/dnHazxaBhHRV+iWJ3sayeINOycQ6tphL9vbozx72KGjgVs
        MU2klqYzGDwLkNxSdyv0uY9rVg9RTC0=
X-Google-Smtp-Source: ABdhPJwSf+dO/C3ZCeieITeV/wlp764mS49QbGnJc2j2SVDhR0jnlbzFGW2As5aqo1a1F14swBhw5A==
X-Received: by 2002:a05:651c:490:: with SMTP id s16mr458706ljc.152.1589913233956;
        Tue, 19 May 2020 11:33:53 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id w14sm100085lfe.65.2020.05.19.11.33.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 11:33:52 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id b6so858440ljj.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:33:51 -0700 (PDT)
X-Received: by 2002:a2e:9649:: with SMTP id z9mr454321ljh.204.1589913230458;
 Tue, 19 May 2020 11:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190718131834.GA22211@redhat.com> <20200127122817.GA10957@redhat.com>
 <20200519172506.GA317395@hirez.programming.kicks-ass.net>
In-Reply-To: <20200519172506.GA317395@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 11:33:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjxDY6XzKKPEE1S+AUXycmo8XNpX2C-jO4fS+qU8ObpA@mail.gmail.com>
Message-ID: <CAHk-=wjjxDY6XzKKPEE1S+AUXycmo8XNpX2C-jO4fS+qU8ObpA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/cputime: make scale_stime() more precise
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> --- a/include/linux/math64.h
> +++ b/include/linux/math64.h
> @@ -263,6 +263,47 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
>  }
>  #endif /* mul_u64_u32_div */
>
> +#ifndef mul_u64_u64_div_u64
> +static inline u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)

Do we really want to inline this? Particularly if we expect this to be
the "architecture doesn't have a better version" case?

It's not like we'd expect people to call it with constant values that
could be optimized by inlining, do we? If any of the values are
actually constants and it's performance-critical, the code is likely
better off using some special helper rather than this anyway.

So I'd much rather see it as a weak function defined in
lib/math/div64.c, and then architectures don't even need to override
it at all. Just let them define their own (inline or not) function,
and we have this as a weak fallback.

No?

               Linus
