Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E6300E60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbhAVU55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbhAVU4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:56:10 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5BDC06178B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:55:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id a20so1625222pjs.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGuXgzHMRCNvdzQSVYVqEK+DngVryvb3NdDIdnd4v54=;
        b=Nri5eoATvjJNwAyG8UjhgOoqcWybOvwpVkxZIDxYxbLm19l6/A45ZvZBCeAmfRMRe5
         Q3wurcY3Q7gVpRo7zmX82ZGUWZ7N8ubR03O+JRquWGBvaYnQwn8l/Zw1Y0aVxFi9bTZz
         Ra7aA/A6tBLrfibbMfnc8rTfZianzXGXnbroXjsGkHTtkig4uO5rMYvhQ1AEtZ43oCP3
         rc3vPK7wPC0sRYR0YExu721bhQ+nKbpQnJQ4nnrULWf9h+Jdm1r8rkF2ZxqtUNy2flVP
         xJ1y+1bk2lBL0GRsma6VEGpk/itLZZ4+oUzOGiCcFxdTjpqyA0r9vsc752lx9k69zsfO
         Hycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGuXgzHMRCNvdzQSVYVqEK+DngVryvb3NdDIdnd4v54=;
        b=Xm9Yw2sgQDHPMZ0cmutqdq3wZhOAyxWHhkTKrFQw8HDYJMydfRAkJH0tb5jy31b+qC
         GzZf3NsysWndjCiX68OitVPf3wlBFkd0eSwFu4u4Q2xngZPTUVXPDScMMfZ5/35MRmVn
         eHksTznsWdbojWpwMVe9UIeRHoKR440Em7Df3UorpLZ7H2exs9TaSwKif+aMXI2UD+Uf
         dTJDGKsaFJj2yL2g8i6kU95lBJnr3zZP2A27omQKPkDUVFP+q9Gt8TepZwyB57tcTdaB
         TzH4lBOYsBW5jb5ftn3ChORzQ68UlW3DPv2ivWf/ejmkxBRyeyeKAgja2bTYPKAaz5qv
         6mBw==
X-Gm-Message-State: AOAM533VcgFnv/XPNuO4z/74WWxc0q1sNoJIbGOSZF+a04UErlNVUJ3A
        yQs5WBuJxvGFRsH4ooHDy/yummCLPyRv84e16cI=
X-Google-Smtp-Source: ABdhPJxinfDMfQfRg4whIGFJPRTRbEfyBEJF9BZDQRn0e5jWUpYKT3Rs1OxK7uERw0pWJjgj+wkI3TYPXVUAol/zlio=
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id
 w22-20020a1709027b96b02900de7ae6b8dbmr6814890pll.0.1611348929283; Fri, 22 Jan
 2021 12:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20210122164107.361939-1-hdegoede@redhat.com> <20210122164107.361939-12-hdegoede@redhat.com>
In-Reply-To: <20210122164107.361939-12-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 Jan 2021 22:56:18 +0200
Message-ID: <CAHp75VcP6NXn8gAze3B=b1m2sRZnrV=dL456D0QAGzON21etFQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] ASoC: arizona-jack: Cleanup logging
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 6:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Cleanup the use of dev_foo functions used for logging:
>
> 1. Many of these are unnecessarily split over multiple lines
> 2. Use dev_err_probe() in cases where we might get a -EPROBE_DEFERRED

s/RED$//

>    return value

...

> +               if (ret != 0)

Since you are touching it if (ret) would work already. Ditto for the
similar cases below.

...

>         if (IS_ERR(info->micvdd)) {
>                 ret = PTR_ERR(info->micvdd);
> -               dev_err(arizona->dev, "Failed to get MICVDD: %d\n", ret);
> +               dev_err_probe(arizona->dev, ret, "getting MICVDD\n");
>                 return ret;
>         }

Seems like your first dev_err_probe use :-)
Can be even more optimized, i.e.

  if (IS_ERR(info->micvdd))
    return dev_err_probe(arizona->dev, PTR_ERR(info->micvdd), "getting
MICVDD\n");

...

>                 if (IS_ERR(info->micd_pol_gpio)) {
>                         ret = PTR_ERR(info->micd_pol_gpio);
> -                       dev_err(arizona->dev,
> -                               "Failed to get microphone polarity GPIO: %d\n",
> -                               ret);
> +                       dev_err_probe(arizona->dev, ret, "getting microphone polarity GPIO\n");
>                         return ret;
>                 }

Ditto.

-- 
With Best Regards,
Andy Shevchenko
