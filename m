Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5373300DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbhAVUht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbhAVUgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:36:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7EFC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:36:15 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id h15so1469355pli.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VF9PXgscDiw2bV9roOwBYj7Ni8JoEIUlUfg2Tt6aYLc=;
        b=gDKtSV/suEqKn7sT9M/+wWzqISKA8yoOH+qUgrgZFOWGZDatinsFN4XtuaAGoYiP2I
         Z7l9r42B/xHwLcz1XJcoB/uKOC0yUZNQIqVfiOAud7z5XHI25JVhPelyyNYNdn3eRfHv
         mTW28itU4GgA86hghIIW6EioJp/lRvQYq9I5zdcWqzgtTBXPczEG3NTL3zCwtMnltb4N
         M0nACGd2DdAeTPkL2+48t/f4O0xmJ++ijN+jmSOhzV35UYxN4IQwB4F6irk8vfal0rvo
         1KaAYYnms5x+Y1+aGAX2dnYhf+kHmiOpYmfuVMQFgbpzVPg1UW78aKjXCe6Zt1q4Z1Bl
         MiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VF9PXgscDiw2bV9roOwBYj7Ni8JoEIUlUfg2Tt6aYLc=;
        b=ewXC0zwbNXziH1MROUkFZTGlCO8LV5OYNFVcsM9aTd6+QxvlINsAcF6IBbu7uvsbqr
         5doYR7+QYKA+XIO7GDqu3Rg5gCnczAqjqDE2WJNb0NhZMk94alH4Q9SOM1ygXdEmBuyX
         gH7z3OJV2aUTXDOeMDq6mFJKfSGBld/GdLzu9gqsMxrff3O6G6JTCPW7FnuwN0lb45hQ
         5YLeOBuzqM9Zs8VNDvvOyg8x2KzD7NE4uajKRRZw8Bq/mCGZ39AXKXIkF6fjGRO5MLx2
         B+uvIgWDLCfD+b1zpFlNoR6y6vluzS9i5dx3Wnseetjxl7G/05ABtqjJlwiqCjt9J2IO
         7ZKA==
X-Gm-Message-State: AOAM530PaUc/5STbNNKJEyDiFudEZr8b2WE7iTVYFamc0DfmNwUYq2uZ
        TwRWaAoaP4sFQXqFx/GUPCiJWgDHGZvIpUkBqgfRoA==
X-Google-Smtp-Source: ABdhPJxNXMRujBi/GKsKIEpiTCjXZZ6aaNJYDXAD2jhkVZe6+VRkES8E3a+dPtVj1D1v4M91sHrvun0IHmGezsKR744=
X-Received: by 2002:a17:90a:da02:: with SMTP id e2mr7335587pjv.173.1611347775078;
 Fri, 22 Jan 2021 12:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20210120072547.10221-1-yashsri421@gmail.com> <e5c5f8495fbdd063f4272f02a259bbf28b199bdd.camel@perches.com>
 <14707ab9-1872-4f8c-3ed8-e77b663c3adb@gmail.com> <fb1b511d71761c99a9bece803f508b674fce9962.camel@perches.com>
 <98d40817-1f80-c772-eb9e-a6c3c04625b3@gmail.com> <27366417ad75e0300d4647f776ca61bb1b132507.camel@perches.com>
 <bd560a8e-7949-933a-e4a9-508cb42c2570@gmail.com>
In-Reply-To: <bd560a8e-7949-933a-e4a9-508cb42c2570@gmail.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Fri, 22 Jan 2021 12:36:03 -0800
Message-ID: <CAFP8O3+g3KDe1eepGiCXqwMU6K2ve_2ai69WRBCORrr5UAJT+A@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add warning for avoiding .L prefix symbols in
 assembly files
To:     Aditya <yashsri421@gmail.com>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        Mark Brown <broonie@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 12:13 PM Aditya <yashsri421@gmail.com> wrote:
>
> On 23/1/21 12:40 am, Joe Perches wrote:
> > On Fri, 2021-01-22 at 18:48 +0530, Aditya wrote:
> >> On 21/1/21 12:13 am, Joe Perches wrote:
> >>> I believe the test should be:
> >>>
> >>>     if ($realfile =~ /\.S$/ &&
> >>>         $line =~ /^\+\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
> >>
> >> Joe, with this regex, we won't be able to match
> >> "jmp  .L_restore
> >> SYM_FUNC_END(\name)"
> >
> > I think that's not an issue.
> >
> >> which was replaced in this patch in the discussion:
> >> https://groups.google.com/g/clang-built-linux/c/-drkmLgu-cU/m/phKe-Tb6CgAJ
> >>
> >> Here, "jmp  .L_restore" was also replaced to fix the error.
> >
> > Notice that this line was also replaced in the same patch:
> >
> >  #ifdef CONFIG_PREEMPTION
> > -SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
> > +SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
> >
> >
> >> However, if this
> >> regex(/^\+\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) is
> >> correct, maybe we don't need to check for $file as we are now checking
> >> for just one line.
> >>
> >> What do you think?
> >
> > The test I wrote was complete, did not use $file and emits a
> > warning on the use of CODE_SYM_START_LOCAL_NOALIGN(.L_restore)
> >
> > I think it's sufficient.
> >
>
> Okay, Thanks.. I will send the modified patch :)
>
> Thanks
> Aditya

I am slightly concerned with the direction here.   jmp .Lsym is fine
and is probably preferable in cases where you absolutely want to emit
a local symbol.
(there is a related -z unique-symbol GNU ld+FGKASLR thing I shall
analyze in my spare time)

If the problem is just that STT_SECTION symbols are missing, can
objtool do something to conceptually synthesize them?
