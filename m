Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C90E2C337E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbgKXVpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgKXVpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:45:44 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B63C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:45:44 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id n137so340891pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qUk28dgg2DUj1+6HYL179P0h9eGbzR54HIME/VXKOvg=;
        b=eRM5pcDjTejd77WL4qH2l3Waz69TXUmimfeFmBp2KHeoI2kfUj04HHD+5AX5l7h/w1
         itFs9VMoa+OfcKZEFM2+nNziTHhP1TuagNH1mSUGrd7szPzTIDoItWAQpcFZaq7E0jDr
         YVscjYb/iBIjuSqEbH0Z5p2PzgyBUZdEvhQRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qUk28dgg2DUj1+6HYL179P0h9eGbzR54HIME/VXKOvg=;
        b=OSh3sTHKrFl/c/IGHYyDewKwveGKyJ1BIOvh0L1z5NoD5SSyGHTCcYLJjy0gLpJ4cR
         qmvNC+AAL87hXKBB0e5vMpnrwC8XCTbULVWVub6k8iuHtqaZCfO8ejP2u562/KHs92JB
         kFe1TxLvE/ryGuaTSx9LqzuSnJj/AqjkADAgR1vEA0VQoNlLzedEavE+OoLc2HWZa7WP
         urglQT4wTeWpxdtGn95xyAMnNToZkNk+G9pRxQJhxPL7Y5Dt8etWNAwm5s57jD1LC2z5
         R6a/EoAX7CoiDy4UvWHzuPVyAktW1RKIH1O57qXSzUqEolYVRNy4bAeZPuEIibEHhOBg
         IjwQ==
X-Gm-Message-State: AOAM531Q6a1rzwXtdEDkZ7BForg/lzpzPD1MvJBpAaGWBPZ6fxxe/I+R
        TO3DsWn7xcSrVpYGlXoY0duh8A==
X-Google-Smtp-Source: ABdhPJwv8R+bkXuk+Z/BW6O2He05dVF33WUNfAsVqf9ApwHY3+AZ3TRvyrcxfXYudQSX8IyrNUawFA==
X-Received: by 2002:a63:cf52:: with SMTP id b18mr344446pgj.338.1606254343911;
        Tue, 24 Nov 2020 13:45:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z10sm17931pfa.149.2020.11.24.13.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:45:43 -0800 (PST)
Date:   Tue, 24 Nov 2020 13:45:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        YiFei Zhu <yifeifz2@illinois.edu>
Subject: Re: [PATCH] entry: Fix boot for !CONFIG_GENERIC_ENTRY
Message-ID: <202011241345.FAF4D7E@keescook>
References: <CA+G9fYs9sg69JgmQNZhutQnbijb4GzcO03XF66EjkQ6CTpXXxA@mail.gmail.com>
 <CAK8P3a1Lx1MMQ3s1uWjevsi2wqFo2r=k1hhrxf1spUxEQX_Rag@mail.gmail.com>
 <CAG48ez17CKBMO4193wxuWLRQWQ+q6EV=Qr5oTWiKivMxEi0zQw@mail.gmail.com>
 <87h7pgqhdf.fsf@collabora.com>
 <87a6v8qd9p.fsf_-_@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6v8qd9p.fsf_-_@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:54:58AM -0500, Gabriel Krisman Bertazi wrote:
> Gabriel Krisman Bertazi <krisman@collabora.com> writes:
> 
> > Jann Horn <jannh@google.com> writes:
> >> As part of fixing this, it might be a good idea to put "enum
> >> syscall_work_bit" behind a "#ifdef CONFIG_GENERIC_ENTRY" to avoid
> >> future accidents like this?
> >
> > Hi Jan, Arnd,
> >
> > That is correct.  This is a copy pasta mistake.  My apologies.  I didn't
> > have a !GENERIC_ENTRY device to test, but just the ifdef would have
> > caught it.
> 
> I have patched it as suggested.  Tested on qemu for arm32 and on bare
> metal for x86-64.
> 
> Once again, my apologies for the mistake.
> 
> -- >8 --
> Subject: [PATCH] entry: Fix boot for !CONFIG_GENERIC_ENTRY
> 
> A copy-pasta mistake tries to set SYSCALL_WORK flags instead of TIF
> flags for !CONFIG_GENERIC_ENTRY.  Also, add safeguards to catch this at
> compilation time.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Thanks for getting this fixed!

3136b93c3fb2 ("entry: Expose helpers to migrate TIF to SYSCALL_WORK flags")
Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
