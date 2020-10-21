Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C42952F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504627AbgJUT11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410912AbgJUT10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:27:26 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75787C0613CE;
        Wed, 21 Oct 2020 12:27:26 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id s89so2726769ybi.12;
        Wed, 21 Oct 2020 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5bP6XIkGVul48ky/KDK8Sf+FXg+duJpCHq4dGdE0Uc=;
        b=uqNbSPg2N+D4M2VYaciAM0hkRnUBai1TE0HHRw4tO+V1T6pN0WL+8A+o1HNVVBFG7y
         f69nrXiryg627GNoDJNnsCo7bwLIBFHmWJZkH7Vr+cbjwoZNsBc8ZQGWBFUE+PTsmVhR
         ytFRs5vstUD5vzKl9bGsDYo9FWn432XKW8tjz3LXmep4PgqlFqXB7LvbU8aK/9A0dBuj
         WEvDBqMbRvdgyVlo62RcrFKK/1Kii1kwQ1hCnLYC/yciZS4+pIa8hysvm90mrlbYK1Bc
         eMFfQ3VQAVq2eEBAgD4d8CIoVxSZchh6MCCqP9py589vIhG+qmhB5cK+YAfNC0PhaKHN
         xAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5bP6XIkGVul48ky/KDK8Sf+FXg+duJpCHq4dGdE0Uc=;
        b=SJn4DzzoRoNDcV3Q+FUcLhXEXPrxc21sI1rLd+0lorqlDR3QoR5ABIdKuwRIX5vk+H
         /+/QT3ep614947NveWr5IFv+Q26F93z+sDtGCa4SdGZ/Os/plaVgPSilDQQX1Sp5IWCx
         Ux7CAIdyoGVAmCi8MJJhyIAjrBoKU7UvESz2ZJEhhXIFQtzlo2UC0o0ln8+6h83/VkFd
         hI/FPJPDCUVI8tHdcI89BVWU7891N5He/j+sGoQwZIZqV3pN0WhjatG3fNw59+MsfK3k
         dE1iDcgy3SPaFJAFO3kyGCYk33wmSeh0IhDDLjmYtSPHDi4zcGETkIwM3b1lVldgz759
         RSQA==
X-Gm-Message-State: AOAM531RInEwv+zHqrBkuyv0gl21FxTB01AF0GGI03Sw08EU49+bvmBz
        Q9Ij+IMa1/UOKPsZ99qTAnuuzZnkXZEcziMSMJA=
X-Google-Smtp-Source: ABdhPJwQ6oGRTDWlUSCRHr+DJeqvZ2WuZgEP28Ztn/Hrj9Fa0J0N+ETgyk0HLKGxwill/jIORyeZV9VzqnCqlk4nHQo=
X-Received: by 2002:a25:d441:: with SMTP id m62mr7622555ybf.422.1603308445783;
 Wed, 21 Oct 2020 12:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200629003127.GB5535@shao2-debian> <20200630124628.GV4817@hirez.programming.kicks-ass.net>
 <20200630144905.GX4817@hirez.programming.kicks-ass.net> <58ff47cc-dc55-e383-7a5b-37008d145aba@gmail.com>
 <20201021080031.GY2628@hirez.programming.kicks-ass.net> <20201021131806.GA2176@tucnak>
 <20201021134436.GJ2628@hirez.programming.kicks-ass.net> <CAKwvOd=qi63We=6rLapb565giCVe-8a6d=-=3VZL6RWzhwAeZg@mail.gmail.com>
 <CANiq72m+_QYtn_1gyrjXFs6yeDdiMoS4DVcWqYcTgyCFnSFXbw@mail.gmail.com> <3ec15b41754b01666d94b76ce51b9832c2dd577a.camel@perches.com>
In-Reply-To: <3ec15b41754b01666d94b76ce51b9832c2dd577a.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 21 Oct 2020 21:27:15 +0200
Message-ID: <CANiq72kfuDfHeL9Eb9e7PccZ+L9wMpnBj_gtFj3-aFfcvYuskA@mail.gmail.com>
Subject: Re: GCC section alignment, and GCC-4.9 being a weird one
To:     Joe Perches <joe@perches.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, Aditya <yashsri421@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKP <lkp@lists.01.org>, Kees Cook <keescook@chromium.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 8:35 PM Joe Perches <joe@perches.com> wrote:
>
> Perhaps something to add as a generic test in checkpatch.

Agreed! It would be nice to check all of them. Even checking for
`attribute` and `__attribute__` could be potentially reasonable (i.e.
so that people are reminded to consider adding whatever attributes
they need into `compiler_attributes.h`), although perhaps too
annoying/noisy for some (e.g. for `arch/*` devs...).

Cheers,
Miguel
