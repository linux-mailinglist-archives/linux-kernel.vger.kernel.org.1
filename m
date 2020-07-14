Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7395321F71B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 18:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgGNQS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 12:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgGNQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:18:58 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C60CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:18:58 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id o4so12156491lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVja+Dm3U4NNdoUzuGjR/wqvDeVbDJNnrorH0uGFQ1c=;
        b=hPQODzQeZU73y/uYKV3Or723M4Cd3tvDmXFHXDZxwc+KS0m8Ik+d8ktVcP6IwAmUh2
         e/Tgq0pCCJ3dVb4vS8wSP+mNSYY+Fbx1xHTpNcw7/DtynQixRQYltmHYu2OHIrdP80P7
         B6L7zYegq+LM862HVAY4Aot1lHzFerNg0ZcSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVja+Dm3U4NNdoUzuGjR/wqvDeVbDJNnrorH0uGFQ1c=;
        b=iZCH3koBpG0+BooI/I+JlEgfT6KVrzT+uegUqIqFz7Wb1CxX4pfTxC+vazPUaJ2nfr
         e/XqLiyenwKc3/GFJw0+YXpZXGN+YsrX5py5slR8Gq3n3IHWC4bwtw4YjGgWAJBWmIdy
         evKoLuYJdm2g2bHciTf/j76WBJlj3bWW4f11nPI31O9js5qICm4OGqQQawPf1cWgdbME
         GhsEdw8qkvsmq04RDBalumCXr3UPU7KVtZZGau/YLdhtPCj3qCQYh0D8u6yjzslqpaMz
         bBUozfKdnTXppSrIfZGqEmb4FZxlLZAIv4fOJbG2gT++BBuJvSr42Rom8jNiBRhlx7AX
         gfkg==
X-Gm-Message-State: AOAM530jngdEgZ17OU+R//5NYKGJKsFx8sG7rlFi2vWnJwDLFry1S6SB
        aoJlE6p8Zc6KCBRclhL3OLNT3zQoZVA=
X-Google-Smtp-Source: ABdhPJwBVHjACcSCyX94mGmHxdx+Qi43bP/6UPnRhh1ayNI0cxgHHO4XU+42PBF1RDJQo0T+rMDcWQ==
X-Received: by 2002:a05:6512:3fa:: with SMTP id n26mr2538389lfq.190.1594743536753;
        Tue, 14 Jul 2020 09:18:56 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id z23sm4755098ljz.3.2020.07.14.09.18.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 09:18:56 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id q7so23601158ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:18:56 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr2613302lji.371.1594743064458;
 Tue, 14 Jul 2020 09:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com>
 <CAHk-=wgRcFSnQt=T95S+1dPkyvCuVAVGQ37JDvRg41h8hRqO3Q@mail.gmail.com>
 <CA+G9fYuL=xJPLbQJVzDfXB8uNiCWdXpL=joDsnATEFCzyFh_1g@mail.gmail.com>
 <CAHk-=wgB6Ds6yqbZZmscKNuAiNR2J0Pf3a8UrbdfewYxHE7SbA@mail.gmail.com>
 <20200712215041.GA3644504@google.com> <CAHk-=whxP0Gj70pJN5R7Qec4qjrGr+G9Ex7FJi7=_fPcdQ2ocQ@mail.gmail.com>
 <20200714073306.kq4zikkphqje2yzb@box> <20200714160843.GA1685150@google.com>
In-Reply-To: <20200714160843.GA1685150@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 09:10:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjffJ=EBrLjsz=KUFyPXVQUO03L=VJmHnLhVr4XvT3Mpw@mail.gmail.com>
Message-ID: <CAHk-=wjffJ=EBrLjsz=KUFyPXVQUO03L=VJmHnLhVr4XvT3Mpw@mail.gmail.com>
Subject: Re: WARNING: at mm/mremap.c:211 move_page_tables in i386
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>,
        Michel Lespinasse <walken@google.com>,
        Fan Yang <Fan_Yang@sjtu.edu.cn>,
        Brian Geffon <bgeffon@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, pugaowei@gmail.com,
        Jerome Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 9:08 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> I was thinking we should not call move_page_tables() with overlapping ranges
> at all, just to keep things simple.

No, we're not breaking the existing stack movement code just to keep
things simple.

The rule is "make it as simple as possible, but no simpler".

And "as possible" in the case of Linux means "no breaking of old
interfaces". The stack randomization movement most certainly counts.

                  Linus
