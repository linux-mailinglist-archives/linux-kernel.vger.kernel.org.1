Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1B2B2F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 19:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKNSKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 13:10:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgKNSKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 13:10:39 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7080322254
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 18:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605377438;
        bh=ZDrQLEumRQ6/dFP3xDX7Z8rbD7Ex+3bsC5YXpCS0VYc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UOPBBhMjdH+75kqIMR4ktSKjg2whxH3W12HjiRP/b1v1dXkxJ4+DoPWw4M2reJ+dx
         b4VVKfhdo1/DDwsOdTG03bywaUhMeR0i7rBYll/tBnC60gCTXUBDpnPP/4x+3DGR1i
         aWMWsQ97kN8jgXsQA9eCEi0+53aEZKisHuPvJ+wI=
Received: by mail-wm1-f54.google.com with SMTP id 10so19587881wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 10:10:38 -0800 (PST)
X-Gm-Message-State: AOAM532LCyTXpM4iof4kB5mTKiG7sbdptb/mms25c2XNON0SJS1QvdR1
        anX2jNO4t4VybFeC2e1RJWUxC7JSn/iQ4v6jZa3h3w==
X-Google-Smtp-Source: ABdhPJyHwb9cQ3vrD0Y0Pm5DOTRUzOzODmciznL6Y/6GnCswGjzs3kCa7/uP8Opnhi8cTe0bKQwP++ea6JJVd9xtFo4=
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr7678958wmc.176.1605377437060;
 Sat, 14 Nov 2020 10:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble> <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble> <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net> <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net> <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com> <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
 <7afed057-111a-9a21-c114-44987184b683@suse.com>
In-Reply-To: <7afed057-111a-9a21-c114-44987184b683@suse.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 14 Nov 2020 10:10:23 -0800
X-Gmail-Original-Message-ID: <CALCETrVFVif6gsdopXZeP=-4Vi=KtVX0b8Qanah=b+05302Y9w@mail.gmail.com>
Message-ID: <CALCETrVFVif6gsdopXZeP=-4Vi=KtVX0b8Qanah=b+05302Y9w@mail.gmail.com>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 1:16 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wro=
te:
>
> On 13.11.20 18:34, Andy Lutomirski wrote:
> > On Wed, Nov 11, 2020 at 12:25 PM Andrew Cooper
> > <andrew.cooper3@citrix.com> wrote:
> >
> > So I think there is at most one of these that wants anything more
> > complicated than a plain ALTERNATIVE.  Any volunteers to make it so?
> > Juergen, if you do all of them except USERGS_SYSRET64, I hereby
> > volunteer to do that one.
>
> Why is a plain alternative (either swapgs; sysretq or a jmp xen_sysret64
> depending on X86_FEATURE_XENPV) no option?
>
> Its not as if this code would run before alternative patching.

ALTERNATIVE would "work" in the sense that it would function and be
just about as nonsensical as the current code.  Fundamentally, Xen
PV's sysret feature is not a drop-in replacement for SYSRET64, and
pretending that it is seems unlikely to work well.  I suspect that the
current code is some combination of exceedingly slow, non-functional,
and incorrect in subtle ways.

We should just have a separate Xen PV exit path the same way we have a
separate entry path in recent kernels.  *This* is what I'm
volunteering to do.

--Andy
