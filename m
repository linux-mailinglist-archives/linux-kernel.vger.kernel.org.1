Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1798302564
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbhAYNPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbhAYNKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:10:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C57AD22D58
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611580174;
        bh=y5SD7INd+SJt7jxXfJP2LnyGCDy2q11vfjo9M/wnIVg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CzHvKf0g4XRU3kZT+EAi1uu/b8urWuaKUoh7B2C4vgC224fDtXQv2oHgNFop9yhZT
         2NAVkLC7L51W5AAHJatCrAxQaZGGe8ikLSGTJyflMWj71WwoMujeWrPVS93iC1TKwI
         x8IXnE2nOh3LtWah61deyMxC6o408RKhwybxqQHAd+opNvhFi5a0T4aRl8m1xi1DH6
         wsKNG/eN4JKz1Sz+I59YIY7HdRNsZBImAyvqYbJLknXsqtZGg59Fa+dNZ2fW1Tb9ok
         XisCQGg02FTISRO4Tr0H83Lqk2GgUor15GeedhP0qyrOoICJ9TKfPHZdLC53amcu9N
         55hpWqNriPU0w==
Received: by mail-ot1-f54.google.com with SMTP id n42so12636372ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:09:34 -0800 (PST)
X-Gm-Message-State: AOAM530XS4hwyNg/o6+cF/VoRROGw/MUVbAsOpgU6+0wovgKBHFWkWh2
        LiyNXZFbJFJk6dtPXsCntUrC9/71hFxOdKQ42Bc=
X-Google-Smtp-Source: ABdhPJyuJJk9G4dOr5X/W/Oejpn00xm3L5Vgy94ryIckeQco5eZlFX7WU57R1TChXjR/NR+IHQywGOH1ZsrZxjRin3w=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr388999otk.210.1611580174003;
 Mon, 25 Jan 2021 05:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20210125122650.4178417-1-arnd@kernel.org> <161157800073.27462.7610644354455990065@build.alporthouse.com>
In-Reply-To: <161157800073.27462.7610644354455990065@build.alporthouse.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 25 Jan 2021 14:09:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2nWZnHfxqsKpq4iA1yYkJcVw01OewsZ9WSKUczoUR0+g@mail.gmail.com>
Message-ID: <CAK8P3a2nWZnHfxqsKpq4iA1yYkJcVw01OewsZ9WSKUczoUR0+g@mail.gmail.com>
Subject: Re: [PATCH] i915: Fix DRM_I915_WERROR dependencies
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 1:33 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Arnd Bergmann (2021-01-25 12:26:44)
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > CONFIG_DRM_I915_DEBUG now selects CONFIG_DRM_I915_WERROR, but fails
> > to honor its dependencies:
> >
> > WARNING: unmet direct dependencies detected for DRM_I915_WERROR
> >   Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=m] && EXPERT [=y] && !COMPILE_TEST [=y]
> >   Selected by [m]:
> >   - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && EXPERT [=y] && DRM_I915 [=m]
>
> DRM_I915_DEBUG now depends on !COMPILE_TEST and EXPERT.

Works for me, thanks!

      Arnd
