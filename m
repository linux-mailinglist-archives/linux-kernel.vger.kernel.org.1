Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61323285E6E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgJGLrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:47:16 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:60833 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgJGLrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:47:16 -0400
Received: from cust-43cce789 ([IPv6:fc0c:c1a4:736c:9c1a:15d2:fd0f:664c:4844])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id Q7uOk5ghcTHgxQ7uQkFH21; Wed, 07 Oct 2020 13:47:11 +0200
Message-ID: <d1457a75d5f38002c063c3801af7819af43e0bfc.camel@tiscali.nl>
Subject: Re: Build regressions/improvements in v5.9-rc8
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Date:   Wed, 07 Oct 2020 13:47:00 +0200
In-Reply-To: <20201005125840.GP3956970@smile.fi.intel.com>
References: <20201005093024.16032-1-geert@linux-m68k.org>
         <CAMuHMdVqpgro9Qzn39fK9R2-2xDm6LDe6uOB5gSTrdRxbecNXQ@mail.gmail.com>
         <20201005125840.GP3956970@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOuR6v6NuIswQXHhmA+YAjZeFrAMPe063DVSlZBiTS9yWENAJd104lP6d2CFW1a9ygsSvrRmUw2T8fZ/oHZBeQ5yS/z4tmzYca76zUdxQHEcCcZf9qj6
 FCEmpoK6OJNebl2MV7HsbPdcnZ2LuK387kS7lB7nWaV8AtxV8Nc6E0a9+NrMiGzPl1NoBiblZy1rPFXFblYB2ykJGRf8//5KRUaFeY9qcYSN5WAIpMpgc+MQ
 H6C/emLhW92BUr5tYgGql4l1fN+QSjFuISo1exm0jtNuAvkerQuF8xn32yMRVJwqqGlUf7MWFh0S9dRRkUh0FEh6ht1CXMRthN4D7jz/LeHOuqFzAKQFsQTL
 41Cm3o3OzbmwfxDiAuyerR6GLQCKllyXV0APpcd226WzVW3r/q/luVM9ompO3NUJaevRPq4phmYSEwzEh2aEFk28+V86HIPUcYa6R+1Sj8m6CLja1fwlVF49
 U5auCqS1X7gevATUD3w58JtoyJ6SDGXacrjUFGUDo747lnk2iRpsUK3j3gdtUQHLqyBGSD3LPqxZeOo8lmijAmZPu8/lWzetOUskcg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Added Richard and Anton.]

Andy Shevchenko schreef op ma 05-10-2020 om 15:58 [+0300]:
> On Mon, Oct 05, 2020 at 11:35:33AM +0200, Geert Uytterhoeven wrote:
> > On Mon, Oct 5, 2020 at 11:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > JFYI, when comparing v5.9-rc8[1] to v5.9-rc7[3], the summaries are:
> > >   - build errors: +3/-6
> 
> Thanks for the report!
> 
> >   + /kisskb/src/drivers/gpio/gpiolib-cdev.c: error: implicit
> > declaration of function 'in_ia32_syscall'
> > [-Werror=implicit-function-declaration]:  => 430:6
> >   + /kisskb/src/drivers/gpio/gpiolib-cdev.c: error: unknown type name
> > 'compat_u64':  => 432:4
> > 
> > x86_64/um-all{mod,yes}config
> 
> I guess the quick fix is to disable that code for UML, I don't know how IOCTLs
> are working in UML in cases when host - guest - guest app either from:
> 	1. x86_64 - x86_64 - i386;
> 	2. x86_64 - i386 - i386.

I ran into this build error too.

Perhaps the UML maintainers have an idea what to do here. The commit that
triggers this error is 5ad284ab3a01 ("gpiolib: Fix line event handling in
syscall compatible mode").

Thanks,


Paul Bolle

