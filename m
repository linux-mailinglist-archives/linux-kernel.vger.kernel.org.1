Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03706297211
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465638AbgJWPOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:14:33 -0400
Received: from mail-03.mail-europe.com ([91.134.188.129]:40414 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461690AbgJWPOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:14:33 -0400
Date:   Fri, 23 Oct 2020 15:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1603466069;
        bh=fpfmanFgqlU/lzWtOZ6sJt9HDyNApPI+OcMiQ1jU2Q8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=kIDxE14QEkaab3DTVkhGSAm0Ss7xK3j7CsyJ5mOtzoqIfPmmgCVWRXnbm297kmrD/
         CjHX777iIfuy6oMkDbm+0N6W9LN9V/fN44t4vjKaXngxyNZUeMmMgkjEq+r3LsT4+K
         bD3IR6FMLBYLV3rk7NKQ1IV9p+OxJYhiWmWXTSqwJlCavw9Kctkxy4+VE9zYCmQ4h0
         bHaPNdqcAQR5/hqMcYr5N0CcB5k22sLWqvDqdKFIa4xdF3AnRlKIi8AUkFM83RPo6i
         UYzNlD5ezvMF79e099tP36ZH4tm8xIkRSVXtj1JGc+S7QBtMyoJh8Z7q1iwzLr9ki1
         VOeAxdvce0hSA==
To:     =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pekka Paalanen <ppaalanen@gmail.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [Intel-gfx] drm_modes: signed integer overflow
Message-ID: <BaLsmzqZNUi-nVbYiLstRgspKGlLahAI8vM2_NPfos2PxM0N9lycj-Zn5TdqNtEHB-jeWgmzw9EHJxq4H5552tVi4bAZXTLnP0y1QsTPFtY=@emersion.fr>
In-Reply-To: <20201022101423.GI6112@intel.com>
References: <47527cdb-2eda-b5a3-d77c-3855b91a0b61@infradead.org> <20201022101423.GI6112@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 22, 2020 12:14 PM, Ville Syrj=C3=A4l=C3=A4 <ville.syrj=
ala@linux.intel.com> wrote:

> On Wed, Oct 21, 2020 at 08:13:43PM -0700, Randy Dunlap wrote:
>
> > Hi,
> > With linux-next 20201021, when booting up, I am seeing this:
> > [ 0.560896] UBSAN: signed-integer-overflow in ../drivers/gpu/drm/drm_mo=
des.c:765:20
> > [ 0.560903] 2376000 * 1000 cannot be represented in type 'int'
>
> Dang. Didn't realize these new crazy >8k modes have dotclocks reaching
> almost 6 GHz, which would overflow even u32. I guess we'll switch to
> 64bit maths. Now I wonder how many other places can hit this overflow
> in practice...

Can you provide an example of a full crazy >8k mode? I'm trying to get
a fix for my user-space [1], and I'm wondering if int32_t is enough
after dividing by mode->htotal.

CC Pekka, just FYI (I think Weston has similar code).

[1]: https://github.com/swaywm/wlroots/pull/2450
