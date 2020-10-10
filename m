Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34856289EA1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 07:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbgJJFrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 01:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgJJFnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 01:43:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8107C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 22:43:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o8so5528360pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 22:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFwAQEfRAq8FtPUZLvTkvSzxZYBk8EF9wpuaJH7X7GY=;
        b=Igmi6UxLzccnc2TE+34dHjbp7LfrvPqUECDYUDNjjBAoj8bFcnZ3pUuS4pD13CdsnD
         JTufCaRuZFI8EFfJd0gdMJpn9Ymuq8gsJ4kXo/OjGkmniazSyqGkzY/shaG/K6cCv3+V
         /8k3/Y/OYtNOGCnAvebc9+0xVEXF+Cx9VXwm6LrtTxmPD068srK1ZYPmeT53A/+g5zyw
         q5YUatkkQx02jtC1/dVLADaxbFPPpgVNk2HnFKYkk/x1lwooJUsK84UOeU5l2DMYsS2N
         eXZMnpTWTG3t5oF8FcwupyOdGPoaRDLhOQq7RjubF48NNKCi4OTSZOhTqkONO1++xdLW
         IYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFwAQEfRAq8FtPUZLvTkvSzxZYBk8EF9wpuaJH7X7GY=;
        b=Qlu4FcIGYXAcm3a4RYOOvNkbq5LxO7GMqSmz+ysBHjz8U7RT5Cb3sDHGCp3aG347CR
         ZSEa7kwF5EoTv7RB3XSDW60Gkqst5ruNUNGTI9UgEoDb3P8Zs86uKa3cXQhVtAZwO09u
         MAEn9F8hyTcJivWY5jyNeVi5JXnzFKole+w54Ih2NCYjMy3PSDrYS5FP4RQi7wnWM0E9
         7NeLTXAzPzax7U+kZ9Xx/K5uxbG5Fmw7DXgmTJXBMAlPB/pKDcYV0woZSUvPkphkTHht
         OqZVeoM5XlLMTgsKizd2CZ0YnNAYa+Cx5coPX6jT01zYtdj83ppcFgKhkYBTGJ6BNPuS
         PQXA==
X-Gm-Message-State: AOAM532+/LP43hNEv2FQ8JP42GvPEP5Jl4MIqUNwC0xaS1IoRI0EcPQO
        K2VyOEOpUQjYei/szZsqTSeWWmXZQq2ZelecNhZb1Q==
X-Google-Smtp-Source: ABdhPJwXfmNuJgEHIdyho6pdwZBoaygjLew4trl1rGVoAGD6VfneLi3tBm/wiT7MqbfIZaH5DN3JlWSsYhRH9SqwjAw=
X-Received: by 2002:a17:902:7087:b029:d3:f1e5:b629 with SMTP id
 z7-20020a1709027087b02900d3f1e5b629mr14635001plk.51.1602308618238; Fri, 09
 Oct 2020 22:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200729175849.148332-1-vitor@massaru.org> <CAFd5g47s09BfsqNx2RY1Zdp-TC4KbKgsMgr9-SHv1Nf6P9vAMQ@mail.gmail.com>
 <cfcb01c087fdd9f22a875721444a7659bceec05f.camel@sipsolutions.net>
In-Reply-To: <cfcb01c087fdd9f22a875721444a7659bceec05f.camel@sipsolutions.net>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 9 Oct 2020 22:43:27 -0700
Message-ID: <CAFd5g45o-tiDCmbeoo2KEF0bSqsFUpULgmgEGf=ra+eYHm30xA@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add bitfield test conversion to KUnit
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kvalo@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 3:00 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2020-08-19 at 14:10 -0700, Brendan Higgins wrote:
> > On Wed, Jul 29, 2020 at 10:58 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
> > > This adds the conversion of the runtime tests of test_bitfield,
> > > from `lib/test_bitfield.c` to KUnit tests.
> > >
> > > Please apply this commit first (linux-kselftest/kunit-fixes):
> > > 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
> > >
> > > Code Style Documentation: [0]
> > >
> > > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > > Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > Probably still want a review from Johannes though.
>
> Huh, sorry, this slipped through the cracks.
>
> Yeah, don't really care, looks fine to me? I'm not familiar with the
> kunit infrastructure much yet.

Cool, well in that case I will apply it.

> Not sure I see much value in converting TEST_BITFIELD_COMPILE to a
> KUNIT_CASE though, because anyway it will not compile if you enable
> that? IOW, just leaving the function there without any KUNIT_CASE()
> reference to it should be fine and saves you an ifdef ...

Well I think it is also the case that we only want to count the test
case if it actually has everything to run; that is a point that is
somewhat up in the air. David is exploring adding the concept of
"skipped" tests to KUnit, but we don't have that yet.

Cheers!
