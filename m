Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8BC2ED786
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbhAGTei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbhAGTeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:34:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E75EC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 11:33:57 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o17so17333262lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 11:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BiccEa2pJi0DIq52d8GptCq8b6FN7Kia/Heor0TK8iU=;
        b=cSgWqrwKeQA+TlcewT/EN3ag9FvhqObMzUdYPFJ+iIeVnXeXBm9qIUo4mGLTo8rXPV
         1KJCb5OoqOEDYhpX0ZuwT4+f4Go+pY32utCaeK5ZgIDc/9goEzasnnrVXLRlfO2AW9x9
         gFTHOhy3amVqZxg8mlo23HBkE/0DxEpNcwYA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiccEa2pJi0DIq52d8GptCq8b6FN7Kia/Heor0TK8iU=;
        b=rregz4ukovRPNUBesomlLZUWng7rdlFFcCBh/MKLLvMB/TNiG3Ct8iAjL/BV/kT+VS
         vXUM08K50TnwiIno1GSKqSiJMiVs5DuNQ5ASNGMCe3m2/wBT7Ua8gU9Tf+j0klhjwuuS
         JpNvh7JfiRH7xnbVIPP/l/oTMaKAbkdc7YFYyAWFgAFf0fpDPK40I4GTKuSB+9wjgaSL
         xU0GSrVxtSv2gsM1RLbpHMpQZXCXvUI15gkDpL9YzWiKlOlybCiiNn60XD7Z/r0E86E6
         WYkP1DOaI7Sbd6nvZsj4FZtHeC62wGuM/H1STD4qbrqSZDoA5Nvj5Z4HpIPX4xlcpf57
         KIhA==
X-Gm-Message-State: AOAM530S3ZnZtl0QpId7kyLVYG1gw8CgNhWQ7OgFnrK7Vwei4AiB/U+L
        4TKkH9LW43aJ9az/dGSGAXk2B3+AeT6pxQ==
X-Google-Smtp-Source: ABdhPJyf5SacqckfkBl/zAJG0aw5h3N5UxOXN1qm+Z0ygJ+1ZG3I8fjvdY1CzL3/xrFFkrGaPHBZDA==
X-Received: by 2002:a19:787:: with SMTP id 129mr125636lfh.234.1610048035065;
        Thu, 07 Jan 2021 11:33:55 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id n203sm1361447lfd.7.2021.01.07.11.33.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 11:33:53 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id b26so17286901lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 11:33:53 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr120021lfb.421.1610048032710;
 Thu, 07 Jan 2021 11:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20210107134723.GA28532@xsang-OptiPlex-9020> <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
 <20210107183358.GG3579531@ZenIV.linux.org.uk> <CAHk-=wiZaFRt9hGen9=eOr7LA+Q8o5f980eGEvtxBD6+os7nqA@mail.gmail.com>
 <20210107190445.GK3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210107190445.GK3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 11:33:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=whneXU5Sr=iOOrzcqZt6q85zp-8CUSviOwGPj5ePBW4CQ@mail.gmail.com>
Message-ID: <CAHk-=whneXU5Sr=iOOrzcqZt6q85zp-8CUSviOwGPj5ePBW4CQ@mail.gmail.com>
Subject: Re: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 11:04 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, changing 'event' field in place from another thread is going to
> be interesting - you have two 16bit values next to each other and
> two CPUs modifying those with no exclusion.  Sounds like a recipe
> for massive trouble...

It's perfectly fine on just about anything else than on an original
pre-ev5 alpha.

The C standard even - finally - made it a requirement that accesses to
different members can't introduce data races.

So I agree with you that it's a bit annoying, and it's likely not even
very common, but I could easily imagine myself writing code that
changes either 'fd' or 'events' in a threaded server.

That's pretty much the whole point of 'poll()' after all - threaded
servers that have that convenient array of pollable file descriptors.

Maybe the pollfd array in many cases ends up being thread-local,
possibly generated from some other data structure each time. But if it
is some performance-critical thing (and I can't imagine a lot of more
performance-critical things than the core poll() loop), I can very
easily imagine it being re-used in between poll() calls, and people
modifying it from signal handlers and other threads as the set of
pollable file descriptors change due to new connections etc.

But I'll be honest - I didn't try to actually find such code, and I
suspect 99% of all cases would be happy with your "copy everything".

In fact, even some threaded app that does what I suspect it could do
would likely be ok with it 99% of the time. Because the situation
where you change the fd in the poll array is likely not the common
case, and even if some -1 file descriptor gets overwritten by a valid
one by the poll() system call again, it probably ends up being very
hard to see a failure.

Which just makes me even more nervous.

But I'm sure that yes, on platforms like s390, that "only write 16
bits out of every 64 bits" loop is probably pretty painful.

On most normal architectures it's probably a wash. I doubt it is
measurable on x86, for example.

           Linus
