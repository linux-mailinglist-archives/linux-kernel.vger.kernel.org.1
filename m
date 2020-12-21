Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAFB2E02F1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 00:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgLUXeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 18:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUXea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 18:34:30 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DFCC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 15:33:50 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x20so27637434lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 15:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEI1Wo/KRErTAX0ERZgOzFeJks692fMFAi0JITm2e5Q=;
        b=GC5WA9gdSwcyncqpAe4Pgve/+6CIEcQ2X9/TyvwifrhZz13pA7erQ8ry7LaJHWRbYX
         ujbb52eNeZOdzzRXgtcSiXBN7bIpIlqUo5bA6wXKFSwNB+dI1C8olVMwudvXutMxjHPj
         qsGm07mg/0wlThOxI9rhIrdWA058+/rAApYwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEI1Wo/KRErTAX0ERZgOzFeJks692fMFAi0JITm2e5Q=;
        b=Kas3J4kDdf+MNm846VdmrkpQwAF4VzwWhzyT4TFDwTIvVqU9juEEFTnr6FddWO35sn
         Na1bvxglGGJZ3ubLSH+YY2sq3WX90LKZT31Y+Zh0CoOwpbjdklF3GjW+FY6eZoC4qyuZ
         LoLagYC14GREV35djsgHeHxOzeq6lrKX5sMPpDKqiHgKqb21DFTk5xrkXotBD6f1moOz
         xgj9Lh96WRVh0v1p6lKvcvo9+uJsQOjkrKlVYDuDwgYt9pyFLKZBIhVa5k8+TakHnC0F
         qtzRstNqWMK9eexq/Cb8rQUVtWRPiPyrATVkVP2nBSb6L3PuuZ2oCgPdSyuULGBgYL5e
         C1hQ==
X-Gm-Message-State: AOAM531mdw7GGjs51GBfkJ9bcM1A+ufh6IelnwRD8FrhL2nGwTzMjkNy
        aOQmf3U8aa1mZisz8ZxX8nZ0jLeoaOqbMw==
X-Google-Smtp-Source: ABdhPJxmdnJG1ZZL3yD/avFuYfVPF0e08+Dl8RfwABwEDindAoBu66GxgQu9COkn2m80zaS2jZHOFg==
X-Received: by 2002:a19:cc10:: with SMTP id c16mr7439636lfg.43.1608593628220;
        Mon, 21 Dec 2020 15:33:48 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id l21sm2484892lja.35.2020.12.21.15.33.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 15:33:47 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id a12so27719004lfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 15:33:46 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr7192658lfg.40.1608593626453;
 Mon, 21 Dec 2020 15:33:46 -0800 (PST)
MIME-Version: 1.0
References: <DDA15360-D6D4-46A8-95A4-5EE34107A407@gmail.com>
 <20201221172711.GE6640@xz-x1> <76B4F49B-ED61-47EA-9BE4-7F17A26B610D@gmail.com>
 <X+D0hTZCrWS3P5Pi@google.com> <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com>
 <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com> <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
 <X+ESkna2z3WjjniN@google.com> <1FCC8F93-FF29-44D3-A73A-DF943D056680@gmail.com>
 <20201221223041.GL6640@xz-x1> <X+Er1Rjv1W7rzcw7@google.com>
In-Reply-To: <X+Er1Rjv1W7rzcw7@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Dec 2020 15:33:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEp-D36h972CBHqJ-c8tR9fytg9tesZ1j_9B0ax9Ad_Q@mail.gmail.com>
Message-ID: <CAHk-=wiEp-D36h972CBHqJ-c8tR9fytg9tesZ1j_9B0ax9Ad_Q@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
To:     Yu Zhao <yuzhao@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Nadav Amit <nadav.amit@gmail.com>,
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
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 3:12 PM Yu Zhao <yuzhao@google.com> wrote:
>
> I can't say I disagree with you but the man has made the call and I
> think we should just move on.

"The man" can always be convinced by numbers.

So if somebody comes up with an alternate patch, and explains it, and
shows that it is better - go for it.

I just think that if mprotect() can take the mmap lock for writing,
then userfaultfd sure as hell can. What odd load does people have
where userfaultfd is more important than mprotect?

So as far as the man is concerned, I think "just fix userfaultfd" is
simply the default obvious operation.

Not necessarily a final endpoint.

                 Linus
