Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352212F0B05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 03:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbhAKCZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 21:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAKCZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 21:25:21 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96F8C061786;
        Sun, 10 Jan 2021 18:24:40 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id l14so6874393qvh.2;
        Sun, 10 Jan 2021 18:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGQGE/P7zFeVjmp8sXkUln0e8v6TZ5uhfq3Bnowm7sI=;
        b=kBLXwma7GmjHOu9EnI+4kzdu6mLbzGBHunbcBL53iYVea9o9twxuwVa/v8ecYOgkn0
         aF44jCNymnQOZ0tLwQMfcsXOOpCmjLV8EhX2pNgKJhOdxOddbsvwwwpuf0ho/1nlbFIN
         o7GZkyXTl8kK5METyATFCT28HtoLcHEE291yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGQGE/P7zFeVjmp8sXkUln0e8v6TZ5uhfq3Bnowm7sI=;
        b=foPsH/yeFkl6v82nCh8p2biqEXDKT1/da0N6Mp2nlOX9u9+cKfw+ep/zS2m19m1U0n
         n8DEWVbux+hAzsaBB5+vF8qQqSCEUAyQsYxeMeXrlzGIKDz9u/PAeRFHHknHoVUvlck8
         UBocWeIR+Al48wWLlRVyyXOYadHX6T42eyMrW+XL2IKUZgd3RADjE8ZN/pu7YsGOf+jN
         I1rnVQ5TQpbawgP340axx+mekkyxszvT5nOqgR4m5aOv9Qg84q4PqkwY4qZGMKGn5mmv
         YP2TQldmEI6dEPbGNG5lN63Uf3CFlwZk3djQBOl5tnV0QpEpfvP4azpXAVgU5iS1Zisq
         aRjg==
X-Gm-Message-State: AOAM532spGwz3cpA8Q8xEqZENBERViZTcDWfWoUenAGyvzaLp4j4Ga/7
        O5tc4X4IEHXCqnC/7mYZ4k9rJ8j5pB14hN2uHSfoHnN2oQtWaA==
X-Google-Smtp-Source: ABdhPJxaouI1Ui10wouE803ofFsrqx8gIkuSfvXhW51lYC9+Xwm3efzJcConRIfxsHULH9ZAnV5bDCL5+uB1oErJMKM=
X-Received: by 2002:a0c:a98c:: with SMTP id a12mr9902794qvb.43.1610331879213;
 Sun, 10 Jan 2021 18:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20210108081238.10199-1-ryan_chen@aspeedtech.com> <20210108081238.10199-2-ryan_chen@aspeedtech.com>
In-Reply-To: <20210108081238.10199-2-ryan_chen@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 11 Jan 2021 02:24:27 +0000
Message-ID: <CACPK8XdWKY4QmuojaZ13tmKR3MVEzU8MOV=bmqyTiotScaGfRA@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: gadget: aspeed: fix stop dma register setting.
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     BMC-SW <BMC-SW@aspeedtech.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-usb@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 at 08:13, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> The vhub engine has two dma mode, one is descriptor list, another
> is single stage DMA. Each mode has different stop register setting.
> Descriptor list operation (bit2) : 0 disable reset, 1: enable reset
> Single mode operation (bit0) : 0 : disable, 1: enable
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> index 0bd6b20435b8..02d8bfae58fb 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> @@ -420,7 +420,10 @@ static void ast_vhub_stop_active_req(struct ast_vhub_ep *ep,
>         u32 state, reg, loops;
>
>         /* Stop DMA activity */
> -       writel(0, ep->epn.regs + AST_VHUB_EP_DMA_CTLSTAT);
> +       if (ep->epn.desc_mode)
> +               writel(VHUB_EP_DMA_CTRL_RESET, ep->epn.regs + AST_VHUB_EP_DMA_CTLSTAT);
> +       else
> +               writel(0, ep->epn.regs + AST_VHUB_EP_DMA_CTLSTAT);

This looks correct, as whenever the driver re-enables DMA it uses
ep->epn.dma_conf for the value of this register. So we're not losing
any configuration by setting it to 0.

Acked-by: Joel Stanley <joel@jms.id.au>
Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")

I've cc'd Ben for his ack too.

Cheers,

Joel

>
>         /* Wait for it to complete */
>         for (loops = 0; loops < 1000; loops++) {
> --
> 2.17.1
>
