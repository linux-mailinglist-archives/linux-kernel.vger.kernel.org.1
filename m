Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093332A0B30
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgJ3Qd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgJ3Qd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:33:26 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7B2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:33:25 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id b4so3735455vsd.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60X96wHH6oxkEKw3Afab3O24KtCk4+5hgm8DDnHt1JU=;
        b=MiMaTsSiQ65ylROmDY+3U4PeBnr4+sTXHfmp1l/Nj0SD+7nu+qnfwKdlxnjw0GR5IP
         fi0pTtQyxdB146Hq8YYsAkE7tk9qcCvypScoclc/TMuzx7uFMPrJf4nFrop4oOsiTubX
         EPPpVVnTl+WxRspJ+H8wh8hu7Odip5RHb4HvT4/mYHfzfR+1wjDYUXhEfMCZAXpW/ReW
         +saYC2I5NnW49h+9sAvziIrsBCsDB6VuYm+3WwVHnyLtjscg+l04mKhGKn0Yf4dT/I/k
         KKIc+cUAWGOd/i4SOpxXHz8qhRN5oV/SrVyIdH7MhpVeD2Ks7aziXZ5VNGApBlYihddp
         Y7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60X96wHH6oxkEKw3Afab3O24KtCk4+5hgm8DDnHt1JU=;
        b=XwDzjMGJQafV5oKT/YrYKn/Jd8Be6T7EEGAiGbTRC61pFLKnyqPamAxmJ70ZZDk/dr
         RO/aLFV+dtlaRTQ3GV0Lcf4CD8LOMs1RcqwILBHvBV/iASKr8dttOBC0hSBwHOpQbtRR
         KQm618gfcNOOT8cS082hm+xuti4g1ygd6QSE8AFq7SiQOpRVMrxk6KqLxJ9C8XNAQh6J
         M/fgDOuihnnRORI7qlT9nTIq1d1cSdk6Tt0Ab8NzpAAnxCRK2gozgSM/FMISSkcsztm1
         bzuP/qXglr8pKGXCOu1N8wy5QphhqbBFHMaJ2TXyh94Xh7r0q1vJ27GcdpQ4oV7bS9re
         YwLQ==
X-Gm-Message-State: AOAM531HENXjjpTgoGs2LNQgfEvo6Onm51cBNXIDeicch4i+hh7yf39M
        r7ZMmCPxqE1UxDLjnvpUNuhTKQuQ1jk=
X-Google-Smtp-Source: ABdhPJysb7EfsymEYFGSv+FsGhU/GMSf0/IMQOBIxWOncyyZgcGJ+mPZVJ/gtBjLMExVGvOroUsfvg==
X-Received: by 2002:a05:6102:21aa:: with SMTP id i10mr8171633vsb.9.1604075604342;
        Fri, 30 Oct 2020 09:33:24 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id r18sm863298vsq.15.2020.10.30.09.33.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 09:33:23 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id u7so3701023vsq.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:33:23 -0700 (PDT)
X-Received: by 2002:a67:f88e:: with SMTP id h14mr7424673vso.22.1604075602818;
 Fri, 30 Oct 2020 09:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201030022839.438135-1-xie.he.0141@gmail.com> <20201030022839.438135-6-xie.he.0141@gmail.com>
In-Reply-To: <20201030022839.438135-6-xie.he.0141@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 30 Oct 2020 12:32:46 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdS86GtG15y17G0nNaqHjHTeYzFn+0N5+nTjXM8u=hpJw@mail.gmail.com>
Message-ID: <CA+FuTSdS86GtG15y17G0nNaqHjHTeYzFn+0N5+nTjXM8u=hpJw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/5] net: hdlc_fr: Add support for any Ethertype
To:     Xie He <xie.he.0141@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Krzysztof Halasa <khc@pm.waw.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:32 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> Change the fr_rx function to make this driver support any Ethertype
> when receiving skbs on normal (non-Ethernet-emulating) PVC devices.
> (This driver is already able to handle any Ethertype when sending.)
>
> Originally in the fr_rx function, the code that parses the long (10-byte)
> header only recognizes a few Ethertype values and drops frames with other
> Ethertype values. This patch replaces this code to make fr_rx support
> any Ethertype. This patch also creates a new function fr_snap_parse as
> part of the new code.
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> ---
>  drivers/net/wan/hdlc_fr.c | 75 +++++++++++++++++++++++++--------------
>  1 file changed, 49 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/net/wan/hdlc_fr.c b/drivers/net/wan/hdlc_fr.c
> index 9a37575686b9..e95efc14bc97 100644
> --- a/drivers/net/wan/hdlc_fr.c
> +++ b/drivers/net/wan/hdlc_fr.c
> @@ -871,6 +871,45 @@ static int fr_lmi_recv(struct net_device *dev, struct sk_buff *skb)
>         return 0;
>  }
>

>  static int fr_rx(struct sk_buff *skb)
>  {
> @@ -945,35 +984,19 @@ static int fr_rx(struct sk_buff *skb)
>                 skb->protocol = htons(ETH_P_IPV6);
>                 skb_reset_mac_header(skb);
>
> -       } else if (skb->len > 10 && data[3] == FR_PAD &&
> -                  data[4] == NLPID_SNAP && data[5] == FR_PAD) {
> -               u16 oui = ntohs(*(__be16*)(data + 6));
> -               u16 pid = ntohs(*(__be16*)(data + 8));
> -               skb_pull(skb, 10);
> -
> -               switch ((((u32)oui) << 16) | pid) {
> -               case ETH_P_ARP: /* routed frame with SNAP */
> -               case ETH_P_IPX:
> -               case ETH_P_IP:  /* a long variant */
> -               case ETH_P_IPV6:
> -                       if (!pvc->main)
> -                               goto rx_drop;
> -                       skb->dev = pvc->main;
> -                       skb->protocol = htons(pid);
> -                       skb_reset_mac_header(skb);
> -                       break;
> -
> -               case 0x80C20007: /* bridged Ethernet frame */
> -                       if (!pvc->ether)
> +       } else if (data[3] == FR_PAD) {
> +               if (skb->len < 5)
> +                       goto rx_error;
> +               if (data[4] == NLPID_SNAP) { /* A SNAP header follows */

Should this still check data[5] == FR_PAD?


> +                       skb_pull(skb, 5);
> +                       if (skb->len < 5) /* Incomplete SNAP header */
> +                               goto rx_error;
> +                       if (fr_snap_parse(skb, pvc))
>                                 goto rx_drop;
> -                       skb->protocol = eth_type_trans(skb, pvc->ether);
> -                       break;
> -
> -               default:
> -                       netdev_info(frad, "Unsupported protocol, OUI=%x PID=%x\n",
> -                                   oui, pid);
> +               } else {
>                         goto rx_drop;
>                 }
> +
>         } else {
>                 netdev_info(frad, "Unsupported protocol, NLPID=%x length=%i\n",
>                             data[3], skb->len);
> --
> 2.27.0
>
