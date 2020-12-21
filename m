Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2695B2E0185
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 21:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgLUU0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 15:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLUU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:26:09 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFFAC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:25:28 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o19so26802017lfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k5zaXo4wHvh1dW+KqsesRxK7xiAm0BCunbjnJYxvhz8=;
        b=Ms5Xy1U+4jhVMIkNDhKzne/rZJlQEFuV7hucbckZy+YFqWk5mcJQ96C3W1K+G8i09y
         8J9WxZMu8pqcOCErRRebf2lG7lky5KbqBcvfLLdaBfCIvva4S386rnAsqChHlbUnSFYf
         pJY2/7Xoxilz9bukgW9iDxfnFQILnhL6fjU2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5zaXo4wHvh1dW+KqsesRxK7xiAm0BCunbjnJYxvhz8=;
        b=GhVaHeJXY64gSG2aQuVKd+OlX0EvfMT9hPfA5jaTEbWbUwnjBPz3qZg3wRjf21jn2y
         2/vWuELU0n1tiJINWxcwzM9VA+QdmgE4mHklwBtMKv7jSvamoV5MN8iyBPZuB5WUEplb
         wtRnbIPCdwPl7fsvKhRBOhH/+ieCaK8WTZnUEQ2LOpcMjuloQvJ77bm/+THA81i7t6eX
         pVSg35iLMPvFckJv2ENu7lF3p59GjD9hYAmvjrJRyFMgRTAsgtDhM0Uk/PiuqSUP1E+f
         jse/OgUscGGqd96yCIWsLNSRATt1RQlACz7yw2Bp0ml/Vdu14Ro7Jx8g1IQf1Es3An03
         hUEw==
X-Gm-Message-State: AOAM533aCIT4RV05VHyy1LoTYg7EXS280eWyBZyVc4yNZl2jcH9WAtrn
        mYIzGi63nP/8w0JM5UxFONileZ0TNsjmfQ==
X-Google-Smtp-Source: ABdhPJyLIwth/M5ZfZ9141CVFMNzt8gJZyuwqqFsTbSRIYFQ8qNeczZLUIPeXrhKUbVyH9BcZUBAWA==
X-Received: by 2002:ac2:4a65:: with SMTP id q5mr7488366lfp.320.1608582325618;
        Mon, 21 Dec 2020 12:25:25 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id l9sm2345443lji.104.2020.12.21.12.25.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 12:25:24 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id b26so17213512lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:25:24 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr7868338lji.251.1608582323808;
 Mon, 21 Dec 2020 12:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20201219043006.2206347-1-namit@vmware.com> <X95RRZ3hkebEmmaj@redhat.com>
 <EDC00345-B46E-4396-8379-98E943723809@gmail.com> <X97pprdcRXusLGnq@google.com>
 <DDA15360-D6D4-46A8-95A4-5EE34107A407@gmail.com> <20201221172711.GE6640@xz-x1>
 <76B4F49B-ED61-47EA-9BE4-7F17A26B610D@gmail.com> <X+D0hTZCrWS3P5Pi@google.com>
 <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com> <X+EDslLVp9yRRru6@google.com>
In-Reply-To: <X+EDslLVp9yRRru6@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Dec 2020 12:25:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUST1qd9Q668rwSzwOLQxTaAC1oUd7pPQBSj2s6PkqAw@mail.gmail.com>
Message-ID: <CAHk-=wjUST1qd9Q668rwSzwOLQxTaAC1oUd7pPQBSj2s6PkqAw@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
To:     Yu Zhao <yuzhao@google.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 12:21 PM Yu Zhao <yuzhao@google.com> wrote:
>
> Well, unfortunately we have places that use optimizations like
>
>   inc_tlb_flush_pending()
>     lock page table
>       pte_wrprotect
>   flush_tlb_range()
>   dec_tlb_flush_pending()
>
> which complicate things.

My point is, none of that  matters.

Because the software side that does the actual page table
modifications do not depend on the TLB at all.

They depend on the page table lock, and the pte in memory.

So the "pending flush" simply shoudln't be an issue. It's about the
actual hardware usage.

But what DOES matter for the software accesses is that you can't
modify protections without holding the proper lock.

And userfaultfd seems to do exactly that, breaking the whole "load pte
early, then check that it didn't change".

(Which we do in other places too, not just COW - it's basically _the_
pattern for page table updates).

               Linus
