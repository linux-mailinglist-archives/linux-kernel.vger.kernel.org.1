Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F032CCE0E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 05:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgLCErY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 23:47:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44132 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgLCErY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 23:47:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id b23so443383pls.11;
        Wed, 02 Dec 2020 20:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aAG23Weit5T1H3h9q3ADXcaHYdrFnCkvvkEQnZGgOak=;
        b=s2ZUfxM9OLxFpe8bsB6MvJsC7h4lJDuP9Q2eUI8e0LQxkd17T8ywZOmG6jisAFI0eK
         ZNx5j5mZ+xE9jienA8f7miCsWH/fNHH0I3FlE17mnEQ0SeSi8VaDAZ5Pi8fSoRaVDNti
         LudRvCNKHzhsbPVaK3WXO2Y4LNfX8Ybnw0rlct9q4CVrRE8I/EHNnckt+KsUVRduP/0u
         yVStOtSCv9caEJ0Zsb0+dqs3OML0Y53oOfTojt4Js/AAiyqf8ShL8CAgdzY69ytlLnxc
         FkC8DySIyGq+x2HlIq8HuO2SoBruUT2Y43kUW7mwsmrzTuoxZzGOubhTXTLxqQKtHWLF
         JoDw==
X-Gm-Message-State: AOAM533/9r9S88NJfzJjntbG0XsmJQDlNgTzHrVzmU7ZmvQDjF2DRxO/
        44n0IFB+7vlEpgHuSYNOUu5kArwqqYMo8Q==
X-Google-Smtp-Source: ABdhPJwLt5yYeK82HSLF33fmBokmFMoA8XyypfogEbdrJmwcYSVzBD+PdZRGq375DRH+ASZw2wOccA==
X-Received: by 2002:a17:90a:d307:: with SMTP id p7mr1356778pju.214.1606970802649;
        Wed, 02 Dec 2020 20:46:42 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id r7sm419816pjd.8.2020.12.02.20.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 20:46:41 -0800 (PST)
Date:   Wed, 2 Dec 2020 20:46:40 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 1/2] clk: axi-clkgen: wrap limits in a struct and keep
 copy on the state object
Message-ID: <X8htsIO+iYMMSuaK@archbook>
References: <20201019111809.56374-1-alexandru.ardelean@analog.com>
 <CA+U=DsrpLTc7uti7pHSEDFzVSgVfbgxXzy3oiDb=csOSakmOZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=DsrpLTc7uti7pHSEDFzVSgVfbgxXzy3oiDb=csOSakmOZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Wed, Dec 02, 2020 at 06:10:42PM +0200, Alexandru Ardelean wrote:
> On Mon, Oct 19, 2020 at 2:14 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > Up until now the these limits were global/hard-coded, since they are
> > typically limits of the fabric.
> >
> > However, since this is an FPGA generated clock, this may run on setups
> > where one clock is on a fabric, and another one synthesized on another
> > fabric connected via PCIe (or some other inter-connect), and then these
> > limits need to be adjusted for each instance of the AXI CLKGEN.
> >
> > This change wraps the current constants in 'axi_clkgen_limits' struct and
> > the 'axi_clkgen' instance keeps a copy of these limits, which is
> > initialized at probe from the default limits.
> >
> > The limits are stored on the device-tree OF table, so that we can adjust
> > them via the compatible string.
> 
> ping on this;
> should i do a re-send for this?

I'd try resending, yes.
> 
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/clk/clk-axi-clkgen.c | 48 +++++++++++++++++++++++-------------
> >  1 file changed, 31 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> > index 14d803e6af62..963a62e9c728 100644
> > --- a/drivers/clk/clk-axi-clkgen.c
> > +++ b/drivers/clk/clk-axi-clkgen.c
> > @@ -46,9 +46,17 @@
> >  #define MMCM_CLK_DIV_DIVIDE    BIT(11)
> >  #define MMCM_CLK_DIV_NOCOUNT   BIT(12)
> >
> > +struct axi_clkgen_limits {
> > +       unsigned int fpfd_min;
> > +       unsigned int fpfd_max;
> > +       unsigned int fvco_min;
> > +       unsigned int fvco_max;
> > +};
> > +
> >  struct axi_clkgen {
> >         void __iomem *base;
> >         struct clk_hw clk_hw;
> > +       struct axi_clkgen_limits limits;
> >  };
> >
> >  static uint32_t axi_clkgen_lookup_filter(unsigned int m)
> > @@ -100,12 +108,15 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
> >         return 0x1f1f00fa;
> >  }
> >
> > -static const unsigned int fpfd_min = 10000;
> > -static const unsigned int fpfd_max = 300000;
> > -static const unsigned int fvco_min = 600000;
> > -static const unsigned int fvco_max = 1200000;
> > +static const struct axi_clkgen_limits axi_clkgen_zynq_default_limits = {
> > +       .fpfd_min = 10000,
> > +       .fpfd_max = 300000,
> > +       .fvco_min = 600000,
> > +       .fvco_max = 1200000,
> > +};
> >
> > -static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
> > +static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
> > +       unsigned long fin, unsigned long fout,
> >         unsigned int *best_d, unsigned int *best_m, unsigned int *best_dout)
> >  {
> >         unsigned long d, d_min, d_max, _d_min, _d_max;
> > @@ -122,12 +133,12 @@ static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
> >         *best_m = 0;
> >         *best_dout = 0;
> >
> > -       d_min = max_t(unsigned long, DIV_ROUND_UP(fin, fpfd_max), 1);
> > -       d_max = min_t(unsigned long, fin / fpfd_min, 80);
> > +       d_min = max_t(unsigned long, DIV_ROUND_UP(fin, limits->fpfd_max), 1);
> > +       d_max = min_t(unsigned long, fin / limits->fpfd_min, 80);
> >
> >  again:
> > -       fvco_min_fract = fvco_min << fract_shift;
> > -       fvco_max_fract = fvco_max << fract_shift;
> > +       fvco_min_fract = limits->fvco_min << fract_shift;
> > +       fvco_max_fract = limits->fvco_max << fract_shift;
> >
> >         m_min = max_t(unsigned long, DIV_ROUND_UP(fvco_min_fract, fin) * d_min, 1);
> >         m_max = min_t(unsigned long, fvco_max_fract * d_max / fin, 64 << fract_shift);
> > @@ -319,6 +330,7 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
> >         unsigned long rate, unsigned long parent_rate)
> >  {
> >         struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(clk_hw);
> > +       const struct axi_clkgen_limits *limits = &axi_clkgen->limits;
> >         unsigned int d, m, dout;
> >         struct axi_clkgen_div_params params;
> >         uint32_t power = 0;
> > @@ -328,7 +340,7 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
> >         if (parent_rate == 0 || rate == 0)
> >                 return -EINVAL;
> >
> > -       axi_clkgen_calc_params(parent_rate, rate, &d, &m, &dout);
> > +       axi_clkgen_calc_params(limits, parent_rate, rate, &d, &m, &dout);
> >
> >         if (d == 0 || dout == 0 || m == 0)
> >                 return -EINVAL;
> > @@ -368,10 +380,12 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
> >  static long axi_clkgen_round_rate(struct clk_hw *hw, unsigned long rate,
> >         unsigned long *parent_rate)
> >  {
> > +       struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(hw);
> > +       const struct axi_clkgen_limits *limits = &axi_clkgen->limits;
> >         unsigned int d, m, dout;
> >         unsigned long long tmp;
> >
> > -       axi_clkgen_calc_params(*parent_rate, rate, &d, &m, &dout);
> > +       axi_clkgen_calc_params(limits, *parent_rate, rate, &d, &m, &dout);
> >
> >         if (d == 0 || dout == 0 || m == 0)
> >                 return -EINVAL;
> > @@ -485,6 +499,7 @@ static const struct clk_ops axi_clkgen_ops = {
> >  static const struct of_device_id axi_clkgen_ids[] = {
> >         {
> >                 .compatible = "adi,axi-clkgen-2.00.a",
> > +               .data = &axi_clkgen_zynq_default_limits,
> >         },
> >         { },
> >  };
> > @@ -492,7 +507,7 @@ MODULE_DEVICE_TABLE(of, axi_clkgen_ids);
> >
> >  static int axi_clkgen_probe(struct platform_device *pdev)
> >  {
> > -       const struct of_device_id *id;
> > +       const struct axi_clkgen_limits *dflt_limits;
> >         struct axi_clkgen *axi_clkgen;
> >         struct clk_init_data init;
> >         const char *parent_names[2];
> > @@ -501,11 +516,8 @@ static int axi_clkgen_probe(struct platform_device *pdev)
> >         unsigned int i;
> >         int ret;
> >
> > -       if (!pdev->dev.of_node)
> > -               return -ENODEV;
> > -
> > -       id = of_match_node(axi_clkgen_ids, pdev->dev.of_node);
> > -       if (!id)
> > +       dflt_limits = device_get_match_data(&pdev->dev);
> > +       if (!dflt_limits)
> >                 return -ENODEV;
> >
> >         axi_clkgen = devm_kzalloc(&pdev->dev, sizeof(*axi_clkgen), GFP_KERNEL);
> > @@ -527,6 +539,8 @@ static int axi_clkgen_probe(struct platform_device *pdev)
> >                         return -EINVAL;
> >         }
> >
> > +       memcpy(&axi_clkgen->limits, dflt_limits, sizeof(axi_clkgen->limits));
> > +
> >         clk_name = pdev->dev.of_node->name;
> >         of_property_read_string(pdev->dev.of_node, "clock-output-names",
> >                 &clk_name);
> > --
> > 2.17.1
> >

- Moritz
