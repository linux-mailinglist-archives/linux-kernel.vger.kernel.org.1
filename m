Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F4728A968
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgJKSiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 14:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgJKSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:38:14 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48220C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:38:14 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id w12so4757016uao.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LE5+6X44Ua2bvmzUcaKfhMsht1eiuM/FlyTObIJojA=;
        b=PJ2GRWYt81lzLhvYB2TcbhTZLHq1zgnXFVPb45QhgZbLCGR6qi9PjP7BPvbcGYbN57
         /ct8nsW5Fl9cKSIhDkcfxUjZ+OHrKJCqwga+j8iNXXDqz6G+cCsr1+eQLDcg9XbxDJLr
         JhXn/du2kEA5AQTSEjmQAXameh7vMkbMESYcZjhbPfsrnl3W2HjegQN4BMpSiH9YkHYj
         RO/birE2JMFGAfKhmIC7XPjO5Pv1IHQapMCrGyyiEOk2SGenkgn2LcqkWojVi2Jo6Viy
         QXMHInvDBrL6WMjFoyc+29r14CHC5SY4wSh9NuEy3vaRmuFQEiEFjBMHuh6Ydj0E/jWb
         hvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LE5+6X44Ua2bvmzUcaKfhMsht1eiuM/FlyTObIJojA=;
        b=FDWpXxkeObCg3e0T3JVbGj6oPbVZj8Opkkr2AZtn2fuIn2IyslSzRvIHUbswIDXxWB
         uro2OnbgpQGgZDW5P4gEsX1PB+k5I9bB7VCMiGsf2nz0koagLF8peKfNyeAxEU592yra
         5hpOZvZtKqwSaRBrW69AWeHbVZfbzAIhdBbusWsMIuDPe3BERKOAOFWV5OEAypyLl9Dq
         MuNypgkGojlnxNHl0c5B6B5O0XTmn9pWPMRuVOR5yw+XYmk/yqPLZSrAbBQuWtjTVXOP
         /mxfjWabBPh5O79mk1Nlyx1lYqFcKPyFq9mOsY9lEbloP68i5zQKs94rOYhGUrIZPIOz
         syGQ==
X-Gm-Message-State: AOAM531caQWb3JTambAovVPADvBjocgK4uAIYn5ZtcLvRJfXNS5HNko2
        MJ1d0kcelcXxaORnM4HmXwi3W6vcOu8=
X-Google-Smtp-Source: ABdhPJwNJ0A1RwE4N0sTNDPYGzhZvnZ+fA3FM0dfsqIGSfmBPXnh4PMpthDxMTMemQKfQTJxEkMp/Q==
X-Received: by 2002:ab0:614f:: with SMTP id w15mr5140907uan.116.1602441492621;
        Sun, 11 Oct 2020 11:38:12 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id k10sm1881238vsp.23.2020.10.11.11.38.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2020 11:38:11 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id r78so3332044vke.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:38:10 -0700 (PDT)
X-Received: by 2002:a1f:ae85:: with SMTP id x127mr8696215vke.8.1602441489893;
 Sun, 11 Oct 2020 11:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201011113955.19511-1-vvidic@valentin-vidic.from.hr>
In-Reply-To: <20201011113955.19511-1-vvidic@valentin-vidic.from.hr>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 11 Oct 2020 14:37:33 -0400
X-Gmail-Original-Message-ID: <CA+FuTScdX+kN_XHJiY9YCst6JTQHZ0g28XYakhcK92Oo2Kp5vw@mail.gmail.com>
Message-ID: <CA+FuTScdX+kN_XHJiY9YCst6JTQHZ0g28XYakhcK92Oo2Kp5vw@mail.gmail.com>
Subject: Re: [PATCH] net: korina: free array used for rx/tx descriptors
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Philip Rischel <rischelp@idt.com>,
        Felix Fietkau <nbd@openwrt.org>,
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

On Sun, Oct 11, 2020 at 7:46 AM Valentin Vidic
<vvidic@valentin-vidic.from.hr> wrote:
>
> Memory was not freed when driver is unloaded from the kernel.
>
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>

Makes sense.

Fixes: ef11291bcd5f ("Add support the Korina (IDT RC32434) Ethernet MAC")

Slightly off-topic, but I don't fully fathom what goes on with this
pointer straight after the initial kmalloc.

        lp->td_ring = (struct dma_desc *)KSEG1ADDR(lp->td_ring);

> ---
>  drivers/net/ethernet/korina.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
> index 03e034918d14..99146145f020 100644
> --- a/drivers/net/ethernet/korina.c
> +++ b/drivers/net/ethernet/korina.c
> @@ -1133,6 +1133,7 @@ static int korina_remove(struct platform_device *pdev)
>         iounmap(lp->eth_regs);
>         iounmap(lp->rx_dma_regs);
>         iounmap(lp->tx_dma_regs);
> +       kfree(lp->td_ring);
>
>         unregister_netdev(bif->dev);
>         free_netdev(bif->dev);

In general it is nice to release in reverse of acquire. But the driver
already does not follow this practice.
