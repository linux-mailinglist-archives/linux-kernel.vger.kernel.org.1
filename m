Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728CE2ABECE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbgKIOgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgKIOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:36:53 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92F5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 06:36:52 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id f7so5056004vsh.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 06:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xDniQAvxFLBjIKTPYpnf40KKSY2vMSiv1LR/tBJSqcA=;
        b=LxF1L+qGOIsxg05Lh0AzTGP5Iwb+FRJjDr/EMmjoNpyVVkoZAK0uPsRHh/wau4UHyD
         xh2hlTuIE0nsNZz9H+gMOuMzCX6gEHNOwVtmZZOo7wMGB8sPHTGPpaY1s0Y5TJ48nRWx
         lINJc8eu3GQFZBbrP/2MbKJgiFRoWYnrgOd0xb1B4no4COrC5vQiuj4bxlstYDKdMLkk
         Zp/0j7JV5Bg0FEsvyCQrkL/wM+Y7As52L6u9wKkSeIPdQ+oRw6cD/CNWA8ouiqSODa4a
         WilzHKCrQyEs4yPCINqM+NEE116rmHFQiJPxEd9pd4xyahqi+k8AnC+1He5l4QT/6tnJ
         I6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDniQAvxFLBjIKTPYpnf40KKSY2vMSiv1LR/tBJSqcA=;
        b=m6fh8rURQcxLfPwlkxmHAgMbKel7h5TFcns126wVIl4A9ZOjGLRQyqoMz9T8q5G049
         +3AvHPxzmgYPVRDpWFtXAzWw0BYI7Z/ges9axV96+SJo9VJdX4F+kuDjZEn898QCRZnW
         GG/KwH6s57+oUtCu2zJlmqxzQWnf4ZcubG7clH0d+N11aUt83ZTNnmtfjztaEsdTMdlv
         LoX4lXf5Jl+KnadUuMOqEnuMQNrlgKvlr0GIqNwWEcI6Y1RAiTCjk8fvVvn5pMvEN8KM
         W6P6XkrQqJQ7VPk9kK2vI8/yZkd19kF6sJ254+SVqPfwi4PQa0YJMLhBVOTADjVrb+sn
         WWuQ==
X-Gm-Message-State: AOAM531MiIAJYgXai3wzeYaAaOITPhMcOYkHRm5FGELR5UnILPgvuym9
        VZGnnadXP4Ua46PVzo6m3zp7lOu8Kqk=
X-Google-Smtp-Source: ABdhPJx456VlsGGhMLgUwIzQtCFzU+/sL1ihKEqdOyEYs3o3lB9jGdfRASBGPbYiwd7O5j54VSQZtQ==
X-Received: by 2002:a05:6102:309a:: with SMTP id l26mr7993654vsb.4.1604932611331;
        Mon, 09 Nov 2020 06:36:51 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id k6sm1270883uaq.12.2020.11.09.06.36.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 06:36:50 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id q68so2835211uaq.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 06:36:50 -0800 (PST)
X-Received: by 2002:a9f:2067:: with SMTP id 94mr6343749uam.141.1604932609475;
 Mon, 09 Nov 2020 06:36:49 -0800 (PST)
MIME-Version: 1.0
References: <YazU6GEzBdpyZMDMwJirxDX7B4sualpDG68ADZYvJI@cp4-web-034.plabs.ch>
In-Reply-To: <YazU6GEzBdpyZMDMwJirxDX7B4sualpDG68ADZYvJI@cp4-web-034.plabs.ch>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 9 Nov 2020 09:36:12 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfokZNJv2g2mCK284UTj7nN_-qXei42J4QWt7YniSrKog@mail.gmail.com>
Message-ID: <CA+FuTSfokZNJv2g2mCK284UTj7nN_-qXei42J4QWt7YniSrKog@mail.gmail.com>
Subject: Re: [PATCH net] net: udp: fix Fast/frag0 UDP GRO
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 7, 2020 at 8:11 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> While testing UDP GSO fraglists forwarding through driver that uses
> Fast GRO (via napi_gro_frags()), I was observing lots of out-of-order
> iperf packets:
>
> [ ID] Interval           Transfer     Bitrate         Jitter
> [SUM]  0.0-40.0 sec  12106 datagrams received out-of-order
>
> Simple switch to napi_gro_receive() any other method without frag0
> shortcut completely resolved them.
>
> I've found that UDP GRO uses udp_hdr(skb) in its .gro_receive()
> callback. While it's probably OK for non-frag0 paths (when all
> headers or even the entire frame are already in skb->data), this
> inline points to junk when using Fast GRO (napi_gro_frags() or
> napi_gro_receive() with only Ethernet header in skb->data and all
> the rest in shinfo->frags) and breaks GRO packet compilation and
> the packet flow itself.
> To support both modes, skb_gro_header_fast() + skb_gro_header_slow()
> are typically used. UDP even has an inline helper that makes use of
> them, udp_gro_udphdr(). Use that instead of troublemaking udp_hdr()
> to get rid of the out-of-order delivers.
>
> Present since the introduction of plain UDP GRO in 5.0-rc1.
>
> Fixes: e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.")
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  net/ipv4/udp_offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index e67a66fbf27b..13740e9fe6ec 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -366,7 +366,7 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
>  static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
>                                                struct sk_buff *skb)
>  {
> -       struct udphdr *uh = udp_hdr(skb);
> +       struct udphdr *uh = udp_gro_udphdr(skb);
>         struct sk_buff *pp = NULL;
>         struct udphdr *uh2;
>         struct sk_buff *p;

Good catch. skb_gro_header_slow may fail and return NULL. Need to
check that before dereferencing uh below in

        /* requires non zero csum, for symmetry with GSO */
        if (!uh->check) {
                NAPI_GRO_CB(skb)->flush = 1;
                return NULL;
        }
