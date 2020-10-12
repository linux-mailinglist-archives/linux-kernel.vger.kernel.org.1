Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EA128C01B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgJLS5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgJLS5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:57:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E33C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 11:57:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c21so17874528ljn.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 11:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lprN5cwXxgg0fkExcWkwF6M0UrLd8DkiuL9nvugSqU=;
        b=L/aCV2yPKMbgiGB5D/DxhDo8SA8yk9SwZSpKtzzThF9eCi+Q7AYNeuhFp7SKfAAqw1
         PfMYtZ1tm8HIpj+I6CBdDgKJbxHv09+CGEdk45n/tPBKFabluvuV2oXzCfRhvr+1myxX
         KBcocjYIgsNWGaS0fCEkoFayVwc1qq7R1mlH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lprN5cwXxgg0fkExcWkwF6M0UrLd8DkiuL9nvugSqU=;
        b=CwLfvwBbWXTcjXLolMHQV5LF3bwDBPttwpgPX5FLwoo07koEFeBRHnjH1kehJOKiTl
         60bWLJ2EIa/HggEjoaOSVwzo2SuOd2Hc9ajeEDFNj4Oe22bM1jJmeu4XvVHaJ9gCmlMA
         6uLgowM+b5bVS408njR6sHW0u1gCu+2nor3BogB7NPrjEy9ZmPDB1WxlqSyhzuhKYyLF
         Tv459Wy6QxckzuEr2m4x933JGybYNpalGz5EpPtK/QGQFsmnEJU2uG+lGOUao+gnDsuD
         hudMP45f95jvo0ghzVQJSb3jBI5upFlAB+VfzUwBOtK5RPDE2mQjgp+pBFb8XsXo3t3b
         B5Cg==
X-Gm-Message-State: AOAM531UmgsUTVJ00Ya3jM7i1Sxr2fkuM/xfCbq2/s1tSnhcvV2JhOAw
        P/X2QEaWmRJuvt6VRUSIEmomaXIg1FVfiA==
X-Google-Smtp-Source: ABdhPJzIUfhRAoFFZn8nwUAssQpYg3IyV5yk+TgwbRPUcQc5p7Wp91hYLbT0WP+8/dZxP1zlH8eyQQ==
X-Received: by 2002:a2e:88c2:: with SMTP id a2mr8425157ljk.438.1602529022594;
        Mon, 12 Oct 2020 11:57:02 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id c17sm1055740lfi.35.2020.10.12.11.57.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 11:57:01 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 184so19410064lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 11:57:01 -0700 (PDT)
X-Received: by 2002:a19:cbcb:: with SMTP id b194mr2048353lfg.133.1602529021618;
 Mon, 12 Oct 2020 11:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201012110557.GK25311@zn.tnic> <CAHk-=wiVoLoZS1v9SCQzH4mkpz6akE3pPrHPxM2hamOXPcaW9w@mail.gmail.com>
 <CAFULd4Z1_UKN6haGbNJMi0_tGddPZcawRDfoYnLdn-Qe6UR3-Q@mail.gmail.com>
In-Reply-To: <CAFULd4Z1_UKN6haGbNJMi0_tGddPZcawRDfoYnLdn-Qe6UR3-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 11:56:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbEhjSHR7D=8Q_xARd=UKHGcz750LoT1BeRdgTR+6uSw@mail.gmail.com>
Message-ID: <CAHk-=whbEhjSHR7D=8Q_xARd=UKHGcz750LoT1BeRdgTR+6uSw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm updates for v5.10
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Borislav Petkov <bp@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:41 AM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> GCC does not distinguish between %ah and %al and it is not possible to pass "%ah" to the assembly. To access the high part of the %ax register, %h modifier has to be used in the assembly template.

Do you know whether that's true for clang too, for example?

Also note that even if the _asm_ might get "%al", maybe the compiler
decided to use "%ah" for something else?

I have memories of gcc using the high registers at some point, but it
might have been some special case code - and it might also be very
historical.

[ Goes off and checks ]

In fact, I can still find gcc generating high register code, although
it's quite possible that yes, it's only peephole bit extract
instruction kind of use..

I also find that clang generates code that uses the high byte
registers, although again, that's not from any knowledge of clang
internals, and just by looking at my kernel image disassembly.

So yes, it _may_ all be just peepholes, but it's not obvious that this
is all safe.

                   Linus
