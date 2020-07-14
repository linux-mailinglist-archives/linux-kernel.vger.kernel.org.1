Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3329A21F7CD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 19:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgGNRDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgGNRDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:03:00 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDED8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:02:59 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id x9so14820132ila.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hb+jD9n5+9xpnE7B/LBnTZz9Tl2kSY4iRvV+XR2VR9s=;
        b=prGW8xYMA3U04VmXt/eqhzdeGjMwKu65HwSHkGIj+wEvYFI235boc9nAFR8Kh5+BuD
         DE1tiGT753DF0+h+x/TZAbpQWdNj/JsItTtkZOEQLfulddZvDFim4Q/lnE8y16sid+Jn
         WlxBeY4Zd9l8m+Y1C51TEax1lLSIYWaeaKyMsnlVREGJYiA8PyaRZhCfb9c2baSYx8qc
         zW80kyN4umJ2slIK3oS/0YpFZRTZsQbvPubPlBFr7M/y9JmHyRteURxm1L72f3Itqrni
         ynYs2IaL5y8qGnHhneu9oDsNiYvfBVu37d56DibxNAm4pUEKTR8eiGH2IB4ht6hzO9tY
         Ws4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hb+jD9n5+9xpnE7B/LBnTZz9Tl2kSY4iRvV+XR2VR9s=;
        b=toBNjHB9wjpKo0ehBkrOggZfV3lr6OHaJZhxwi1c6ixoJvWZK2dsM0CXavdra24Z0n
         NJ+gXj4svz6EXvf2y1SMUEeUIPr8qDucw+uPN8lXXdr1YmmfD2SK2ooxZjp6TNWc4iLm
         U1z3lLVHZRol9G+e2xQ3eiMvuIgvJfDeH34h3nvrzBjO1V2Ge1AvVkJ6/rmSEWEzZdMU
         co4FHXzLpYGiVhWuqD279LVQ94je5/QBtVwwoO2JdHUTnGmKqkDZIBs1iMaCXEPxcpja
         14ic2qlWldYo+mkfmV0iGZcNQJNgZFkKumirW8AufCVCXIaZo6xFExr49fd0AVvOHog2
         CUqQ==
X-Gm-Message-State: AOAM5306OhsZLW9eymjopSVkSZhCRl6gTFtMMDDGirZP9v8hgQPMNKWe
        +AyFHhZdXhxFhC5HrhLpzGibNs7FnGkPrxkDCuWQXWI=
X-Google-Smtp-Source: ABdhPJyGa8ZTsGJ1rTjvuFyI+vq7yVyouhUYqqdgxcAfBDqGIXiA5MxfNCvwwWxAkPqoeXkX07nGAV5m91nAOyDVsQ0=
X-Received: by 2002:a05:6e02:e43:: with SMTP id l3mr5478271ilk.11.1594746179266;
 Tue, 14 Jul 2020 10:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200616142315.375918-1-brgerst@gmail.com> <20200714064004.GA32655@lst.de>
In-Reply-To: <20200714064004.GA32655@lst.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 14 Jul 2020 13:02:48 -0400
Message-ID: <CAMzpN2gg4H5qnU8Dk=bCaEm2WdRF-synfpf_yUaK8L6vyuo=zQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] X32 syscall cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jun 16, 2020 at 10:23:13AM -0400, Brian Gerst wrote:
> > Christoph Hellwig uncovered an issue with how we currently handle X32
> > syscalls.  Currently, we can only use COMPAT_SYS_DEFINEx() for X32
> > specific syscalls.  These changes remove that restriction and allow
> > native syscalls.
>
> Did this go anywhere?

This approach wasn't well received, so I'd just go with this as the
simplest solution:
https://lore.kernel.org/lkml/CAK8P3a17h782gO65qJ9Mmz0EuiTSKQPEyr_=nvqOtnmQZuh9Kw@mail.gmail.com/

--
Brian Gerst
