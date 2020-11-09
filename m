Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061AD2ABC64
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbgKINg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732617AbgKINgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:36:46 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DAFC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 05:36:45 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id p10so8278857ile.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 05:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hfk8kyBYhxKkGRwHn7XHXw6Umn/AY2R8En7BdB9972U=;
        b=ImIKuA5EjY+A/mCGf8NaL8bRLp5GQBqFh3g2zT6h6YPO2Y0+DNn3GHC7c/IKKSdNHB
         +d5uFobFp1dCIDfmCETsiXWwHe59/Wcd8SKUt7BRv+PT5gf1AgLstdj+Az4/v5uyGj1j
         P1jqU9N762ysbX8ARls8gBLlEG4YCjn0IAxf8q1pWZhlyJRYrXXG+46Mk6YFpDmTkr8f
         c2UcbC805dDF6OXo5kVXBet/vFq08RzoPGNGFeIhdRpiJVTRDBIg5rfQwcQ2AOhJGta8
         tzPOaAwBktRETObKK2bjoKe99CqrBiJ63pCOicpENTN6OK+WUZNt+4MWMtCSfHsr2s2a
         l86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hfk8kyBYhxKkGRwHn7XHXw6Umn/AY2R8En7BdB9972U=;
        b=OeAXsMmxDV9afFfe0TwiJ6FW0XpGPKatSxeErVYcn3PbrgaQHpn1zFxqNSmDZueM81
         8p8DtT7xTD9LQR4pcrd75qBT5EkyrjDiGqwyXngTB8rBstVHDLwfU+3897binJQBrJDD
         UrBqL2Y1/mp6wBvyeGvad0Ie1zejOfRTsneCZLYW/2Df977U0KLwYQXzflZ37Sd1BsM/
         zOlI3Kd83Q9sLZZnuLaQxqX/VOXO7QLlwzAyX2l0R2np+3XpqooYBnD5O8ybHt0syYN5
         8DtP5Sqt/RmiIRHDOqITzvdEKKM9w4eSECazNZDJGEGQuz10sPrk5rnlnZaiqCrgMR0m
         fqIQ==
X-Gm-Message-State: AOAM533pbM6YfvT1TARh6kSM1v7qH7v1NFiL62p4DYSguVwfC3mqhlyE
        d++9eiwGOpYFM3mCA0UjFT1rWZqW1aiO9o3+ycoKuQ==
X-Google-Smtp-Source: ABdhPJyjwCNqDorGY2SsoiKJYgyaM1r1ZLZlyUAvFGznUs/LPEKgmw+MSfJ9hjXYOj4uGpUwD/Plpul/I/r30FT6iC8=
X-Received: by 2002:a92:6f11:: with SMTP id k17mr10114518ilc.69.1604929004839;
 Mon, 09 Nov 2020 05:36:44 -0800 (PST)
MIME-Version: 1.0
References: <5fa93ef0.1c69fb81.bff98.2afc@mx.google.com>
In-Reply-To: <5fa93ef0.1c69fb81.bff98.2afc@mx.google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 9 Nov 2020 14:36:33 +0100
Message-ID: <CANn89iJNYyON8khtQYzZi2LdV1ZSopGfnXB1ev9bZ2cDUdekHw@mail.gmail.com>
Subject: Re: [PATCH] net: tcp: ratelimit warnings in tcp_recvmsg
To:     menglong8.dong@gmail.com
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <dong.menglong@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 2:07 PM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <dong.menglong@zte.com.cn>
>
> 'before(*seq, TCP_SKB_CB(skb)->seq) == true' means that one or more
> skbs are lost somehow. Once this happen, it seems that it will
> never recover automatically. As a result, a warning will be printed
> and a '-EAGAIN' will be returned in non-block mode.
>
> As a general suituation, users call 'poll' on a socket and then receive
> skbs with 'recv' in non-block mode. This mode will make every
> arriving skb of the socket trigger a warning. Plenty of skbs will cause
> high rate of kernel log.
>
> Besides, WARN is for indicating kernel bugs only and should not be
> user-triggable. Replace it with 'net_warn_ratelimited' here.
>
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>

I do not think this patch is useful. That is simply code churn.

Can you trigger the WARN() in the latest upstream version ?
If yes this is a serious bug that needs urgent attention.

Make sure you have backported all needed fixes into your kernel, if
you get this warning on a non pristine kernel.
