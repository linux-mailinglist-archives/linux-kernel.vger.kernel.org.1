Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420502EEBDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 04:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhAHDa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 22:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbhAHDa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 22:30:58 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CD3C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 19:30:12 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 4so4960280plk.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 19:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMhXAV38uws0Ksy5eFTBEtLZPPxlU+gVbo6AAxo9H64=;
        b=KLJgXlwfMJjBfzdSjGYTPhHPsAqpuShISXI+md2pS24yEXts3Xsoyt7jDloPiy2ToY
         L+In4ZjdKq0MzoUB+FHuzWNH3JOzmDAyda2LsOA1plUBqKswktdEKZsmOj2OCMavBsuU
         QFxc5kyCJzqLGG4nwZKgnq2Foi9eyv3mynfWMBd1kf4/vDoqenrDe0LBKEHLY0nw/Oyd
         xT7CjPx+jb6LL0q9Tp9uV4WN/HggllSPSNNUolnn6WEpkCrhyRuD584cwU9pX2ol/nkx
         oodvLacjwvr5y2Z6nr8hUd/Que/FOMbeNl3RGpjzF5MS9o6FCYYDU8GTVT9y+ZsKhwMk
         fljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMhXAV38uws0Ksy5eFTBEtLZPPxlU+gVbo6AAxo9H64=;
        b=CPw4srP+iLKDUUSVghhZTgrOuIYt2rtltTLbgOCVOPWrr6SpKbCDQyYPVCV+k9NJ8h
         wmCeEXS5+HlpjGLlGMhqIbI3qYgId/ATv+6kdnKmKWbx5iMhX+/B9QtJye5XOfSw4/lg
         0dMLkxx2ypu3Jc5v/lVKolbqO5SRg5mNtWTZFyeS4zzAulQC6rrDIL1DPWx/XGWH5bZd
         SeJgAewyUw7ND+zFR6V6ymdG8HMLfdyuQawHyqtZKPI94POlKntCcJGza6h2WlJmKp6D
         rLxQiubBMyK7QblJAkbC2vWyGiOp7/2DHbAdO1By4Pjwggx0sdafxh5e4qVwClQuDHvd
         ddWA==
X-Gm-Message-State: AOAM531rBEf5yun8WznM04xVMSx2icY/94fvN6vGmmrE9WATipuYCzMG
        jTLG7CA1vxTnpZNjWhDz+QH8vWaNPGJEvidDETnYyA==
X-Google-Smtp-Source: ABdhPJx61kmnqYZNLacqSbd8guWpR5oS2tLYpoagBmZ9x0mVfpQqFrbKtiaI9DNbP+oxyiVvhMWfuWpcdUHWyUoSUHY=
X-Received: by 2002:a17:90a:fa8e:: with SMTP id cu14mr1647501pjb.140.1610076611419;
 Thu, 07 Jan 2021 19:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20210107090625.107078-1-chiu@endlessos.org> <20210107090625.107078-2-chiu@endlessos.org>
 <20210107142746.GC4726@sirena.org.uk>
In-Reply-To: <20210107142746.GC4726@sirena.org.uk>
From:   Chris Chiu <chiu@endlessos.org>
Date:   Fri, 8 Jan 2021 11:30:00 +0800
Message-ID: <CAB4CAwfyE_tXHENi5bbekFGFutU3Cxgr2SgKyUQbRnS4RtwuYQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
To:     Mark Brown <broonie@kernel.org>
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 10:28 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jan 07, 2021 at 05:06:22PM +0800, Chris Chiu wrote:
>
> > +static const struct acpi_gpio_mapping *cht_rt5645_gpios;
> > +
>
> You're adding a read only static variable with no way to set it.  This
> doesn't actually do anything?
>
This is a pointer to a 'const 'struct acpi_gpio_mapping', and I will
need it to point to
the 'static const struct acpi_gpio_mapping cht_rt5645_ef20_gpios[]' in
my consequent
patch '[PATCH 2/4] ASoC: rt5645: Add ACPI-defined GPIO for ECS EF20 series'.

I take the same idea from 'sound/soc/intel/boards/bytcr_rt5651.c' line 90.
And it did work as expected on my ECS EF20EA

> > @@ -3780,7 +3782,6 @@ static const struct dmi_system_id dmi_platform_data[] = {
> >               },
> >               .driver_data = (void *)&intel_braswell_platform_data,
> >       },
> > -     { }
> >  };
> >
>
> This is an unrelated change which removes the terminator on the array
> which will cause issues.

Thanks for pointing that out. It's not my intention. I accidentally
removed it. I'll fix this in v3.

Chris
