Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850702CB0CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 00:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgLAXcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 18:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgLAXcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 18:32:42 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D8C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 15:32:02 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id z23so3416249oti.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 15:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qatnj/FNqaZ+ECXKGoFl0+ahWNatAD/GWmAFXeDRJQM=;
        b=awn9xZYFYPP8d4N7JYbiimYAXu2Qt6OiesaX9d0YsLeK5vBZ6zjJorN0ylQ9Mm4e8r
         hSX6nk+pRrn3FhJmhGaPhVHJf0ayigkpjjbjBGHaC7UnmkJel98ElBUUCUeJ+egvLrAk
         Z/JohGhI1i+7Gu6dMdOBcOaCo8Mof41wF+3y8bADMhapKhMiMGQkXak6lJPgu0uuw4s4
         KXjC+4sNZosHOvcNSu/h+y/YbCgjo9TOPT+G5tNzTRXq+yV7eR1qCwEFwRFTGwozppeo
         pSweIifim5oan7zodp/2a4dYpMcSn+HQAgDKZOxkwXXpep8p60T59Yta9vanVcF+00Pi
         OgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qatnj/FNqaZ+ECXKGoFl0+ahWNatAD/GWmAFXeDRJQM=;
        b=OPd62Y073BEtaUET5lgl9uxsO+ql6mgv7fDk+DR+89IValMKFzAXVJzxlR/xzdS0KA
         8/M2V3d48i4+3OkiCKp10oGNy3L43SjE1+8oGihOhuo+D9LZ+33IjNQbO3wi4f7CN9kP
         E8qR6UkU1YFEUOf+IoFd02TPtJm40RoBNTa3Q6yO00wA5epA/8a3a5pBbAaF+a+VV7qB
         Rpi7PA+nnomzkumT19eL6xvHzxTBGIY4f1jojqnY+SYVEN/+aFP4NQstbS4MJ6AtEeva
         alLvw6pUzrnE+0uy58rDQC1/ybbR/xacrt8voWZWh7rH/h7H4oF4mr6vl/HQ947yWthT
         xu8g==
X-Gm-Message-State: AOAM531s/lxkifzaTZBsmBr0TUmn+duBKTkOsKuqcqQeNsd1zPe/gb1s
        8ldTOKzUZGHy5l/pcttPCIHOyMalyCr0NOXB4h/0tQ==
X-Google-Smtp-Source: ABdhPJz/36KpN1WvMgoRTCuz9DIhS7HBCPsjrvLJzDcsAseeN5SvuBZkEgRGwYf1aPe0KsPwYmZQN2oA8wwIn6w9Vvo=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr3704860otk.251.1606865521640;
 Tue, 01 Dec 2020 15:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20201116054035.211498-1-98.arpi@gmail.com> <CABVgOSkoQahYqMJ3dD1_X2+rF3OgwT658+8HRM2EZ5e0-94jmw@mail.gmail.com>
 <CANpmjNOhb13YthVHmXxMjpD2JZUO4H2Z1KZSKqHeFUv-RbM5+Q@mail.gmail.com>
 <CABVgOSnGnkCnAyAqVoLhMGb6XV_irtYB7pyOTon5Scab8GxKtg@mail.gmail.com>
 <CAFd5g4768o7UtOmM3X0X5upD0uF3j-=g3txi0_Ue3z8oM_Ghow@mail.gmail.com> <505b8cd0-a61e-5ec3-7e0b-239d0ff55d56@linuxfoundation.org>
In-Reply-To: <505b8cd0-a61e-5ec3-7e0b-239d0ff55d56@linuxfoundation.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 2 Dec 2020 00:31:49 +0100
Message-ID: <CANpmjNMOMD+2OhBWNh5XuFufbm1bhXTUm4Y3_YiNNdfC=G2xdQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] kunit: Support for Parameterized Testing
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Iurii Zaikin <yzaikin@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 at 23:28, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 11/30/20 3:22 PM, Brendan Higgins wrote:
> > On Mon, Nov 23, 2020 at 11:25 PM David Gow <davidgow@google.com> wrote:
> >>
> >> On Mon, Nov 23, 2020 at 9:08 PM Marco Elver <elver@google.com> wrote:
> >>>
> >>> On Tue, 17 Nov 2020 at 08:21, David Gow <davidgow@google.com> wrote:
> >>>> On Mon, Nov 16, 2020 at 1:41 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> >>>>>
> >>>>> Implementation of support for parameterized testing in KUnit. This
> >>>>> approach requires the creation of a test case using the
> >>>>> KUNIT_CASE_PARAM() macro that accepts a generator function as input.
> >>>>>
> >>>>> This generator function should return the next parameter given the
> >>>>> previous parameter in parameterized tests. It also provides a macro to
> >>>>> generate common-case generators based on arrays. Generators may also
> >>>>> optionally provide a human-readable description of parameters, which is
> >>>>> displayed where available.
> >>>>>
> >>>>> Note, currently the result of each parameter run is displayed in
> >>>>> diagnostic lines, and only the overall test case output summarizes
> >>>>> TAP-compliant success or failure of all parameter runs. In future, when
> >>>>> supported by kunit-tool, these can be turned into subsubtest outputs.
> >>>>>
> >>>>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> >>>>> Co-developed-by: Marco Elver <elver@google.com>
> >>>>> Signed-off-by: Marco Elver <elver@google.com>
> >>>>> ---
> >>>> [Resending this because my email client re-defaulted to HTML! Aarrgh!]
> >>>>
> >>>> This looks good to me! I tested it in UML and x86-64 w/ KASAN, and
> >>>> both worked fine.
> >>>>
> >>>> Reviewed-by: David Gow <davidgow@google.com>
> >>>> Tested-by: David Gow <davidgow@google.com>
> >>>
> >>> Thank you!
> >>>
> >>>> Thanks for sticking with this!
> >>>
> >>> Will these patches be landing in 5.11 or 5.12?
> >>>
> >>
> >> I can't think of any reason not to have these in 5.11. We haven't
> >> started staging things in the kselftest/kunit branch for 5.11 yet,
> >> though.
> >>
> >> Patch 2 will probably need to be acked by Ted for ext4 first.
> >>
> >> Brendan, Shuah: can you make sure this doesn't get lost in patchwork?
> >
> > Looks good to me. I would definitely like to pick this up. But yeah,
> > in order to pick up 2/2 we will need an ack from either Ted or Iurii.
> >
> > Ted seems to be busy right now, so I think I will just ask Shuah to go
> > ahead and pick this patch up by itself and we or Ted can pick up patch
> > 2/2 later.
> >
> > Cheers
> >
>
> I am seeing
>
> ERROR: need consistent spacing around '*' (ctx:WxV)
> #272: FILE: include/kunit/test.h:1786:
> +               typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 :
> (array);        \
>                                    ^
>
> Can you look into this and send v10?

This is a false positive. I pointed this out here before:
https://lkml.kernel.org/r/CANpmjNNhpe6TYt0KmBCCR-Wfz1Bxd8qnhiwegwnDQsxRAWmUMg@mail.gmail.com

checkpatch.pl thinks this is a multiplication, but this is a pointer,
so the spacing here is correct.

Thanks,
-- Marco

> thanks,
> -- Shuah
