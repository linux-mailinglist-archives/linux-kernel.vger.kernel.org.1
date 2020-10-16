Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2BB2908E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410458AbgJPPwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408853AbgJPPwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:52:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367F9C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:52:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id az3so1605627pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3kC6Vgkm0RSxbZXaUeBWqyQrYh34yUHxn1mWSex6aQg=;
        b=odYcfxCnyO63/MjMhL7cfs6jP1gja2pd9uJY5C3fTUJvDuBt0YH3tRVq2JKVNtzeCI
         D8vfHkPSsL6N9G38+hY4l/69kTSE47p7QnVn6NZrEQqPwtkJgl4oXDQUJdkA6FXqSgBs
         bE82uQBBlxMgsk3ztKAXTZm0cBg8H8ZOVMpPl6yAIPq8nqdbCIUi4sPLe0vPV4stzKaE
         XitSrlYOTBRuvkq5vqUx1CfWPy1tH+knwUMt365htcT6qN0bcO8BI/WVt4aioRIDEo71
         fJNGIEGke2MNKIf89Zef56tb0PVAWGgJESO4H/AI65+Zrny/Gy6A7UglDOlZ6PABluYl
         8cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kC6Vgkm0RSxbZXaUeBWqyQrYh34yUHxn1mWSex6aQg=;
        b=HXDAj7sQ4J5iXUEXno9Wp1+ugax5CBJ5nJK9HJHwfP72RfTzTTvME6mgsnvLdDtTjx
         4Uqy2Z3nh0g7jQM+LAF/sh7KImWudbMECx7qmM05HF4DuPG2xyWcCAnWPhBXwmT7bAFc
         7eQzGP6gbvPOdID4cqfbkRb5IxKIC937e7FBK5p5J3J88qIncwUc7PtrvuF8ChnjihAT
         Au43vuZU2Ab0lMNnrTeD/SaJEbIojhGh/Lc+hLQWhQmSK8pmi4YAVjqbcRmev5li2BQ+
         qKlz7/Xz/A4wKk6y/WjG5QO2OwY1I/Vc78ObKnxSnpUzU3dPNep5f//peLJr5NPCqYRC
         AFZw==
X-Gm-Message-State: AOAM532S9DL4pysKN5Z7BRBO5Y+k37zehoddk2Etm24WsoYKDWDpCB4P
        n4JJx8r2V0QTNS9Tq8SiLoe1boey28WJzedYpAuVJw==
X-Google-Smtp-Source: ABdhPJzKFeWn8NGVQGEWxrgVRNhUiZShFKnnEiZzZe+Jnc142Ha42SGDGOCAYbMH9nbVAab1yfOBMAbJHsGnjAJlvv8=
X-Received: by 2002:a17:902:5992:b029:d5:c794:3595 with SMTP id
 p18-20020a1709025992b02900d5c7943595mr3319246pli.57.1602863573590; Fri, 16
 Oct 2020 08:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <CANpmjNOV90-eZyX9wjsahBkzCFMtm=Y0KtLn_VLDXVO_ehsR1g@mail.gmail.com>
 <CAAeHK+zOaGJbG0HbVRHrYv8yNmPV0Anf5hvDGcHoZVZ2bF+LBg@mail.gmail.com> <CANpmjNPvx4oozqSf9ZXN8FhZia03Y0Ar0twrogkfoxTekHx39A@mail.gmail.com>
In-Reply-To: <CANpmjNPvx4oozqSf9ZXN8FhZia03Y0Ar0twrogkfoxTekHx39A@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 16 Oct 2020 17:52:42 +0200
Message-ID: <CAAeHK+yuUJFbQBCPyp7S+hVMzBM0m=tgrWLMCskELF6SXHXimw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] kasan: hardware tag-based mode for production use
 on arm64
To:     Kostya Serebryany <kcc@google.com>,
        Serban Constantinescu <serbanc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 3:31 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 16 Oct 2020 at 15:17, 'Andrey Konovalov' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> [...]
> > > > The intention with this kind of a high level switch is to hide the
> > > > implementation details. Arguably, we could add multiple switches that allow
> > > > to separately control each KASAN or MTE feature, but I'm not sure there's
> > > > much value in that.
> > > >
> > > > Does this make sense? Any preference regarding the name of the parameter
> > > > and its values?
> > >
> > > KASAN itself used to be a debugging tool only. So introducing an "on"
> > > mode which no longer follows this convention may be confusing.
> >
> > Yeah, perhaps "on" is not the best name here.
> >
> > > Instead, maybe the following might be less confusing:
> > >
> > > "full" - current "debug", normal KASAN, all debugging help available.
> > > "opt" - current "on", optimized mode for production.
> >
> > How about "prod" here?
>
> SGTM.
>
> [...]
> >
> > > > Should we somehow control whether to panic the kernel on a tag fault?
> > > > Another boot time parameter perhaps?
> > >
> > > It already respects panic_on_warn, correct?
> >
> > Yes, but Android is unlikely to enable panic_on_warn as they have
> > warnings happening all over. AFAIR Pixel 3/4 kernels actually have a
> > custom patch that enables kernel panic for KASAN crashes specifically
> > (even though they don't obviously use KASAN in production), and I
> > think it's better to provide a similar facility upstream. Maybe call
> > it panic_on_kasan or something?
>
> Best would be if kasan= can take another option, e.g.
> "kasan=prod,panic". I think you can change the strcmp() to a
> str_has_prefix() for the checks for full/prod/on/off, and then check
> if what comes after it is ",panic".
>
> Thanks,
> -- Marco

CC Kostya and Serban.
