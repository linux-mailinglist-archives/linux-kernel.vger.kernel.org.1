Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A912E2599
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 10:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgLXJLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 04:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgLXJLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 04:11:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BB2622AED
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608801020;
        bh=63+I1n7P2+fwGQMxQ78cvsnd8t/gOAPTMjO443V0JbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hn/+YBu+kEKl+OFVifYYDuOofhEHArrDsrXNrnsAN2fRYWdWkO7lINil/p+pLTyn5
         wQXKUlq2PZgBRa5t9QxeimeT9YO0BumNe4Ldew358gdUkUL5JDTTJVQQE5U0l48Gla
         4GcePqaInVqKTxSbnm1tJ/BS+Lu2/JG9oUDVgao4wnvOYt9NSbDYMgNItxvSO6dRID
         zNYO8/98k/R72XWCIYH3WgUG3ePXIF3t0hNxcE2EDfe4FztV5ce7If07aBdeevlBIg
         MpZ1zo5jtx1j+qq90azZLY0fJX+8lnSLtOdeYGPKiU7wS1aDKOz5/oPFzbyuCmfzFU
         /g8vkY0JAgcYA==
Received: by mail-ot1-f51.google.com with SMTP id w3so1327950otp.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 01:10:20 -0800 (PST)
X-Gm-Message-State: AOAM530hJjKnznqJYo39K/4b6sXOgYl9YtLB6t98SyiqxhYLIwivSwgZ
        F4LyuVi6Fbu5EivXD4wpl29pIMJONMoIsb84Lk0=
X-Google-Smtp-Source: ABdhPJwHH/1y2taLUsDtmoQDK9BMxU1OSPObMJc6M9yMxThkFPfBn/gOIWG5xK6a2cvHg6AdPQzrjqm4xC5Y5+rh54E=
X-Received: by 2002:a05:6830:1c24:: with SMTP id f4mr21556996ote.108.1608801019348;
 Thu, 24 Dec 2020 01:10:19 -0800 (PST)
MIME-Version: 1.0
References: <202012180909.WhlTpWrS-lkp@intel.com> <20201223183606.GB29011@zn.tnic>
 <CAKwvOdkA+7AYGhPk_=FA6OPxeb9Wy7FA0_5-0KCJGr-wtn_nxw@mail.gmail.com>
 <20201223210405.GB28724@zn.tnic> <CAMj1kXG58+DdfA9RDE9gnELf8ZT0dTX+g8D+3W0pVM8RUSF_OQ@mail.gmail.com>
 <20201224085533.GA5108@zn.tnic>
In-Reply-To: <20201224085533.GA5108@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 24 Dec 2020 10:10:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFT5R11ev3GqzwLAQ8q-f2EkS0Qq2evPvdjC_XK_FX_0g@mail.gmail.com>
Message-ID: <CAMj1kXFT5R11ev3GqzwLAQ8q-f2EkS0Qq2evPvdjC_XK_FX_0g@mail.gmail.com>
Subject: Re: [tip:efi/core 3/7] /tmp/slab-258052.s:9870: Error: unrecognized
 opcode `zext.b a2,a2'
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Dec 2020 at 09:55, Borislav Petkov <bp@alien8.de> wrote:
>
> Hi Ard,
>
> On Wed, Dec 23, 2020 at 11:43:45PM +0100, Ard Biesheuvel wrote:
> > I hope this report is not holding up the PR for efi/core?
>
> I was just looking at that yesterday...
>
> But nah, lemme send it.
>

Cheers,
