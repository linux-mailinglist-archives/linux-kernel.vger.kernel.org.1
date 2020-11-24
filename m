Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BD12C291B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbgKXOM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730566AbgKXOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:12:55 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B3C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:12:55 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id 103so3542749uai.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+WvQJn+RbKkh+kUKZATZKfERFtuz9WNMxrxpGdw4hA=;
        b=lVh9DyyEfKvcpYdLTOBc3Nv7y0XSPVmAax24cS/h8/bJq0VqEJVouyW0BXofj2piQz
         bgOBSfkFkwLeXYcIQcWo/iA5j1semJXlsGSiLQXskciSGm42jWE6AqL7gfMlHdsB5tt9
         N6IpPHvYLlca/szoVbA10P32eVBwV3iSJXKp/P2L/6O+GG2XmnmlS7X4rQF+CiewZ3fI
         Z+NcGQjghI2XAq8KoiMt4jRwIPMTAyMrJZQC6BsD5KANKnMG6ZVpCxXZyCm0qcX/kMMU
         ut+smv0g/SYIcPs9lj1u0xXaNMdZ/vu0oOtca6K1l3OEAR1Lub9HVQ6Vf8r+xdqEBp1/
         hiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+WvQJn+RbKkh+kUKZATZKfERFtuz9WNMxrxpGdw4hA=;
        b=etM4M+rOpXpEipvUf6RTcAEWKuoxNxpywyIs2FeQtQdFouaQR5p5F4Dx+F8hr3Jfxv
         sRZfS+FKmAJVCWAd+cDNMkbABaD49IelwFjDJJH0ydgPyvHS5TLB9LBqhx67TOwYeE3R
         z6jdCpMYFqdKGsFsqRjCWSq/BQyDNfvMdx22W52q0Sn/UM6Qb+7mMKAs0mIitOpX1oXT
         1MOOVIWbFF34i6KvvM6pRR9tCHBQUpzggysqlP9pmc+Fyz7EvYkKzRF+IgmwQo+nxmCS
         z7jCtwi+XgAPFtW1uDBRiYf6O5AFKoTwSYe763NplIhCRVB/NGmGd8/fFd8fSk+cxxFc
         JCXw==
X-Gm-Message-State: AOAM531pAYgQF9Lg2YSIZEkGd3RuyiAvj64kPXuaXsd3edTOQqFNoKXG
        H7P2kODT/4RCSclWVOE0pXNF0Nkn4OZs5+hIXlxe2w==
X-Google-Smtp-Source: ABdhPJxmk8XhxSo3oGE/to/rjbARVYneX0tkPuRJWkHA+FwhStIlTcIjXRAWqXDBjx8lvAFiCX8YN6mPcudkicwGqbQ=
X-Received: by 2002:ab0:23d5:: with SMTP id c21mr2736730uan.129.1606227174150;
 Tue, 24 Nov 2020 06:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20201123063004.337345-1-andrew@aj.id.au> <20201123063004.337345-2-andrew@aj.id.au>
In-Reply-To: <20201123063004.337345-2-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:12:17 +0100
Message-ID: <CAPDyKFrC9vp5gtpFC5L1K17uN059GsJ2zF4f7-_=sFEQ5BBRpw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mmc: sdhci-of-aspeed: Expose phase delay tuning
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ryan_chen@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 at 07:30, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The Aspeed SD/eMMC controllers feature up to two SDHCIs alongside a
> a set of "global" configuration registers. The global configuration
> registers house controller-specific settings that aren't exposed by the
> SDHCI, one example being a register for phase tuning.
>
> The phase tuning feature is new in the AST2600 design. It's exposed as a
> single register in the global register set and controls both the input
> and output phase adjustment for each slot. As the settings are
> slot-specific, the values to program are extracted from properties in
> the SDHCI devicetree nodes.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

[...]

>
> +static void
> +aspeed_sdhci_of_parse_phase(struct device_node *np, const char *prop,
> +                           struct aspeed_sdhci_phase_param *phase)
> +{
> +       int degrees[2] = {0};
> +       int rc;
> +
> +       rc = of_property_read_variable_u32_array(np, prop, degrees, 2, 0);
> +       phase->set = rc == 2;
> +       if (phase->set) {
> +               phase->in_deg = degrees[0];
> +               phase->out_deg = degrees[1];
> +       }
> +}
> +
> +static int aspeed_sdhci_of_parse(struct platform_device *pdev,
> +                                struct aspeed_sdhci *sdhci)
> +{
> +       struct device_node *np;
> +       struct device *dev;
> +
> +       if (!sdhci->phase_desc)
> +               return 0;
> +
> +       dev = &pdev->dev;
> +       np = dev->of_node;
> +
> +       aspeed_sdhci_of_parse_phase(np, "clk-phase-legacy",
> +                                   &sdhci->phase_param[MMC_TIMING_LEGACY]);
> +       aspeed_sdhci_of_parse_phase(np, "clk-phase-mmc-hs",
> +                                   &sdhci->phase_param[MMC_TIMING_MMC_HS]);
> +       aspeed_sdhci_of_parse_phase(np, "clk-phase-sd-hs",
> +                                   &sdhci->phase_param[MMC_TIMING_SD_HS]);
> +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr12",
> +                                   &sdhci->phase_param[MMC_TIMING_UHS_SDR12]);
> +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr25",
> +                                   &sdhci->phase_param[MMC_TIMING_UHS_SDR25]);
> +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr50",
> +                                   &sdhci->phase_param[MMC_TIMING_UHS_SDR50]);
> +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr104",
> +                                   &sdhci->phase_param[MMC_TIMING_UHS_SDR104]);
> +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-ddr50",
> +                                   &sdhci->phase_param[MMC_TIMING_UHS_DDR50]);
> +       aspeed_sdhci_of_parse_phase(np, "clk-phase-mmc-ddr52",
> +                                   &sdhci->phase_param[MMC_TIMING_MMC_DDR52]);
> +       aspeed_sdhci_of_parse_phase(np, "clk-phase-mmc-hs200",
> +                                   &sdhci->phase_param[MMC_TIMING_MMC_HS200]);
> +
> +       return 0;
> +}

If it's not too much to ask, would you mind adding a helper function
to the mmc core, as to let us avoid open coding? Then we should be
able to move the sdhci-of-arasan driver to use this as well.

Perhaps the definition of the helper could look something like this:
int mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase
*phases) (or something along those lines)

I think the struct mmc_clk_phase could be something that is stored in
the host specific struct, rather than in the common struct mmc_host
(to avoid sprinkle it with unnecessary data).

Moreover, we should probably use the device_property_* APIs instead of
the DT specific of_property_*.

[...]

Kind regards
Uffe
