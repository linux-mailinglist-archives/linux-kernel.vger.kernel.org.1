Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4454B2CC1CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgLBQLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgLBQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:11:35 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE58C0613CF;
        Wed,  2 Dec 2020 08:10:54 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id z5so2428184iob.11;
        Wed, 02 Dec 2020 08:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCUnMGszFivw9xLAfIqizHM1Tvkom0qs+r/E4D0sCnk=;
        b=LdTxdT7/qCKfSutTgbj68CPmqTysCGOHj8YoZ0zcuDoTnp8HRr3dcWp4LJc5D63TFD
         a1SLBSDhMTglCVHH5D5uyEWoaJD0i+igriq0SorbhdDMfOiJxBHtaRasnU5IdETttERU
         UVx4aS/UvhO7OiXvfKu0AKwh8pqVf0KdnDL21fGClbfgLT0X1PU1J+cjiY7pEdX8rhnI
         AWRn22WGBlq1bMPQgEKeACTfmlj/jGyYsRmkChlWBF93F8VjaThXzVC4kt9mMUY5wBhR
         JWfFoKOivOLfwx57tmFfWIsdiZmu+BMOf2LcWtHfalRVCBXDbv+EuXG4z6jdJ2UEE8yI
         GNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCUnMGszFivw9xLAfIqizHM1Tvkom0qs+r/E4D0sCnk=;
        b=l29sgKppYRAvxADkTaeJj8w67OIig9VfFx9Nh50BcNMDY6VNZh9vOAxWorIfruxR+7
         c2cpd8GRVTcHLxysOKCLTlPYF+nv0YzEjp0K0ErYMYXb+Ncl8Rfx1mjWUNZQxSAqKuqe
         parkxsigQY+01wynydzxDYVoqluyUuOkawX4Xeob9UZICX9F+sp7wSrU4o0fxD0qz2zF
         3h+XLjZbyYUb2R9VPnIveHPASxmBfFrrsbqQa4PDpWFIkQ8lluJCs6LxQxFF/ixP/Ey2
         Ifx5xDTfnv8E0oa6+BwAD9JV8qtzPysTGS0X9QHNyZ6wRt94rXeDwK0kp6saNXaCzBSD
         dYNg==
X-Gm-Message-State: AOAM531mMPojPWGP2H+A9z1X9BBlxqhc0/BRN79V+wQPsWBC3uwTFE/3
        Muy5b2bgMk/T5WH5Tq/yZvsHC+M7ZqOthzPY5oc=
X-Google-Smtp-Source: ABdhPJxhBd/ukLAaccSFa7lX1ZQYgyBSmFfqwiFD5nn4fGBkOlYbzjEHETZ5fbN5+PQPVBJ7xcvAOBRN+doL5mFz8Ro=
X-Received: by 2002:a5d:854f:: with SMTP id b15mr2539371ios.170.1606925454246;
 Wed, 02 Dec 2020 08:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20201019111809.56374-1-alexandru.ardelean@analog.com>
In-Reply-To: <20201019111809.56374-1-alexandru.ardelean@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 2 Dec 2020 18:10:42 +0200
Message-ID: <CA+U=DsrpLTc7uti7pHSEDFzVSgVfbgxXzy3oiDb=csOSakmOZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: axi-clkgen: wrap limits in a struct and keep
 copy on the state object
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Moritz Fischer <mdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 2:14 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> Up until now the these limits were global/hard-coded, since they are
> typically limits of the fabric.
>
> However, since this is an FPGA generated clock, this may run on setups
> where one clock is on a fabric, and another one synthesized on another
> fabric connected via PCIe (or some other inter-connect), and then these
> limits need to be adjusted for each instance of the AXI CLKGEN.
>
> This change wraps the current constants in 'axi_clkgen_limits' struct and
> the 'axi_clkgen' instance keeps a copy of these limits, which is
> initialized at probe from the default limits.
>
> The limits are stored on the device-tree OF table, so that we can adjust
> them via the compatible string.

ping on this;
should i do a re-send for this?

>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/clk/clk-axi-clkgen.c | 48 +++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index 14d803e6af62..963a62e9c728 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -46,9 +46,17 @@
>  #define MMCM_CLK_DIV_DIVIDE    BIT(11)
>  #define MMCM_CLK_DIV_NOCOUNT   BIT(12)
>
> +struct axi_clkgen_limits {
> +       unsigned int fpfd_min;
> +       unsigned int fpfd_max;
> +       unsigned int fvco_min;
> +       unsigned int fvco_max;
> +};
> +
>  struct axi_clkgen {
>         void __iomem *base;
>         struct clk_hw clk_hw;
> +       struct axi_clkgen_limits limits;
>  };
>
>  static uint32_t axi_clkgen_lookup_filter(unsigned int m)
> @@ -100,12 +108,15 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
>         return 0x1f1f00fa;
>  }
>
> -static const unsigned int fpfd_min = 10000;
> -static const unsigned int fpfd_max = 300000;
> -static const unsigned int fvco_min = 600000;
> -static const unsigned int fvco_max = 1200000;
> +static const struct axi_clkgen_limits axi_clkgen_zynq_default_limits = {
> +       .fpfd_min = 10000,
> +       .fpfd_max = 300000,
> +       .fvco_min = 600000,
> +       .fvco_max = 1200000,
> +};
>
> -static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
> +static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
> +       unsigned long fin, unsigned long fout,
>         unsigned int *best_d, unsigned int *best_m, unsigned int *best_dout)
>  {
>         unsigned long d, d_min, d_max, _d_min, _d_max;
> @@ -122,12 +133,12 @@ static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
>         *best_m = 0;
>         *best_dout = 0;
>
> -       d_min = max_t(unsigned long, DIV_ROUND_UP(fin, fpfd_max), 1);
> -       d_max = min_t(unsigned long, fin / fpfd_min, 80);
> +       d_min = max_t(unsigned long, DIV_ROUND_UP(fin, limits->fpfd_max), 1);
> +       d_max = min_t(unsigned long, fin / limits->fpfd_min, 80);
>
>  again:
> -       fvco_min_fract = fvco_min << fract_shift;
> -       fvco_max_fract = fvco_max << fract_shift;
> +       fvco_min_fract = limits->fvco_min << fract_shift;
> +       fvco_max_fract = limits->fvco_max << fract_shift;
>
>         m_min = max_t(unsigned long, DIV_ROUND_UP(fvco_min_fract, fin) * d_min, 1);
>         m_max = min_t(unsigned long, fvco_max_fract * d_max / fin, 64 << fract_shift);
> @@ -319,6 +330,7 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
>         unsigned long rate, unsigned long parent_rate)
>  {
>         struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(clk_hw);
> +       const struct axi_clkgen_limits *limits = &axi_clkgen->limits;
>         unsigned int d, m, dout;
>         struct axi_clkgen_div_params params;
>         uint32_t power = 0;
> @@ -328,7 +340,7 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
>         if (parent_rate == 0 || rate == 0)
>                 return -EINVAL;
>
> -       axi_clkgen_calc_params(parent_rate, rate, &d, &m, &dout);
> +       axi_clkgen_calc_params(limits, parent_rate, rate, &d, &m, &dout);
>
>         if (d == 0 || dout == 0 || m == 0)
>                 return -EINVAL;
> @@ -368,10 +380,12 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
>  static long axi_clkgen_round_rate(struct clk_hw *hw, unsigned long rate,
>         unsigned long *parent_rate)
>  {
> +       struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(hw);
> +       const struct axi_clkgen_limits *limits = &axi_clkgen->limits;
>         unsigned int d, m, dout;
>         unsigned long long tmp;
>
> -       axi_clkgen_calc_params(*parent_rate, rate, &d, &m, &dout);
> +       axi_clkgen_calc_params(limits, *parent_rate, rate, &d, &m, &dout);
>
>         if (d == 0 || dout == 0 || m == 0)
>                 return -EINVAL;
> @@ -485,6 +499,7 @@ static const struct clk_ops axi_clkgen_ops = {
>  static const struct of_device_id axi_clkgen_ids[] = {
>         {
>                 .compatible = "adi,axi-clkgen-2.00.a",
> +               .data = &axi_clkgen_zynq_default_limits,
>         },
>         { },
>  };
> @@ -492,7 +507,7 @@ MODULE_DEVICE_TABLE(of, axi_clkgen_ids);
>
>  static int axi_clkgen_probe(struct platform_device *pdev)
>  {
> -       const struct of_device_id *id;
> +       const struct axi_clkgen_limits *dflt_limits;
>         struct axi_clkgen *axi_clkgen;
>         struct clk_init_data init;
>         const char *parent_names[2];
> @@ -501,11 +516,8 @@ static int axi_clkgen_probe(struct platform_device *pdev)
>         unsigned int i;
>         int ret;
>
> -       if (!pdev->dev.of_node)
> -               return -ENODEV;
> -
> -       id = of_match_node(axi_clkgen_ids, pdev->dev.of_node);
> -       if (!id)
> +       dflt_limits = device_get_match_data(&pdev->dev);
> +       if (!dflt_limits)
>                 return -ENODEV;
>
>         axi_clkgen = devm_kzalloc(&pdev->dev, sizeof(*axi_clkgen), GFP_KERNEL);
> @@ -527,6 +539,8 @@ static int axi_clkgen_probe(struct platform_device *pdev)
>                         return -EINVAL;
>         }
>
> +       memcpy(&axi_clkgen->limits, dflt_limits, sizeof(axi_clkgen->limits));
> +
>         clk_name = pdev->dev.of_node->name;
>         of_property_read_string(pdev->dev.of_node, "clock-output-names",
>                 &clk_name);
> --
> 2.17.1
>
