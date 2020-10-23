Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C713297315
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbgJWQCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:02:16 -0400
Received: from mail-03.mail-europe.com ([91.134.188.129]:41560 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbgJWQCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:02:15 -0400
Date:   Fri, 23 Oct 2020 16:02:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1603468931;
        bh=nXSAlK8UrJiaG16jQkahBCPbIJiUcfyiYcToFFPWldo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=BBgZ/nUI3NA4LLj0XVLbCr7IXHUAAEOaYtUQsx3SObUMAMzjDcaFOjLDoylEkNySY
         yGNTKAt/5v1X+fK/vqwOfUbpTb7Rne1E5wRgOjBTpC+QG1lnrjy5hhK+4rxwoUq2yf
         5UApw14a10Xa3oU1CScgO47vaZIBAce1EAVaFxaUaRMeuAqaDZhdTqwoAawN7nzsZa
         J5dTaeLaVlr/aLGYBmQ0xq6ns4oLmcPjmVqL+r53i56ke8qJDNe1Mqxk06p87caBHu
         RfLlM9/r/9mVs8WH0I7AU28tmzi44V2pzAoPLUBIKkISzzZTVb38qG6B+CSvnRZzCf
         g5Fm7ZvKyuT5g==
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
Message-ID: <X9esEo-xzBmrNZ9Y-H6RJrhH6Y8UNavk58gdBtmbHKmMLNnVIoCq3g-h8boShQUBWYta6AgzqEc6eNSyXjweZ3F4EVfCtLMa5ySdJmQ60C8=@emersion.fr>
In-Reply-To: <20201023152719.GV6112@intel.com>
References: <47527cdb-2eda-b5a3-d77c-3855b91a0b61@infradead.org> <20201022101423.GI6112@intel.com> <BaLsmzqZNUi-nVbYiLstRgspKGlLahAI8vM2_NPfos2PxM0N9lycj-Zn5TdqNtEHB-jeWgmzw9EHJxq4H5552tVi4bAZXTLnP0y1QsTPFtY=@emersion.fr> <20201023152719.GV6112@intel.com>
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

On Friday, October 23, 2020 5:27 PM, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala=
@linux.intel.com> wrote:

> These are two extreme cases:

Thanks!

> > I'm trying to get
> > a fix for my user-space 1, and I'm wondering if int32_t is enough
> > after dividing by mode->htotal.
> > CC Pekka, just FYI (I think Weston has similar code).
>
> What's with those 1000000LL constants? Are you storing
> clock in Hz units?

We're storing the vertical refresh rate in mHz (milli-Hertz).
