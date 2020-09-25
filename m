Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F35278263
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgIYIPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgIYIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:15:12 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE442C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:15:11 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i26so2393441ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ji8pw3pg6KNs2Rx3h2YvAgjNZSLkG03JCK86FrD3E1w=;
        b=cxESfqXpHGzBbP1O6bDBtq8knQK0st1mJYZ82Z1fQ7Z00dyyZAG504QmT5zi7IQ/Js
         ckhJMCGg1J9JkNFe2xy8jYWOBC2i/czhNkUh6nrdeTFam1o2WdHWbqIZCHgSw+xDYRjv
         BqWEsLQn5xWR5JiJlJJazOEr6POkk2R+2h1uY5pOxxbmDkMDKsHJ0wl1T++pXQ9+dC5O
         hwq/nGbEeCFxrFTkBngvofwhnBAszOf4B+H9iYLVnlKc7JeBIrT5KICPXPR9GWxVV7wf
         j1kXWnEUQhfMjt4cSpljLnbRRhHWPsYgwwTOrQbpwgFQwS2rT1Opp8dqGiTSQODX/O+C
         L/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ji8pw3pg6KNs2Rx3h2YvAgjNZSLkG03JCK86FrD3E1w=;
        b=tVLbS6Fse6L2Yi+BjPO8sPe3Ell1gQ/DADR+JKizgPWGPMuNONqKh3npgOtCt61VJR
         zQ/w63663LqOpMovAeZCQ7xlDfl/NY7+BH27yME6jJGUCkAlNXSJwu2gdWC2xjKXIJSB
         zzbi2mdf16I2ffx0JHNKLFNPabGPBsTc0JuqQEujjh1aAksBCqUWugE1j/++oL0q+d9/
         lCc2iKoaye6FcZIdjF6AK8HX12Hx+KPVifZwME/yj2EkhqTDEBmITXjHjLmxdQCaTK2N
         FFVWOL0s5aoegEv6Lzgkc0L0qvG1cub3N1PDEeBtC1PBMZZFex90ZpPRdwuUN3z6fwtp
         ymTA==
X-Gm-Message-State: AOAM5300UB9liA4q52ufEMkhgjOvual4GlpBx1Ejup1vPF6ZKD+nw32S
        CRtt1hzEYLs1xPTzGSU8yMZNBczQlTO9ShVD7D8c136FNXQ=
X-Google-Smtp-Source: ABdhPJymdkfGH2R7Mg5iggu7WJvmZaEuEMqPDXhraYi9HYtU1cBau2PuTx7QDCG/djZ1MahcHaeB1AX/Xrt04rP/YXg=
X-Received: by 2002:a17:906:7f15:: with SMTP id d21mr1605118ejr.470.1601021710519;
 Fri, 25 Sep 2020 01:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200925024247.993-1-yongxin.liu@windriver.com>
In-Reply-To: <20200925024247.993-1-yongxin.liu@windriver.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 25 Sep 2020 10:14:59 +0200
Message-ID: <CAMpxmJWjczUhKH2K25E4Ezs9DEFQMxHMhD8qzhurSeEyE=wmXg@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: ethernet: ixgbe: check the return value of ixgbe_mii_bus_init()"
To:     Yongxin Liu <yongxin.liu@windriver.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 4:45 AM Yongxin Liu <yongxin.liu@windriver.com> wrote:
>
> This reverts commit 09ef193fef7efb0175a04634853862d717adbb95.
>
> For C3000 family of SoCs, they have four ixgbe devices sharing a single MDIO bus.
> ixgbe_mii_bus_init() returns -ENODEV for other three devices. The propagation
> of the error code makes other three ixgbe devices unregistered.
>
> Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 2f8a4cfc5fa1..5e5223becf86 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -11031,14 +11031,10 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>                         IXGBE_LINK_SPEED_10GB_FULL | IXGBE_LINK_SPEED_1GB_FULL,
>                         true);
>
> -       err = ixgbe_mii_bus_init(hw);
> -       if (err)
> -               goto err_netdev;
> +       ixgbe_mii_bus_init(hw);
>
>         return 0;
>
> -err_netdev:
> -       unregister_netdev(netdev);
>  err_register:
>         ixgbe_release_hw_control(adapter);
>         ixgbe_clear_interrupt_scheme(adapter);
> --
> 2.14.4
>

Then we should check if err == -ENODEV, not outright ignore all
potential errors, right?

Bartosz
