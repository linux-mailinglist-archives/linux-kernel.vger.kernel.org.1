Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BB229545C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506344AbgJUVll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506310AbgJUVll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:41:41 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD359C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:41:40 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id v23so2116064vsp.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34f0QO+WY6GWB1hcF4wDL21ijCp3A/erdheYzqIGDSs=;
        b=PYfq+CceDwXpvCEkEzaA++l/AjyHqlSKcGbivAwkGr1cm6RzPkbopHV3yUb7owYz75
         YU2cOhHKG9i8Oulr8K5T9yTprIMt3JVO2fvOakzDi/dvLeFt+D6+6ubPui9fOuPe+NPL
         vW1Pfr88RWBm6cqshT2f3DgjZ3mCN+x0ueVEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34f0QO+WY6GWB1hcF4wDL21ijCp3A/erdheYzqIGDSs=;
        b=tn6pBiIrXgMGdfyWkxdrgQpKUpe7yCRxG/jzFGtp8/QcV52o3sV5iIV/yvdF71hwtK
         oRujMJQhg8BIOflxU3VTX9yDuO7vJYverHBpQGhXVC2hh1XL+iV4DtlnvVKP/TXTrz1e
         O6kKVizUrsMUQxYN2ADPAXr7PCvjM7FKoGlytBYyMSlj26PBODwWj89kahWo8Gbdm06E
         J66EkzzsbsbJr0Pu/e2J3OFlFgVUeKIAF5zkZsKES/HZsNxhVdI2kLmczCurMub3iXJn
         iclLK1s5lUdGxZPl/F3oj2mrw0h7YMmnNcrH3BPETD/R/Q+pKuvMcuiVkCjvWNtZziJb
         BoPQ==
X-Gm-Message-State: AOAM533VNdgDbNq+0Zv9IbRd8tG+3GEasF5NTlr1279gVsagjLAx7ZH6
        NkD9yaaSdpWUC3iKtapqHZ7ttR84GdxXsg==
X-Google-Smtp-Source: ABdhPJwqWEMhKQU2KuiaVhefShH6r0WhW3vfEqkobvi7s46NvB9UvYFVbajnKXlVWd/IA9LZgi6aeA==
X-Received: by 2002:a67:f981:: with SMTP id b1mr3864520vsq.5.1603316499737;
        Wed, 21 Oct 2020 14:41:39 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id u185sm480629vke.14.2020.10.21.14.41.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 14:41:39 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id s15so2122788vsm.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:41:39 -0700 (PDT)
X-Received: by 2002:a67:eb52:: with SMTP id x18mr135935vso.34.1603316498648;
 Wed, 21 Oct 2020 14:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201016192654.32610-1-evgreen@chromium.org> <20201016122559.v2.3.Ibb3eedcd634298b039e3af2ec43c7860ae947916@changeid>
In-Reply-To: <20201016122559.v2.3.Ibb3eedcd634298b039e3af2ec43c7860ae947916@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 21 Oct 2020 14:41:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WjMi6BdoEjDoM=U=ZHDMsFdLQSU5q20HGjc+DyfnrJEg@mail.gmail.com>
Message-ID: <CAD=FV=WjMi6BdoEjDoM=U=ZHDMsFdLQSU5q20HGjc+DyfnrJEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] nvmem: core: Add support for keepout regions
To:     Evan Green <evgreen@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 16, 2020 at 12:27 PM Evan Green <evgreen@chromium.org> wrote:
>
> Introduce support into the nvmem core for arrays of register ranges
> that should not result in actual device access. For these regions a
> constant byte (repeated) is returned instead on read, and writes are
> quietly ignored and returned as successful.
>
> This is useful for instance if certain efuse regions are protected
> from access by Linux because they contain secret info to another part
> of the system (like an integrated modem).
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
> Changes in v2:
>  - Introduced keepout regions into the core (Srini)
>
>  drivers/nvmem/core.c           | 95 ++++++++++++++++++++++++++++++++--
>  include/linux/nvmem-provider.h | 17 ++++++
>  2 files changed, 108 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index a09ff8409f600..f7819c57f8828 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -19,6 +19,9 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>
> +#define MAX(a, b) ((a) > (b) ? (a) : (b))
> +#define MIN(a, b) ((a) < (b) ? (a) : (b))

Why not use min() / max() macros from include/linux/kernel.h?


> +static int nvmem_access_with_keepouts(struct nvmem_device *nvmem,
> +                                     unsigned int offset, void *val,
> +                                     size_t bytes, int write)
> +{
> +
> +       unsigned int end = offset + bytes;
> +       unsigned int kend, ksize;
> +       const struct nvmem_keepout *keepout = nvmem->keepout;
> +       const struct nvmem_keepout *keepoutend = keepout + nvmem->nkeepout;
> +       int rc;
> +
> +       /* Skip everything before the range being accessed */

nit: "Skip everything" => "Skip all keepouts"

...might not hurt to remind here that keepouts are sorted?


> +       while ((keepout < keepoutend) && (keepout->end <= offset))
> +               keepout++;
> +
> +       while ((offset < end) && (keepout < keepoutend)) {
> +

nit: remove blank line?


> @@ -647,6 +732,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>         nvmem->type = config->type;
>         nvmem->reg_read = config->reg_read;
>         nvmem->reg_write = config->reg_write;
> +       nvmem->keepout = config->keepout;
> +       nvmem->nkeepout = config->nkeepout;

It seems like it might be worth adding something to validate that the
ranges are sorted and return an error if they're not.

Maybe worth validating (and documenting) that the keepouts won't cause
us to violate "stride" and/or "word_size" ?


Everything above is just nits and other than them this looks like a
nice change.  BTW: this is the kind of thing that screams for unit
testing, though that might be a bit too much of a yak to shave here?

-Doug
