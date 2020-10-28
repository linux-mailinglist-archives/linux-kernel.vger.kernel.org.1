Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215F629E2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgJ1Vdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:33:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38763 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJ1VdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id f21so271695plr.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wBk3aGK1MABPvM7QHjJc+uErcHqe5igSri6GZrWcMQU=;
        b=A2fFMsn8uMnGgF0VqHWhHX2iQyxXdXkuE0+J+9qitLy09GIb4eJx+sh9wgbSK+Tm86
         2on3NRckMJ7EP1k/F6J7dL7dmds+CmGd+8SaAw76aCG5o9+n+cmoiHbRchz8zj7DTslW
         Fl5HzSj/y93h2plspJBsvAARPYEJ9fHCunAWdAhAS9yLwOEKsxvsUPM6essbv1PyXxGf
         F0sswVEYqiN2QKbbdFebMxQUxS5pRwWe0ujRKiJbvKqtw7+aCNfb+BqSl7LdLORjXpC7
         ASqQjnDVui2hGWhiWkGfVUhz6OXiip1e+rtS/HSqbxBAx3cqA3/6YK2F4nKZBVpxZVMQ
         T/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wBk3aGK1MABPvM7QHjJc+uErcHqe5igSri6GZrWcMQU=;
        b=nHKVNqhiLuLUF7QLiK0BhnNqe/QAoscxLw0ET+orTnjIH4qjj1Ndr7JwweeRCW0tc3
         ik+4HNok86ExNiHhYKXU8d1iQb07z/FaOcR4UKu2iJQW6BYBjieW0b30+TacYjVaTYKO
         os8oK99QPTd4iOZL4GSjzLKBPEu9pXsuZna/vFYX3L5KeNRpSyEde4VImg6JEDdsowck
         O3m8qQTwIx2yOkZ/Xupq94S1PzDWT/YrGJejsFedd8URWivUWTSSExxmhNIa4ygXnuGk
         Mbs1Y7IIUX7XHA85BTm+1ngR0Tkc1J9rmY68kK7RJct7ay6M5e68QiipXKH93r5cHgen
         C7tw==
X-Gm-Message-State: AOAM533rqRiJOTtXLAe/aLS2TwbHfrRDNho1vgz18XPIBLHWW2bky4Bp
        QHYt+BeIzkJB1g/RGz4H1ljPL2FeYs3Rmw==
X-Google-Smtp-Source: ABdhPJz5rKeaSKqJ0VLZxFpfpj4qoX68nNcYPeuuKSv6/M/rH3qjmPmYnohWODoXtWJKXw/t/PxLSA==
X-Received: by 2002:a17:902:690b:b029:d6:41d8:bdc7 with SMTP id j11-20020a170902690bb02900d641d8bdc7mr933796plk.7.1603920793260;
        Wed, 28 Oct 2020 14:33:13 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::4:1c8])
        by smtp.gmail.com with ESMTPSA id w23sm515810pfn.142.2020.10.28.14.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:33:12 -0700 (PDT)
Date:   Wed, 28 Oct 2020 14:33:03 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC][PATCH 0/2] ftrace: Add access to function arguments for
 all callbacks
Message-ID: <20201028213303.shosfclmhxkai2ir@ast-mbp.dhcp.thefacebook.com>
References: <20201028131542.963014814@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028131542.963014814@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 09:15:42AM -0400, Steven Rostedt wrote:
> 
> This is something I wanted to implement a long time ago, but held off until
> there was a good reason to do so. Now it appears that having access to the
> arguments of the function by default is very useful. As a bonus, because
> arguments must be saved regardless before calling a callback, because they
> need to be restored before returning back to the start of the traced
> function, there's not much work to do to have them always be there for
> normal function callbacks.
> 
> The basic idea is that if CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS is set, then
> all callbacks registered to ftrace can use the regs parameter for the stack
> and arguments (kernel_stack_pointer(regs), regs_get_kernel_argument(regs, n)),
> without the need to set REGS that causes overhead by saving all registers as
> REGS simulates a breakpoint.

I don't have strong opinion on this feature, but if you want to have it
please add a giant disclaimer that this is going to be x86-64 and, may be arm64,
feature _forever_. On x86-32 and other architectures there is no way
to provide sane regs_get_kernel_argument(regs, n) semantics by blindly
saving registers. The kernel needs to know types and calling convention
of the architecture. That's the reason bpf side has btf_func_model concept.
To make sure that bpf trampoline can support all architectures in the future.
