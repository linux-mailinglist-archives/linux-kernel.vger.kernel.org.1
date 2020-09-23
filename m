Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA3C276141
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 21:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIWTnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 15:43:31 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58483 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWTnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:43:31 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MPK73-1k6gbE2KXV-00PZmn; Wed, 23 Sep 2020 21:43:29 +0200
Received: by mail-qk1-f172.google.com with SMTP id 16so950714qkf.4;
        Wed, 23 Sep 2020 12:43:29 -0700 (PDT)
X-Gm-Message-State: AOAM531k+6cFCGvKlq9ZOn/bJk0PW5wC1hdxDa2ZeBc6uZC1UfC14jVB
        Sl488IehFXiaXiq5kGymroovDMzjMhrSk5O4dOY=
X-Google-Smtp-Source: ABdhPJyn6PBTLIZkNftTyKRiHCSe0jnGHmRoh0ig+i/aHp9NtN97mSHMr09kiJcYqk0qSH8c8idO3VOG5Tt00K+/tlE=
X-Received: by 2002:a05:620a:15a7:: with SMTP id f7mr1426063qkk.3.1600890208253;
 Wed, 23 Sep 2020 12:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com> <dad42dce-15d0-245a-4d91-4733e54883a0@gmail.com>
In-Reply-To: <dad42dce-15d0-245a-4d91-4733e54883a0@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Sep 2020 21:43:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ryzmsrHHApT9O=dvsw+=z18Sjd4ygVxvFrrDetKA+rQ@mail.gmail.com>
Message-ID: <CAK8P3a2ryzmsrHHApT9O=dvsw+=z18Sjd4ygVxvFrrDetKA+rQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:W2KZH/f7lez05WWj13E5feQrfDbh6fkDJF0vlt8lZht4NgLOyA0
 Z3jZXxBurib5D93Qv2fogLSqyYlEAOfU5wwbWcms4STgpwIPxwCd701gQ6Xld1Z6zTI0nVK
 3Rui5mraoL4pUNa192amiED+z7nrtv5E5m5s+82Ljui3AmsV9jZq/rX7JdE5NB/SdWCDLta
 SbXfNb0coQ1FOfPs+xZ2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m9qENCfqSE4=:SbDIrGKnZjrts1/pKTFg/q
 qAqybi7zUdZcVvwBe4tYyZL0b7tFE2o9QXYE5pumYOQHRJSsH1K4aSZcwCYuAbHAQfpB9wARi
 jp9P/LkuRSB7G1PMIOhdk6mK3FNIsrk8eKcHBNyld8l42nUt3/4am6dKX3sLpcNZet+ILqENK
 0ke/plmW5ykcKQb/05nSkTxNjmO+w7JAmPf2SKUN+LXBDJom/6FEmnsq0ODv7PhaB3lDoXjCy
 PqsrOt5y/+mtR900kAt4XE5OXkSfn++2jJ66DGVZD9mc8FJQDYyO+W83fchjAKqNUw56ZXZdO
 EPATBICs7fr/GHgPfjSva6uYBjbyi9S3ej8TuKjq5WmAZOcCQvH5d52iB84uqZg44lhGs4qRU
 +1D6d1q7HGXlbnDRsluZIc/sqn91DxtO9nCEsXRt5hNyZjDWWLrwM/cs+pM/mwD0/ifRoi9Y0
 I9U0FBYxDTvCdZXKTkuKzmwZoxcO7+OTP2dmUpeSV3Q6CVrVscZ21JNy/BR8CThj120jCewxN
 ozkua28pqTjTstRmBY33TQnrbGIq6r0R2IfMyZ35fLXqOSHdCcNMWe+B5L0WQTgckEdgtkorB
 q707Mue6HlXbvqOL+1Cfw92ACdAHMvqFBaJcaCfKv7chJnRgPxfDz3vicL4x7q5qgyC+suOB2
 ho219mcNnm0o/B9VRe8Nhi7h0D7/MtUTUh6IxfPIFxmUlIHz3F4D60NOMyV8ikXTET+D77AYn
 xx0WxfBXeexIhCZs7nrO1VmxJ3q30kWtvxJ+o51CMlTgpNPJyavc2/WmoyoggyhQ+9gPhLPXy
 9YN7Wn+j3FtJeyJ+9Z1EwFkwO+uUBkpiG9vyj11fbwd1kXPSWHF7zBagMs7JrortI02gQ7M+1
 3VuBCZILFuixT4vamTadqgNZC2XPr9JopNXUUyIVMBq3E5eHG2HxDypga8XJlsGXXac8Ieop7
 rb1ECDbE9XnuA5mEI9hq8D8B6SgJDp+GlpSLLWdeJjfAcPfC8P1oS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 5:43 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On 9/23/20 5:30 PM, Arnd Bergmann wrote:
> > On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> >>
> >> Hello,
> >>
> >> The Surface System Aggregator Module (we'll refer to it as Surface
> >> Aggregator or SAM below) is an embedded controller (EC) found on various
> >> Microsoft Surface devices. Specifically, all 4th and later generation
> >> Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
> >> exception of the Surface Go series and the Surface Duo. Notably, it
> >> seems like this EC can also be found on the ARM-based Surface Pro X [1].
> >
> > I think this should go to drivers/platform/x86 or drivers/platform/surface/
> > along with other laptop vendor specific code rather than drivers/misc/.
>
> I initially had this under drivers/platform/x86. There are two main
> reasons I changed that: First, I think it's a bit too big for
> platform/x86 given that it basically introduces a new subsystem. At this
> point it's really less of "a couple of odd devices here and there" and
> more of a bus-type thing. Second, with the possibility of future support
> for ARM devices (Pro X, Pro X 2 which is rumored to come out soon), I
> thought that platform/x86 would not be a good fit.

I don't see that as a strong reason against it. As you write yourself, the
driver won't work on the arm machines without major changes anyway,
and even if it does, it fits much better with the rest of it.

If you are worried about the size of the directory,
drivers/platform/x86/surface/
would also work.

> I'd be happy to move this to platform/surface though, if that's
> considered a better fit and you're okay with me adding that. Would make
> sense given that there's already a platform/chrome, which, as far as I
> can tell, also seems to be mainly focused on EC support.

Yes, I think the main question is how much overlap you see functionally
between this driver and the others in drivers/platform/x86.

      Arnd
