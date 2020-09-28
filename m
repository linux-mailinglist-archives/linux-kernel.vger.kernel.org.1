Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0C927B618
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 22:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgI1URR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 16:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgI1URQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 16:17:16 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E10C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 13:17:14 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id z19so2646345uap.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ac5Zwjpr9AVZ3pSe9QkEO8EPUo8M1+nPVhneyJIUqAY=;
        b=Y2c/K5nnzDh4DbGtuNoYr0jfKdm1Uz0zud9DFXef5BKN0+Diio5gLKL7SPt1yvIYMN
         foB/5kWx9nsm5FhESFZj7pBVElk0RVu5g5SnFGTvnYXUB0C7ECVHnkEHVdxE9YPRr8pf
         3nB78wVzrQr9ikiMJLgJ7MibqaDa/0CfYjnKMwK7oYZYje96/cQ7oPt29le/L6hPlYjM
         8fcNFVR/03B/I5Cfxk/rO802OztXOo8rGW7VSYNOUsw1wFGH8R8h5WO1s5v/5fEuDwtC
         0g07k4zsR6CtpRHzHM+MoyuyoW+zwdTwImtkAphHlfSRZ+f5iyhLlHnYyc283Fgil0z3
         ianA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ac5Zwjpr9AVZ3pSe9QkEO8EPUo8M1+nPVhneyJIUqAY=;
        b=CeB9l+me1JZc6bPEU0ASpr5+YfjaLDkFwkQ+ZhpuECQnd4+qdCJggpET9osE2pKWPm
         GfmVR1ORH22FbblHv2b04RrMULUkdeKw/vz9L6PIRVuZY6QNB0HWbSyegKGHW6WytKkb
         W0E5rXIH8zxDM8vnbmMWXynil8M+BJ0hOSAiSeeFC3/+tr5pFA93bvTAtYg1Re6uiEjs
         3aVkSWlf4Ax1HsKPVUcG/K4yFzw7V9PuIZPv4GLfuy7q10QEVyRaKeA4CBSz26mIZfWm
         vLzvgJc8ZXS8f+NhIvmNgXo7cCisW1HSZ7hyNNZMZPmdeQ1N0WpgQi4KJZkxZqEPBE6J
         78iQ==
X-Gm-Message-State: AOAM533DnO/DR7rJCCFQa8StgyndCCIjAme9edGJa55dkbKm70+rDKqY
        xvmfA7pJaZQc9c6yYX/9BjFyA7Z6i3U1+jpK8hgHBA==
X-Google-Smtp-Source: ABdhPJzh3dTo9bSOoZb9Ltse/GAJmwvQOfeeE5WIGyrBY1gm09Sbs9aqNce9ZQU/RHtkreHhQ0Mf7DK8/2n7uFsu/mY=
X-Received: by 2002:ab0:2c1a:: with SMTP id l26mr2148024uar.6.1601324233960;
 Mon, 28 Sep 2020 13:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200918021643.2067895-1-sashal@kernel.org> <20200918021643.2067895-42-sashal@kernel.org>
In-Reply-To: <20200918021643.2067895-42-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Sep 2020 01:46:59 +0530
Message-ID: <CA+G9fYsi87yT-bEdpQ+7ca5gH_QcWHmticMSxKuCSt+SLrWj-A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.4 42/64] serial: uartps: Wait for tx_empty in
 console setup
To:     Sasha Levin <sashal@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 at 07:51, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
>
> [ Upstream commit 42e11948ddf68b9f799cad8c0ddeab0a39da33e8 ]
>
> On some platforms, the log is corrupted while console is being
> registered. It is observed that when set_termios is called, there
> are still some bytes in the FIFO to be transmitted.
>
> So, wait for tx_empty inside cdns_uart_console_setup before calling
> set_termios.
>
> Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Link: https://lore.kernel.org/r/1586413563-29125-2-git-send-email-ravitej=
a.narayanam@xilinx.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

stable rc branch 4.4 arm64 build broken.

../drivers/tty/serial/xilinx_uartps.c: In function =E2=80=98cdns_uart_conso=
le_setup=E2=80=99:
../drivers/tty/serial/xilinx_uartps.c:1170:40: error: =E2=80=98TX_TIMEOUT=
=E2=80=99
undeclared (first use in this function)
 1170 |  time_out =3D jiffies + usecs_to_jiffies(TX_TIMEOUT);
                                                                      ^~~~~=
~~~~~
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> ---
>  drivers/tty/serial/xilinx_uartps.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xili=
nx_uartps.c
> index 06efcef1b4953..5b4469098888a 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1152,6 +1152,7 @@ static int cdns_uart_console_setup(struct console *=
co, char *options)
>         int bits =3D 8;
>         int parity =3D 'n';
>         int flow =3D 'n';
> +       unsigned long time_out;
>
>         if (co->index < 0 || co->index >=3D CDNS_UART_NR_PORTS)
>                 return -EINVAL;
> @@ -1165,6 +1166,13 @@ static int cdns_uart_console_setup(struct console =
*co, char *options)
>         if (options)
>                 uart_parse_options(options, &baud, &parity, &bits, &flow)=
;
>
> +       /* Wait for tx_empty before setting up the console */
> +       time_out =3D jiffies + usecs_to_jiffies(TX_TIMEOUT);
> +
> +       while (time_before(jiffies, time_out) &&
> +              cdns_uart_tx_empty(port) !=3D TIOCSER_TEMT)
> +               cpu_relax();
> +
>         return uart_set_options(port, co, baud, parity, bits, flow);
>  }
>
> --
> 2.25.1
>

--=20
Linaro LKFT
https://lkft.linaro.org
