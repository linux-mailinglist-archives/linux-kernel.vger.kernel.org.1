Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7892C60C3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgK0IRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:17:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgK0IRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:17:49 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581BF206DF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606465067;
        bh=gVhdT7L8jyaPmBQJA5OpnfIFDlekKo+tt2MdwFpRcOs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vhppVeU5XkVaVDEv8C+YHueKyKZeil+3yQvbMKA0Acx/4cO6y2+bqR/OYL54fuott
         uBWOpI+8TdOUCK4erMR7IdIraJvr5S3bHwAcvulEFY/TLfLBv6TfchpYynTX1VeaFq
         tJ8josH+RqVTa2c1cFrGrY95WtO5iS8pZASwIg40=
Received: by mail-ej1-f45.google.com with SMTP id mc24so6375618ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:17:47 -0800 (PST)
X-Gm-Message-State: AOAM531MO6qPvrT6+kV3zCH3GliN21xw6du2k/FGwpsPYgZf5VO+osok
        3bh2pWBXZp9a0JQAe0QnYT0d3e6/hXTWTGaeTjs=
X-Google-Smtp-Source: ABdhPJwnQfGBTm2Eidts5aIMkq0FGoJHSaovgUvw4D1gYt46GNIsKJKzYS02XPHcPaQkurrSitgVIkE1JEr29/HzuMA=
X-Received: by 2002:a17:906:bd2:: with SMTP id y18mr6384882ejg.503.1606465065780;
 Fri, 27 Nov 2020 00:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20201120162133.472938-1-krzk@kernel.org> <20201127080619.GJ2455276@dell>
In-Reply-To: <20201127080619.GJ2455276@dell>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 27 Nov 2020 09:17:33 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfdEbax7Z4xpu2QcLSND6fvWK__5hTKOESaO0n2pBMhtA@mail.gmail.com>
Message-ID: <CAJKOXPfdEbax7Z4xpu2QcLSND6fvWK__5hTKOESaO0n2pBMhtA@mail.gmail.com>
Subject: Re: [PATCH 01/16] mfd: bcm590xx: drop of_match_ptr from of_device_id table
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020 at 09:06, Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 20 Nov 2020, Krzysztof Kozlowski wrote:
>
> > The driver can match only via the DT table so the table should be alway=
s
> > used and the of_match_ptr does not have any sense (this also allows ACP=
I
> > matching via PRP0001, even though it is not relevant here).  This fixes
> > compile warning (!CONFIG_OF on x86_64):
> >
> >   drivers/mfd/bcm590xx.c:95:34: warning: =E2=80=98bcm590xx_of_match=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/mfd/bcm590xx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Couple of small points:
>
> - Patch-sets, particularly large ones should have a cover letter.
> - Subject lines follow English grammar conventions and should start
>   with an uppercase character.

Thanks for fixing this. I am not a native English speaker and I make
mistakes. Either it is a grammar or convention mistake, I would
appreciate it if you point them out, so I could learn from them.
About the "start with an uppercase character", I actually on purpose
changed my approach some time ago after seeing more senior kernel
developers using this method (see commits from Linus Torvalds, Andrew
Morton). After the subsystem prefix "mfd: ...." they start with
lowercase. If you still insist that commit titles in MFD subsystem
should use capital letter after the prefix, I will try to remember and
follow this approach when sending patches to you.

Best regards,
Krzysztof
