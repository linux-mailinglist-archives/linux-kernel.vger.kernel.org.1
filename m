Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377D02AC1D9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbgKIRJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731042AbgKIRJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:09:30 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F60C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 09:09:29 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id y73so5359367vsc.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QvIn+60yZ2g+goNrF89dTWG7tHbqd9bjnmQMUGC2tLU=;
        b=YpTfEjmTXWyjdnCRbF1zQbmyqT2hKUct9afPYfFH5oW3/DcnggcPMyCpWRmENya1pD
         V+cg6e1urqOJej0La9XFWK3KU2ek+mAJ36QHPnKd9i8AZ8Ks9N4EULj9y1UYAUX9aYOf
         69cdOZ363g1IY+CmsIDnSLDj8ABv7dj4/YIDS6yW9/sLf+Nf8JNtAihUqQvr/U4F9mCf
         wwicQBoAqPEb52v4qcInalAXBo8tluBhXKOpEe6dLp5X3tKyYU1fw+a5TvRqmXkwDzsE
         jpJ13f6KwWq5agsBctGj3oGnzqrWqJh8M5y8zFlb/8vmPFE5trlE8RLDCinZ7V9yrfmZ
         6PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QvIn+60yZ2g+goNrF89dTWG7tHbqd9bjnmQMUGC2tLU=;
        b=icGXdAKw/beJi5257JhIoK8TLaBnsm3nQD5D6NWG22CeFY4QvXPsYfN2PNfSlZhPhv
         2Ik4HvmDEp/iGf3A88Ju0TBaVEBiEfcAuT4+OzbbZHdKn2kEYLD9cVdYJ/leXRU4EsCg
         0Gn9A/WMVzCimWOgaPC6fnBiM8/PFi/jKnm5iAK/uSRiHaFE6R3L+nehzYMcm87ZghF1
         2mmRrLAsVN86XZ3db5JBEfFxw173KyeUpRF0XuXItnZABcXoFrnVEKWQ40HIewDeMoJW
         mcXWVIw2hyRPKP/BAf4fpQaHSvlwm/7ga/EF/2fW0Rs5UJi0Vaza5O/C4Xj164qOeyJ/
         kE/A==
X-Gm-Message-State: AOAM532BxA6fsTanm4SXGB9gL9G/bbm1ZQiFZIyULX75Co/+bt0zhphL
        G71WmvLWig6xPVoPQaVdgJ5rqfHwErI=
X-Google-Smtp-Source: ABdhPJyOUaf4qxWE4SZP90h3eriCdjWcvM+NHh0/tWNGLHIcffn7kf0yEmpg//dEclEAhkr+66GFIA==
X-Received: by 2002:a05:6102:22d0:: with SMTP id a16mr8708307vsh.23.1604941768169;
        Mon, 09 Nov 2020 09:09:28 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id m205sm1362768vkm.9.2020.11.09.09.09.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 09:09:26 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id p12so3012085uam.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:09:26 -0800 (PST)
X-Received: by 2002:a9f:28a7:: with SMTP id d36mr7956189uad.37.1604941766063;
 Mon, 09 Nov 2020 09:09:26 -0800 (PST)
MIME-Version: 1.0
References: <0eaG8xtbtKY1dEKCTKUBubGiC9QawGgB3tVZtNqVdY@cp4-web-030.plabs.ch>
In-Reply-To: <0eaG8xtbtKY1dEKCTKUBubGiC9QawGgB3tVZtNqVdY@cp4-web-030.plabs.ch>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 9 Nov 2020 12:08:49 -0500
X-Gmail-Original-Message-ID: <CA+FuTScq+etRKkFeo9r04dW-1SkZjiJ8JKhxnAjEkpXZLgDY=Q@mail.gmail.com>
Message-ID: <CA+FuTScq+etRKkFeo9r04dW-1SkZjiJ8JKhxnAjEkpXZLgDY=Q@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: udp: fix Fast/frag0 UDP GRO
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

On Mon, Nov 9, 2020 at 11:57 AM Alexander Lobakin <alobakin@pm.me> wrote:
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
> Since v1 [1]:
>  - added a NULL pointer check for "uh" as suggested by Willem.
>
> [1] https://lore.kernel.org/netdev/YazU6GEzBdpyZMDMwJirxDX7B4sualpDG68ADZYvJI@cp4-web-034.plabs.ch
>
> Fixes: e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.")
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Acked-by: Willem de Bruijn <willemb@google.com>

Thanks
