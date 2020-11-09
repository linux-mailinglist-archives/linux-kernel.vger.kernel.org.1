Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA9F2AB415
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgKIJ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgKIJ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:56:45 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F908C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 01:56:45 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id n5so7699837ile.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 01:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Reyf2LTkl/nZmDymc/C7yhdYxGBOvgpjf15ijhHXrXk=;
        b=h6lPXGm5aOnj3YuFHHOqJ54jB/gd4poG1bgWPgpyvt1+NfFOh6lcPqHeMzjQ5mrY/R
         roMcD+FaCTwRBOyX59DBpv/ueZZhi20x3WwIXkAmCZDcbSUt2nX3tjhN3kg47VnpDhdc
         jJgmoPlA3KUlxJ5pH0Jg9ger371DV+iH1uMkxd/s8gjxHsYws9GbIN9iiWUgvyrhqbNZ
         yuuzXK3xJOoiBcEXuWxdzums+aOvjz8Za2NJQ2bOGm3QMVMFtDAxvhZl7o+oZ2a5vNSB
         AQdesuNpbCDL2C7tRxfUBr7v+gUe2SiNFMiXJeyaMvZlE7qHRRd3pp7t0BZocUDYeU0t
         bhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Reyf2LTkl/nZmDymc/C7yhdYxGBOvgpjf15ijhHXrXk=;
        b=Lt25uvdmD5JytNUV2micmwKj3lat1SwkF5IyUuBUEJBg5bByuSy5B1EFpV77rx1YRD
         TJ89qqcA1xQehg8Xggl7jn/BYCMbYZosBhXjX8K9Mmi1OauYJcYggk21VziZM1Y0nbxt
         txR9W06xjmsT+t3pAPLD0+xmldLaMZATGUhj6eGgQicYe//kSn2ZrHxixwVVjetdG7ke
         SazdrV0fWjzBIBggyelwvdZaHaNghq2b4jeQQ3Amsm1mOfSju36pLn1sarN52QukS/8i
         f1VI0O9u5FdDR/LducAzZX36LyftU81zrLqz38r7zYllgSiotXqNi0vDG1IKFb6Wyiqq
         9CDw==
X-Gm-Message-State: AOAM532bVblfC3YlqlB/Z0KDPt0arx1l+SBLwRUaePmMCjxOX/TiFl5Y
        Iij7WlvPHiHrfEuwXxSzZ9xY1ptU5VEjgfsmsqakLA==
X-Google-Smtp-Source: ABdhPJzoXZSHKjTkIGQFt1LutvDCEx/57b7tlUf+ufClMuHEnwB4eL4Vbg/Q5gshcXTU5vx5K22p/Dnl3YB10/u8jMI=
X-Received: by 2002:a92:6f11:: with SMTP id k17mr9516216ilc.69.1604915804564;
 Mon, 09 Nov 2020 01:56:44 -0800 (PST)
MIME-Version: 1.0
References: <1604913614-19432-1-git-send-email-wenan.mao@linux.alibaba.com> <1604914417-24578-1-git-send-email-wenan.mao@linux.alibaba.com>
In-Reply-To: <1604914417-24578-1-git-send-email-wenan.mao@linux.alibaba.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 9 Nov 2020 10:56:33 +0100
Message-ID: <CANn89iKiNdtxaL_yMF6=_8=m001vXVaxvECMGbAiXTYZjfj3oQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: Update window_clamp if SOCK_RCVBUF is set
To:     Mao Wenan <wenan.mao@linux.alibaba.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 10:33 AM Mao Wenan <wenan.mao@linux.alibaba.com> wrote:
>
> When net.ipv4.tcp_syncookies=1 and syn flood is happened,
> cookie_v4_check or cookie_v6_check tries to redo what
> tcp_v4_send_synack or tcp_v6_send_synack did,
> rsk_window_clamp will be changed if SOCK_RCVBUF is set,
> which will make rcv_wscale is different, the client
> still operates with initial window scale and can overshot
> granted window, the client use the initial scale but local
> server use new scale to advertise window value, and session
> work abnormally.

What is not working exactly ?

Sending a 'big wscale' should not really matter, unless perhaps there
is a buggy stack at the remote end ?

>
> Signed-off-by: Mao Wenan <wenan.mao@linux.alibaba.com>
> ---
>  v2: fix for ipv6.
>  net/ipv4/syncookies.c | 4 ++++
>  net/ipv6/syncookies.c | 5 +++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 6ac473b..57ce317 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -427,6 +427,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>
>         /* Try to redo what tcp_v4_send_synack did. */
>         req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
> +       /* limit the window selection if the user enforce a smaller rx buffer */
> +       if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
> +           (req->rsk_window_clamp > tcp_full_space(sk) || req->rsk_window_clamp == 0))
> +               req->rsk_window_clamp = tcp_full_space(sk);

This seems not needed to me.

We call tcp_select_initial_window() with tcp_full_space(sk) passed as
the 2nd parameter.

tcp_full_space(sk) will then apply :

space = min(*window_clamp, space);

Please cook a packetdrill test to demonstrate what you are seeing ?
