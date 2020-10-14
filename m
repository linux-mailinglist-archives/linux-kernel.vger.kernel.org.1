Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA81E28E68C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgJNSjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730119AbgJNSjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:39:39 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D6822248;
        Wed, 14 Oct 2020 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602700778;
        bh=ipZ8ZDCyuKASPr8Y4k991jKvFK+t9ZMjAhvXJ7QFPt8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rxenAejXqVTbRUS0ad30QBTTnS//uIpVDQvT5jwUH4g4O+e9BohkMoktK8xrNZXLd
         Xu3l4UCCpJPqJ16uluOYzLJEdeutMpL8DUfK/2Tx9yV1byeiRumDTQFlXtrz9mZifq
         fXtZxNU787ETEmh2y6hSw10wlTWHGAF2+VMW0yQ8=
Received: by mail-oi1-f178.google.com with SMTP id j7so197778oie.12;
        Wed, 14 Oct 2020 11:39:38 -0700 (PDT)
X-Gm-Message-State: AOAM531bn1Mge68vyiVc3iCEvH7MLu5adOT06MySCb7vE0Cv37tJcMpb
        0Vq29R/Eq9uaLDQ8FHmmNlEue9z8jfRlmS19Kg==
X-Google-Smtp-Source: ABdhPJwtxhFlBxtHfSQbYp/Zz1Fzpq1G/aOTdazdjlGlk6mXcM3ifdAV2tLiIw43JP9g0OxQFq3WXRMjzUzheD3HrX8=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr459940oiy.106.1602700777799;
 Wed, 14 Oct 2020 11:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201014145418.31838-1-rf@opensource.cirrus.com> <20201014145418.31838-2-rf@opensource.cirrus.com>
In-Reply-To: <20201014145418.31838-2-rf@opensource.cirrus.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Oct 2020 13:39:26 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+qdcHc9H7qUVwLieHrLM8E20HZXa8DkarMiuXfCh8WOQ@mail.gmail.com>
Message-ID: <CAL_Jsq+qdcHc9H7qUVwLieHrLM8E20HZXa8DkarMiuXfCh8WOQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] of: base: Add of_count_phandle_with_fixed_args()
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        - <patches@opensource.cirrus.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 9:54 AM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add an equivalent of of_count_phandle_with_args() for fixed argument
> sets, to pair with of_parse_phandle_with_fixed_args().
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/of/base.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h |  9 +++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ea44fea99813..45d8b0e65345 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1772,6 +1772,48 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
>  }
>  EXPORT_SYMBOL(of_count_phandle_with_args);
>
> +/**
> + * of_count_phandle_with_fixed_args() - Find the number of phandles references in a property
> + * @np:                pointer to a device tree node containing a list
> + * @list_name: property name that contains a list
> + * @cell_count: number of argument cells following the phandle
> + *
> + * Returns the number of phandle + argument tuples within a property. It
> + * is a typical pattern to encode a list of phandle and variable
> + * arguments into a single property.
> + */
> +int of_count_phandle_with_fixed_args(const struct device_node *np,
> +                                    const char *list_name,
> +                                    int cells_count)
> +{

Looks to me like you can refactor of_count_phandle_with_args to handle
both case and then make this and of_count_phandle_with_args simple
wrapper functions.

> +       struct of_phandle_iterator it;
> +       int rc, cur_index = 0;
> +
> +       if (!cells_count) {
> +               const __be32 *list;
> +               int size;
> +
> +               list = of_get_property(np, list_name, &size);
> +               if (!list)
> +                       return -ENOENT;
> +
> +               return size / sizeof(*list);
> +       }
> +
> +       rc = of_phandle_iterator_init(&it, np, list_name, NULL, cells_count);
> +       if (rc)
> +               return rc;
> +
> +       while ((rc = of_phandle_iterator_next(&it)) == 0)
> +               cur_index += 1;
> +
> +       if (rc != -ENOENT)
> +               return rc;
> +
> +       return cur_index;
> +}
> +EXPORT_SYMBOL(of_count_phandle_with_fixed_args);
> +
>  /**
>   * __of_add_property - Add a property to a node without lock operations
>   */
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 5cf7ae0465d1..9f315da4e9da 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -377,6 +377,8 @@ extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
>         struct of_phandle_args *out_args);
>  extern int of_count_phandle_with_args(const struct device_node *np,
>         const char *list_name, const char *cells_name);
> +extern int of_count_phandle_with_fixed_args(const struct device_node *np,
> +       const char *list_name, int cells_count);
>
>  /* phandle iterator functions */
>  extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
> @@ -886,6 +888,13 @@ static inline int of_count_phandle_with_args(struct device_node *np,
>         return -ENOSYS;
>  }
>
> +static inline int of_count_phandle_with_fixed_args(const struct device_node *np,
> +                                                  const char *list_name,
> +                                                  int cells_count)
> +{
> +       return -ENOSYS;
> +}
> +
>  static inline int of_phandle_iterator_init(struct of_phandle_iterator *it,
>                                            const struct device_node *np,
>                                            const char *list_name,
> --
> 2.20.1
>
