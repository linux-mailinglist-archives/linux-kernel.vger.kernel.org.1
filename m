Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B160B2FF453
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbhAUT0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbhAUTZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:25:28 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB554C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 11:24:47 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 30so1997843pgr.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 11:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gqSp7OcRr/ed55qU/19Bnmbh+jsqIQNuD5w35l1bQs=;
        b=V0LztueDbN4iG0gjmN25TNfzITrA3aCeZH/L7I6Ksa+5VCc63DQfSQZ7OBLMBjRHg2
         7eYdFa5BCmIwSTuLdq5y29eDGRwl3SpKtc58yMRonCi/CYQTOSyn3/ld3rO/ABzn3Hyu
         u577D/KK23BerSVmTUda1Hhzq1mkd2vnS/1W3t8TlfcM5xx+JSuYo5Sr7IAAj+bCxT+B
         voc7iIzKjE+UM2ntT40FwdJ1WxdpXX1F9bzClRmVTkwRNB+S7CIC9slJxJbYyIBykUCj
         LNO1hBC7rfgLEwTWC868gS/Kj64358n9mTFfLHlA0cTVYpfpTDZSyfKCDHPxXGipSSeh
         c01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gqSp7OcRr/ed55qU/19Bnmbh+jsqIQNuD5w35l1bQs=;
        b=Uhe6p6j5MX9q2zEY0gUtjPC/JWDsK8dIfUCPUGgCZbbhSZY9devtZ+riRlmuDLytz3
         exKrCMysEgupQBqE3+SlSlPWwOFcu6ArGtsShVv4bbHbKJGi8NCnV0TkQi44mJLZfZjx
         ecUpWv7nHmDmHtVgRzmPL6chhC5caYuhpNRcUYf205VUHed13GlB4dBrOHcVgFiNGqn5
         yoartoTA3E42JIWhKvHFv/0/O8LAKoNd+hh5Crz7vDOQBoDOCx3X6wTzT8fUurcACeQD
         Cq65aSI5zaOU+nAjTIEyFs/eGs2Pd7ScKWYlq58nhBotFnhPb22Y78Jp2Erf6WJ9A7OR
         4DBA==
X-Gm-Message-State: AOAM533PhTKHIO0L2kN9lIpbfzGK2vp7pUIKDHT8AQjMSJoVCGhKuMEM
        MGfviMrtfFsggNX4LYakIKC0SFEg+uHoAUMb97xR1A==
X-Google-Smtp-Source: ABdhPJyRkjYcnaiD6RGS63GWq9+T6pTjXHEcp654EFy2JWq7JLVbynLjUukaZB9crrdy/DhTTewtfYeve07hc7LLaeU=
X-Received: by 2002:a62:7896:0:b029:1b6:7319:52a7 with SMTP id
 t144-20020a6278960000b02901b6731952a7mr1026808pfc.30.1611257087169; Thu, 21
 Jan 2021 11:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20210120173612.20913-1-will@kernel.org> <20210120173612.20913-9-will@kernel.org>
 <CAKwvOd=B+tMi7-82Q8hEYnQ+BzkLDygOhMh6cQ2L+3SaL+F4tQ@mail.gmail.com>
 <CAHk-=wiOecmzTXoc6hbTmYdBCyhkmOpAHeMVXmJ_DEGgjPfZ5Q@mail.gmail.com> <20210121131101.GD22123@willie-the-truck>
In-Reply-To: <20210121131101.GD22123@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Jan 2021 11:24:36 -0800
Message-ID: <CAKwvOdnmHH+sCqzdaAt_LYms_KULx5VpzmQZjSOy_Qyj0+hbgQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] mm: Mark anonymous struct field of 'struct
 vm_fault' as 'const'
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 5:11 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Jan 20, 2021 at 11:02:06AM -0800, Linus Torvalds wrote:
> > On Wed, Jan 20, 2021 at 10:27 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > Is there a difference between: [ const unnamed struct and individual const members ]
> >
> > Semantically? No.
> >
> > Syntactically the "group the const members together" is a lot cleaner,
> > imho. Not just from a "just a single const" standpoint, but from a
> > "code as documentation" standpoint.
> >
> > But I guess to avoid the clang issue, we could do the "mark individual
> > fields" thing.
>
> I'd prefer to wait until the bug against LLVM has been resolved before we
> try to work around anything. Although I couldn't find any other examples
> like this in the kernel, requiring all of the member fields to be marked as
> 'const' still feels pretty fragile to me; it's only a matter of time before
> new non-const fields get added, at which point the temptation for developers
> to remove 'const' from other fields when it gets in the way is pretty high.

What's to stop a new non-const field from getting added outside the
const qualified anonymous struct?
What's to stop someone from removing const from the anonymous struct?
What's to stop a number of callers from manipulating the structure
temporarily before restoring it when returning by casting away the
const?

Code review.

Using a non-toolchain-portable solution certainly could be considered
more fragile.

It's always possible that the resolution is the C standards body goes
the C++ route, at which point GCC would be forced to address this and
potentially change behavior.  Kind of like how people avoid going to
court since things are never guaranteed to work out in their favor.

>
> None of this is bullet-proof, of course, but if clang ends up emitting a
> warning (even if it's gated behind an option) then I think we're in a good
> place.
>
> > (It turns out that sparse gets this wrong too, so it's not just clang).
>
> Adding Luc, as hopefully that's fixable.
>
> Will



--
Thanks,
~Nick Desaulniers
