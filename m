Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F8A26BFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIPI7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgIPI7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:59:14 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE53C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:59:14 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id o20so1470070ook.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uStEpmfYMuBQTe8ptduZVCplRWwuY/KSnqm4IT/S5I=;
        b=KthdyxgmEkt4PmAu2ol78sKu7ekjUiu3fmyNE7aYKiXcYmsaNIoywpePwkPcDn8Uqn
         V1VfdYVBvX1sB8sv8PnmjFdmDTnsVCnlWzT5VjsMpcn8Da7Q1zJ+h/oVuuVElwK+UPgR
         WfpkyqK2iMRnUxH4xUYOlbxH2K9ahdc0R6vK3TNrsGxepiEDbWW/Dzq+LKZjEmBMm6vs
         qmdICE8/goJiM+oePhsC/9bL7tuBDGvWfx2YlJygOCTD5GNAyd+xF+/aGNDJQLwOwnt3
         OHClqPlaq3V61dCByBJV0NBynLM8vIvZOqiAv6J2j7PBENHmX6ObML9nnyUQVIX98YGA
         O8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uStEpmfYMuBQTe8ptduZVCplRWwuY/KSnqm4IT/S5I=;
        b=itCOSCNIGbEVMzB0rU/t95cgccmwnRsmGeSxhRuf7fwN7564vfSrwGdGGDTIhbxxq3
         FMd/wobwxmJkt86VLlfza6/mY7gmGdbRI4iZm0sLv5FN7vCMzVx92+mFNVxYow7DoRSv
         Uc1IW3CuO/Qze6OyEAkIR3ORe/Nj6n49bWd7RXnB5wZwzfbZ5SOBNGBEmuLnvPjFdCZh
         TlGfnv4gYB/bs9USp5qf6YvUvq5Fb8MU3bWuhLQPcPJl5ifzV6FNoprYAYr2R4rq7mFF
         DPFCUwWhc7O1N7hs+5wWr8eAo34jSA4yEce7j5hN8/Hklqd+zOmzN9LaJEmY6z2BTH9L
         1xzg==
X-Gm-Message-State: AOAM532lU6OUlYP+tIHnbxWb0NW8LkDS8Tzj9aWshAcgp2LZ45t51nrT
        zu02XZNhoo/sKU0eMVoWsm2Ii1j5+ZvMiDqhYG2h8Q==
X-Google-Smtp-Source: ABdhPJzZjRD5Qx3ns9zOx9NS0tnRyvKHaRuDbIo9I4oPrbbvgQRSXh1Cwpj2YR6tw6BOdOaBeAJHrODbQONiPN9jQCU=
X-Received: by 2002:a4a:a58f:: with SMTP id d15mr16956575oom.36.1600246753334;
 Wed, 16 Sep 2020 01:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <20200915204912.GA14436@zn.tnic> <20200915210231.ysaibtkeibdm4zps@treble> <CAKwvOdmptEpi8fiOyWUo=AiZJiX+Z+VHJOM2buLPrWsMTwLnyw@mail.gmail.com>
In-Reply-To: <CAKwvOdmptEpi8fiOyWUo=AiZJiX+Z+VHJOM2buLPrWsMTwLnyw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Sep 2020 10:59:01 +0200
Message-ID: <CANpmjNPa8FuTURfO0btWir4ax7jBy79P5x7Z5h08e-Ybea1Fnw@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 at 00:34, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Tue, Sep 15, 2020 at 2:02 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > panic() is noreturn, so the compiler is enforcing the fact that it
> > doesn't return, by trapping if it does return.
> >
> > I seem to remember that's caused by CONFIG_UBSAN_TRAP.
>
> Indeed, if I remove CONFIG_UBSAN_TRAP from the 0day report's
> randconfig, these unreachable instruction warnings all go away.
>
> So what's the right way to fix this?
>
> CONFIG_UBSAN_TRAP enables -fsanitize-undefined-trap-on-error  (not
> sure why that's wrapped in cc-option; it shouldn't be selectable via
> Kconfig if unsupported by the toolchain).
>
> Should clang not be emitting `ud2` trapping instructions for this flag
> for no-return functions?

I think this would defeat the purpose of this UBSAN feature. Certain
UBSAN checks are done fully statically, like is done by
fsanitize=unreachable, and could actually be enabled in production
kernels; trapping the kernel in these cases would be a reasonable way
to avoid further damage to the system.

(You could in theory force it to not emit a trap by using
fno-sanitize-trap=unreachable, but I think it's a bad idea.)

> or
>
> Should objtool be made aware of the config option and then not check
> traps after no-returns?

I'd vote for this. And it seems Ilie implemented this already.

> I suspect the latter, but I'm not sure how feasible it is to
> implement.  Josh, Marco, do you have thoughts on the above?

Thanks,
-- Marco
