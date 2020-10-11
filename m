Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2856528AB01
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 00:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbgJKWyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 18:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbgJKWyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 18:54:12 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DABC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 15:54:12 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id s15so8178712vsm.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 15:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0a8rirJkNGvDXYf+j+cPb4Z4egwrNP6SKqObG7YZso=;
        b=nKlwcYj9jtQSorax14eeeSYvAS1DzamxIgZPL7HgqNL7sd9bRIZJzkIwAYx1J7OOQA
         3IJIZAZfO65Aj+Yu2nJVcoRnj9pdiuASpBg22Xj1SBOzpoYxejIoAD9I8+Ho/yW7V2C8
         06S8oooG7FF6qU90jA2Ip3AGKtdGOl5yEKDk4f541+FnoakTOqr6rGNSFz1szOxBejyq
         XCoPBr6VvS3wYG1bgmhRVHx5uKJs/3mvRJOifJ2f6iQVq9n/3muIdtxRy+O8PKSLuPsw
         L9qX+qRoYScDq7ZBaGOce9NLwsnRAuoPrlOznVwbt3nsga12kY6l8viapeaSXiCuatXK
         TiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0a8rirJkNGvDXYf+j+cPb4Z4egwrNP6SKqObG7YZso=;
        b=ImMjCiHUO3AkSirJgkhDKEQvHIkRCe9r81oqWfxlA44CeljJ0z1DVXWDrj51Di2FPW
         gDV1o74ZfElpy9s/3cZ24MdtSsBPtSovdfh5gDQv0N9Oc5gvG0K1otn+QLvMw8qMaP29
         mUjUSGwGfLrdXzoy7e7Wee9qbT5+xF7Cnn8ApNErBhkZ2gvmeHqm7EFGXO3rfIna6kZl
         hyv/tdu5wP7fk0Ice8KTxT8Y8V6W3LimNQWf6lfXX/1soUXi0lPlQriqP/Ljxf1Nnocc
         ketg75zUINUpsFAwrqlSrJcZbrsYZqvLTH8rb/5Hl/vZh5Yy7lhyh42WS6uVDpKi6/dp
         toXQ==
X-Gm-Message-State: AOAM531MeGtxd+TEP2rv1MXgr2EX0puEG2ujOGzGT+YmgLFeGQH/+GRG
        wfzSQtQKae/W8LrC9N9OSrOchlkbDbw=
X-Google-Smtp-Source: ABdhPJw2c+D/Q7eJpWDO6a+pcBm5oZ1su32okHaRDzb7tZxNtTa69GUcN3q8VP1Xu/jse/3L3pidsw==
X-Received: by 2002:a67:bc0d:: with SMTP id t13mr12621677vsn.4.1602456850160;
        Sun, 11 Oct 2020 15:54:10 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id o11sm982058vko.31.2020.10.11.15.54.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2020 15:54:09 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id r1so7127375vsi.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 15:54:08 -0700 (PDT)
X-Received: by 2002:a67:d84:: with SMTP id 126mr11971002vsn.51.1602456848320;
 Sun, 11 Oct 2020 15:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201011212135.GD8773@valentin-vidic.from.hr> <20201011220329.13038-1-vvidic@valentin-vidic.from.hr>
In-Reply-To: <20201011220329.13038-1-vvidic@valentin-vidic.from.hr>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 11 Oct 2020 18:53:31 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfFcyVPd3Tr=wFSfSFBojpXPMZGmPvS0m+iM4TiRpsM5w@mail.gmail.com>
Message-ID: <CA+FuTSfFcyVPd3Tr=wFSfSFBojpXPMZGmPvS0m+iM4TiRpsM5w@mail.gmail.com>
Subject: Re: [PATCH v2] net: korina: fix kfree of rx/tx descriptor array
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Philip Rischel <rischelp@idt.com>,
        Florian Fainelli <florian@openwrt.org>,
        Roman Yeryomin <roman@advem.lv>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Martin Habets <mhabets@solarflare.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 6:04 PM Valentin Vidic
<vvidic@valentin-vidic.from.hr> wrote:
>
> kmalloc returns KSEG0 addresses so convert back from KSEG1
> in kfree. Also make sure array is freed when the driver is
> unloaded from the kernel.
>
> Fixes: ef11291bcd5f ("Add support the Korina (IDT RC32434) Ethernet MAC")
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>

Ah, this a MIPS architecture feature, both KSEGs mapping the same
region, just cachable vs non-cachable.

Acked-by: Willem de Bruijn <willemb@google.com>


> ---
>  v2: convert kfree address back to KSEG0
>
>  drivers/net/ethernet/korina.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
> index 03e034918d14..af441d699a57 100644
> --- a/drivers/net/ethernet/korina.c
> +++ b/drivers/net/ethernet/korina.c
> @@ -1113,7 +1113,7 @@ static int korina_probe(struct platform_device *pdev)
>         return rc;
>
>  probe_err_register:
> -       kfree(lp->td_ring);
> +       kfree(KSEG0ADDR(lp->td_ring));
>  probe_err_td_ring:
>         iounmap(lp->tx_dma_regs);
>  probe_err_dma_tx:
> @@ -1133,6 +1133,7 @@ static int korina_remove(struct platform_device *pdev)
>         iounmap(lp->eth_regs);
>         iounmap(lp->rx_dma_regs);
>         iounmap(lp->tx_dma_regs);
> +       kfree(KSEG0ADDR(lp->td_ring));
>
>         unregister_netdev(bif->dev);
>         free_netdev(bif->dev);
> --
> 2.20.1
>
