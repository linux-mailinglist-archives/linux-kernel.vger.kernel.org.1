Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8B12FC58C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbhATASj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391549AbhASNpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:45:44 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E95C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:43:31 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id o19so11078739vsn.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTHQHqU0qhkolN2noyYVvQIfnQqsAqX/OkxGDVnDczg=;
        b=lMvP3hmORoGjFki5Mw/c9iRVt/gnrkbeBh3g9xc5AQZvG2FAgINcNJI9kyI/ucWXyf
         ZyzqgU0jSE5ffpLHsONVgjZ/9q9umFtsixU1wJbkI3S5XOmcWyMkZ77rFp8Gx395GpIi
         E1urx3oQLAoyBWHivI0ZqAmQ290EdVW0ZKNvI/NbPXDrqvDv5O+iBpw/mm3x3yvZ87sN
         ZkxPUaIkB2tBNpgYbMRPH8V2Jmr4GiIXuxzcdco/Eku+PkZ+9HPPgCAvU8UVNWxGT+dl
         I/QKhGZHlkS+cR1OALZlE6xUP8AhG60nEfAC6HQBqP28wIj0zD+ifI+XpiMAM3tLyHCr
         42Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTHQHqU0qhkolN2noyYVvQIfnQqsAqX/OkxGDVnDczg=;
        b=Tkwn01dLQN8Hu2feqzB7gPqLpgu2JhXMlt4dbNPua4N4UD8L3GXxNKu4BPaJTIYkUq
         EpLRNVM2JMuPkkOjKucwtRsFVyJ4PMbUFfbW2V1ma8su4N1YWdkhf8O6clDQ9S1lKMrf
         naIAKmBVrR06BjWU7Pt3fHmhxBGkuNmoN3/8n2R8EZHBT7K2Fo6fdGcjCntjaAJ9qoSi
         Pv1W8mm6ReFEuylh57DgBGp2g9Gjc2JMkN9zrZCNcqKMu3KweKmNlx81SHhvguhVhosM
         VXB6HUiQUBvKb8joOx+HjeZvGf+AtNCJStd1ZNHTnv3/vmepL65lcs9W+MexX8mdHnwF
         mOkQ==
X-Gm-Message-State: AOAM533bwSVUn8WSu+mhdJczTQN4VQJJAJLMQOe5la4A0a5/A+YxeHfq
        M5Sl4WS0DoFRlGZBUUACjDivYiWcgx2mdBI93FopRg==
X-Google-Smtp-Source: ABdhPJxdfo5M6JQMC8opiCITaK/YZ64HskqUZ4WcV5+m2ZOkH2PxqKWWebmRR9gP5qzaZ6XUz4pArh9lHym4ct2B+rA=
X-Received: by 2002:a67:7f41:: with SMTP id a62mr2544313vsd.55.1611063811106;
 Tue, 19 Jan 2021 05:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20210111082249.17092-1-reniuschengl@gmail.com>
In-Reply-To: <20210111082249.17092-1-reniuschengl@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 14:42:55 +0100
Message-ID: <CAPDyKFqnLTas50enA32MoKyx6ivZiJ5H+X5HJLPzS=nQ_b-UFw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Finetune HS400 RX delay for GL9763E
To:     Renius Chen <reniuschengl@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 at 09:22, Renius Chen <reniuschengl@gmail.com> wrote:
>
> To improve the compatibility of GL9763E with HS400 eMMC cards,
> finetune the RX delay of HS400 mode.
>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 2d13bfcbcacf..14d9154f3af1 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -95,6 +95,10 @@
>  #define PCIE_GLI_9763E_MMC_CTRL  0x960
>  #define   GLI_9763E_HS400_SLOW     BIT(3)
>
> +#define PCIE_GLI_9763E_CLKRXDLY  0x934
> +#define   GLI_9763E_HS400_RXDLY    GENMASK(31, 28)
> +#define   GLI_9763E_HS400_RXDLY_5  0x5
> +
>  #define SDHCI_GLI_9763E_CQE_BASE_ADDR   0x200
>  #define GLI_9763E_CQE_TRNS_MODE           (SDHCI_TRNS_MULTI | \
>                                     SDHCI_TRNS_BLK_CNT_EN | \
> @@ -801,6 +805,11 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MAX);
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
>
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, &value);
> +       value &= ~GLI_9763E_HS400_RXDLY;
> +       value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
> +
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>         value &= ~GLI_9763E_VHS_REV;
>         value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> --
> 2.27.0
>
