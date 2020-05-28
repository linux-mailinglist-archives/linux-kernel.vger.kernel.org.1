Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533811E6A15
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 21:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406045AbgE1THe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 15:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406193AbgE1THY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:07:24 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC40C08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:07:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so11973611plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VwOVkU0O5MPTy6BNN6XbEIcSAUqdb5AHofI+QJezuPI=;
        b=uDW5ODyyxREse/z9nXtUVNzYSUM3rxmiKouMrW0jQ4pjS6v1fwxsd/yw3a/ZOhLjGv
         +jxGfyDsoKrn60aSTMmdCEZ2GchIZiuChuz/1AE6nf0dyurPkh4aVOWLNA/wdcuWoQmU
         oOrU3dKuigLmoTXchnDB47CeNglHPROppF6lxw+UKA//5w9cqkkW8LdHMQHyPK6SUGyO
         GCbw8fY9NUY6foqe4PtpNWnbJ82ESuHOCefXC/FkqMmVTJWfp1TBB+jyO+x91mphMZEI
         wdves0btscFepzUrFDrHsvalWOOYRZfS5Kyq0euFgY4kpm6EmhBKzRzD4vzd8i8gIdpz
         gLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwOVkU0O5MPTy6BNN6XbEIcSAUqdb5AHofI+QJezuPI=;
        b=krsb966nqOVHWsIv7o6BE2ziiomGEIueSr1uiB8MYAcN1PiM7ghfCa4B4h3T7S0+2D
         hQjfXDUHCk/IUIAyFMzRHqtPmNaYj3GGjc+8vRGji1JcjnjQB5atXcUqqS3Qc1bzQHuw
         Dheo+odItZ90Dp2cYWGSaz6PqPxOk72SnQ9w+hXSQrirOYWmZ1fSwi1EMUFcmP0LT3DP
         GHP2nIGvWqM3TRbb6vc1yo3PuUK45a2/ubaBdE76NKfhh9mba6a7GDTOJi03NxA0/oQp
         rSXujp8lPWjurfwYDlazA30HiPCCOrAkCLxDC/Ub9Y8DTy2IONeAGiM+hsPENDUIrHzr
         SyUQ==
X-Gm-Message-State: AOAM53064aYadqWo3jieglR1kFAgDT6SangxgtLQLUw38y/4qy7xJnAD
        XaqZG1pAZd2kKWoo1zWBqMhJcVjI7OsbovZ8DhZvCw==
X-Google-Smtp-Source: ABdhPJyHjlcrtJrC+9HghnaFLvsYtvx90pMxGJn0t37UYFwj6H/4l9P4f/thKbVZ/294rQqkIqrgjWfA3AjwOQYQKbs=
X-Received: by 2002:a17:90a:17ed:: with SMTP id q100mr4950842pja.80.1590692843445;
 Thu, 28 May 2020 12:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200511131350.29638-1-anders.roxell@linaro.org> <CADYN=9LkA2h6dANREfPQq4iDvVEJX1wAdxjv31mpVBkaM_g0ZQ@mail.gmail.com>
In-Reply-To: <CADYN=9LkA2h6dANREfPQq4iDvVEJX1wAdxjv31mpVBkaM_g0ZQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 28 May 2020 12:07:13 -0700
Message-ID: <CAFd5g452oiRpMa3S=F9wFsb9SRKBYXJFuusge+6=zCEFX74kYQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Enable as many KUnit tests as possible
To:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Marco Elver <elver@google.com>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 4:49 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Hi all,
>
> Friendly ping: who can take this?

Sorry, I just reviewed the last patch.

Shuah, do you mind picking this up for 5.8?

> Cheers,
> Anders
>
> On Mon, 11 May 2020 at 15:14, Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > Hi,
> >
> > This patchset will try to enable as many KUnit test fragments as
> > possible for the current .config file.
> > This will make it easier for both developers that tests their specific
> > feature and also for test-systems that would like to get as much as
> > possible for their current .config file.
> >
> > I will send a separate KCSAN KUnit patch after this patchset since that
> > isn't in mainline yet.
> >
> > Since v2:
> > Fixed David's comments. KUNIT_RUN_ALL -> KUNIT_ALL_TESTS, and he
> > suggested a great help text.
> >
> > Since v1:
> > Marco commented to split up the patches, and change a "." to a ",".
> >
> >
> > Cheers,
> > Anders
> >
> > Anders Roxell (6):
> >   kunit: Kconfig: enable a KUNIT_ALL_TESTS fragment
> >   kunit: default KUNIT_* fragments to KUNIT_ALL_TESTS
> >   lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_ALL_TESTS
> >   drivers: base: default KUNIT_* fragments to KUNIT_ALL_TESTS
> >   fs: ext4: default KUNIT_* fragments to KUNIT_ALL_TESTS
> >   security: apparmor: default KUNIT_* fragments to KUNIT_ALL_TESTS
> >
> >  drivers/base/Kconfig      |  3 ++-
> >  drivers/base/test/Kconfig |  3 ++-
> >  fs/ext4/Kconfig           |  3 ++-
> >  lib/Kconfig.debug         |  6 ++++--
> >  lib/kunit/Kconfig         | 23 ++++++++++++++++++++---
> >  security/apparmor/Kconfig |  3 ++-
> >  6 files changed, 32 insertions(+), 9 deletions(-)
> >
> > --
> > 2.20.1
> >

Thanks!
