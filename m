Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F017C22D417
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 05:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgGYDEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 23:04:01 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:11830 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:04:01 -0400
Date:   Sat, 25 Jul 2020 03:03:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1595646237;
        bh=VJe3Huszu4b40ueORs4rAhjQ2OOkJfwTddBXPKHHSRk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=o+agpC85tmfB27Cm6+UmoM76q10l2qgG2bir5AuK1CeJ143FzcpDnCfA8xXKp+EwV
         FoqWa8ez02dj9c7ha5lhsP+MBfUO4SRqph8l//tjNZbdSZ1yxC2zP1b6l3osDI0fZ9
         rMoQfvdvdIX6m3SUDBd+N9QMkukC3pL9+oLwFnR4=
To:     Paul Menzel <pmenzel@molgen.mpg.de>
From:   Mazin Rezk <mnrzk@protonmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sunpeng.li@amd.com, Alexander Deucher <Alexander.Deucher@amd.com>,
        1i5t5.duncan@cox.net, mphantomx@yahoo.com.br,
        regressions@leemhuis.info, anthony.ruhier@gmail.com
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
Message-ID: <_vGVoFJcOuoIAvGYtkyemUvqEFeZ-AdO4Jk8wsyVv3MwO-6NEVtULxnZzuBJNeHNkCsQ5Kxn5TPQ_VJ6qyj9wXXXX8v-hc3HptnCAu0UYsk=@protonmail.com>
In-Reply-To: <3c92db94-3b62-a70b-8ace-f5e34e8f268f@molgen.mpg.de>
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com> <202007231524.A24720C@keescook> <a86cba0b-4513-e7c3-ae75-bb331433f664@molgen.mpg.de> <202007241016.922B094AAA@keescook> <3c92db94-3b62-a70b-8ace-f5e34e8f268f@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_REPLYTO
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 24, 2020 5:19 PM, Paul Menzel <pmenzel@molgen.mpg.de> wrote=
:

> Dear Kees,
>
> Am 24.07.20 um 19:33 schrieb Kees Cook:
>
> > On Fri, Jul 24, 2020 at 09:45:18AM +0200, Paul Menzel wrote:
> >
> > > Am 24.07.20 um 00:32 schrieb Kees Cook:
> > >
> > > > On Thu, Jul 23, 2020 at 09:10:15PM +0000, Mazin Rezk wrote:
> > > > As Linux 5.8-rc7 is going to be released this Sunday, I wonder, if =
commit
> > > > 3202fa62f ("slub: relocate freelist pointer to middle of object") s=
hould be
> > > > reverted for now to fix the regression for the users according to L=
inux=E2=80=99 no
> > > > regression policy. Once the AMDGPU/DRM driver issue is fixed, it ca=
n be
> > > > reapplied. I know it=E2=80=99s not optimal, but as some testing is =
going to be
> > > > involved for the fix, I=E2=80=99d argue it=E2=80=99s the best optio=
n for the users.
> >
> > Well, the SLUB defense was already released in v5.7, so I'm not sure it
> > really helps for amdgpu_dm users seeing it there too.
>
> In my opinion, it would help, as the stable release could pick up the
> revert, ones it=E2=80=99s in Linus=E2=80=99 master branch.
>
> > There was a fix to disable the async path for this driver that worked
> > around the bug too, yes? That seems like a safer and more focused
> > change that doesn't revert the SLUB defense for all users, and would
> > actually provide a complete, I think, workaround whereas reverting
> > the SLUB change means the race still exists. For example, it would be
> > hit with slab poisoning, etc.
>
> I do not know. If there is such a fix, that would be great. But if you
> do not know, how should a normal user? ;-)
>
> Kind regards,
>
> Paul
>
> Kind regards,
>
> Paul

If we're talking about workarounds now, I suggest simply swapping the base
and context variables in struct dm_atomic_state. By that way, we won't need
to change non-amdgpu parts of the code (e.g. by reverting the SLUB patch).

Prior to 3202fa62f, the freelist pointer was stored in dm_state->base which
was never dereferenced and therefore caused no noticeable issue. After
3202fa62f, the freelist pointer is stored in the middle of the struct (i.e.
dm_state->context).

Swapping the position of the base and context variables in dm_atomic_state
should, in theory, revert this code back to it's pre-5.7 state since the
code would be back to overwriting base instead.

If we decide to use this workaround, I can write the patch and do more
extended tests to confirm it works around the issues.

That said, I haven't seen the async disabling patch. If you could link to
it, I'd be glad to test it out and perhaps we can use that instead.

Thanks,
Mazin Rezk

