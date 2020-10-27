Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218F629BE96
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1813599AbgJ0QwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1813037AbgJ0Qro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:47:44 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A965122258
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603817263;
        bh=14VCZuMIZdKHx03aGNmXB5dNYm5faUHR21s+UNmqFh8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o0znKZzfNARqXqXgudOl2dKYU4+zaQKp7LO7aPAT2kl5pThO7ZAUBZ2vp1j95lPFc
         Tu4tuL1O8y12YI4yyQT7eWSz75QETEQ/5X+Jarrad5ZSy7qJVZH1q7UU5khhskMWu1
         D341/4pAjsSBGhRkR8Fvsg5RPnLEdDxhy63t3Dj4=
Received: by mail-qt1-f175.google.com with SMTP id i7so1476583qti.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:47:43 -0700 (PDT)
X-Gm-Message-State: AOAM531mXTMoialC4CQK34OpZUzoxSga6DEzpOh5tx0TeLg9Gcl4ZEUH
        IKndj4k36WKgYLvFWmOYRIsX0nrUl8EbNH6UTrU=
X-Google-Smtp-Source: ABdhPJzDxfxuqhyC3F1KlAS2KtqALZJShCvFATA4o/kSVnGw7CNfbS7DXVsgAuvYANqZQgGAATCzis/Yz3c7AX45550=
X-Received: by 2002:ac8:7955:: with SMTP id r21mr2948934qtt.204.1603817262708;
 Tue, 27 Oct 2020 09:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201026194110.3817470-1-arnd@kernel.org> <19af29c5-91e7-055f-cffa-0c813ed5233b@ti.com>
In-Reply-To: <19af29c5-91e7-055f-cffa-0c813ed5233b@ti.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Oct 2020 17:47:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Ha+SEmdP9bd-HKN_AwAo9LAfW5LWTkODFOCAUd69QnQ@mail.gmail.com>
Message-ID: <CAK8P3a2Ha+SEmdP9bd-HKN_AwAo9LAfW5LWTkODFOCAUd69QnQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/tilcdc: avoid 'make W=2' build failure
To:     Jyri Sarha <jsarha@ti.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.velikov@collabora.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 4:31 PM Jyri Sarha <jsarha@ti.com> wrote:
> On 26/10/2020 21:41, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The -Wmissing-field-initializer warning when building with W=2
> > turns into an error because tilcdc is built with -Werror:
> >
> > drm/tilcdc/tilcdc_drv.c:431:33: error: missing field 'data' initializer [-Werror,-Wmissing-field-initializers] { "regs", tilcdc_regs_show, 0 },
> > drm/tilcdc/tilcdc_drv.c:432:33: error: missing field 'data' initializer [-Werror,-Wmissing-field-initializers] { "mm",   tilcdc_mm_show,   0 },
> >
> > Add the missing field initializers to address the warning.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Jyri Sarha <jsarha@ti.com>

Thanks

> Please let me know if you want me to merge this.

Yes, it would be good if you can merge it directly.

      Arnd
