Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF9D2951D8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503779AbgJURyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503770AbgJURyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:54:23 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5735C0613CE;
        Wed, 21 Oct 2020 10:54:23 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id l15so2529859ybp.2;
        Wed, 21 Oct 2020 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mG0a9rqNQYUWVfRTJS/8XhFObf4suQPa1m0uqfzYDHk=;
        b=D5rkEL0Xk9KXntswbHPrbo0xH/XY7nNcxp8mSGe/fs6A9y4GvHFcGaaj0wHRM8Vo3N
         LZxyWpWwUFpGCpIbdr4IgfV0wfknp8iWfM6rFlEqA4jAHgvL6RHwpM+yyps/TXDOirFw
         bdv6nkl3GEPFgyT13Fx1BNh0Ao7HmVnJbcPVb1M3mibaIUkK3RcEJz7wyjM9rKFZfo4B
         ABUSTySNa7MjDyQkxNT9doa/SNnan+UEECdyoqfzVLIMgiVM+WoQSHnsXZ9OU1RPUTNb
         nlD4EtX5T6NLvZcdp2ZZrVSxX85yTmRYaC+aJlIkjm3UDFHT+VJhJowe4z4KvTClZFV0
         OlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mG0a9rqNQYUWVfRTJS/8XhFObf4suQPa1m0uqfzYDHk=;
        b=aoxErhsn3exlCZgwX7J19EaxJ7Sg34GKwSBbehZ6viAj6qIbz3YiUHlxlYZFNbvQW2
         C9Q9eBq/neDqrfa91GI28/G0vttz2VeIS6U2tsHYjAHgjhlhpD6ieuTj+LA670X+UkcT
         pvhbt6W5afFqHdsu0DB+sP0ToUL8aFmAX9/yu0zCpfOlSjwVdNpmb3zX7o/Foicgic/9
         7wjFQRWFz5kz2LXgROpPbFz5m3Xxt6+k1P/idT6Fo/IR42iex9eXiYCPKw7AmHn/TaeN
         oDiwxjiT2MgJq76FzK93VlRo33q7YLGQyVJmXZfmAMgs5PSqk7351hhpIvawFJW0hANr
         FVQg==
X-Gm-Message-State: AOAM532Q+SKSez26OqcxF0S00wrbRIP73L3mHDaGXZh+xWFBR4qMjAzd
        BG0l/wZj+gT7/JLH4iYOHGQyhvy30iwLOPwbdL4=
X-Google-Smtp-Source: ABdhPJxImcYRm96sCxuR4y9HIlyeIhKSlywovGvIPGiHgw8VJ+Bte+uBv+K/DT7Bw3gMkJEXNYjyeORkA/1qQuUzGJU=
X-Received: by 2002:a25:ae97:: with SMTP id b23mr4316777ybj.26.1603302862474;
 Wed, 21 Oct 2020 10:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200629003127.GB5535@shao2-debian> <20200630124628.GV4817@hirez.programming.kicks-ass.net>
 <20200630144905.GX4817@hirez.programming.kicks-ass.net> <58ff47cc-dc55-e383-7a5b-37008d145aba@gmail.com>
 <20201021080031.GY2628@hirez.programming.kicks-ass.net> <20201021131806.GA2176@tucnak>
 <20201021134436.GJ2628@hirez.programming.kicks-ass.net> <CAKwvOd=qi63We=6rLapb565giCVe-8a6d=-=3VZL6RWzhwAeZg@mail.gmail.com>
In-Reply-To: <CAKwvOd=qi63We=6rLapb565giCVe-8a6d=-=3VZL6RWzhwAeZg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 21 Oct 2020 19:54:11 +0200
Message-ID: <CANiq72m+_QYtn_1gyrjXFs6yeDdiMoS4DVcWqYcTgyCFnSFXbw@mail.gmail.com>
Subject: Re: GCC section alignment, and GCC-4.9 being a weird one
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Wed, Oct 21, 2020 at 7:42 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> If you used some of the macros from
> include/linux/compiler_attributes.h like __section and __aligned, I
> would prefer it.  Please consider spelling out __attribute__(()) an
> antipattern.

+1, the shorthands should be used unless there is a reason not to (and
please write the reason in a comment in that case).

Cheers,
Miguel
