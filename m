Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A328300B77
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbhAVShk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbhAVSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:32:49 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198BFC061797
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:32:09 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id w187so3542811vsw.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V15OOPu3044pxifrQmZ60vxL6sFH8J1YsIy9BIpMctY=;
        b=EP8H3+6lWNxzPTQkxgmWZqG2xUK26EFVLfoFYL+uHEmC6PVyQOb3HxCGNdcwFLMyw7
         ogmQuEu21br3HhHwxywrNAh1kz+g8QLdGA7GIIVtyIzwPBmo8Jg8E0c80xD/kTYFuKnC
         jBdf29A4M4Wd8GG/VBkJB3n3/SCcIC5fCbzJTiZu2IMo3RPE+oueGAVc7T2IJSlDtNOk
         8ACUjwWMH9vTVhNIA/pRZNnj3gEJY7Pxwd1X5kbqXSOvfeEYxoQKOBP6u8xTnn61MGq+
         Gy9ag76f3MoBQt5DGbZ2tGuPk8dxB+9bgYpE4FAo6FlxLFUwpUYChucBLgsMJI+BU3Cg
         O9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V15OOPu3044pxifrQmZ60vxL6sFH8J1YsIy9BIpMctY=;
        b=eUj0U4KjoimbaNyDe9jKRIcgCS1gvq3gwpE7UHsVUpRs0DVc/C02tRHwmBi4aJ3G+j
         O0D60cg22w6Fyj9FBFtxC1asg2uSHfxQnhWDOmkWfEPUfjIDuZhIZrMLI422TjIAkW7E
         xjNBaGzik6MY39FRJ9GPXm8356kCe52e4QFVpa3n7TLbQr94NsO8nKmcYRcoH7THYDMf
         VUEkY4v34ouwlGOWT1kgQeKYpWAAYZTE+GEy/iZBVdGhItdDiP/waoKEzDJjZLh/sAUi
         io+JoFOZgecvNRcn0z1pBp1TOViOJjGQuF38HyvZeDR+4vjwTLfnfPiSym7y8jYa+Eqz
         YsTA==
X-Gm-Message-State: AOAM531pDvrM/JWHCekCUTghSah3tSz4Md5AxGHdqElPJm5zXkONLeFe
        SIchArz8Qf/S8YbPzUmVzAghxkyfu10=
X-Google-Smtp-Source: ABdhPJxODUGcwIa7V05GCkvkc4B2zsLXFgfW/A246z0aq4ciBlERaKBM3OmGlbJcFyHaWr0VgaV2ow==
X-Received: by 2002:a05:6102:310d:: with SMTP id e13mr2287169vsh.13.1611340328083;
        Fri, 22 Jan 2021 10:32:08 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id c1sm188686vkb.56.2021.01.22.10.32.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:32:05 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id p2so2141562uac.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:32:04 -0800 (PST)
X-Received: by 2002:ab0:1663:: with SMTP id l32mr2590984uae.141.1611340323985;
 Fri, 22 Jan 2021 10:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20210122181909.36340-1-alobakin@pm.me> <20210122181909.36340-3-alobakin@pm.me>
In-Reply-To: <20210122181909.36340-3-alobakin@pm.me>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 22 Jan 2021 13:31:27 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdHH9DbSPvVVZ3xU6gv7WXaEWDXUGv_Jq25uWBNnih=YQ@mail.gmail.com>
Message-ID: <CA+FuTSdHH9DbSPvVVZ3xU6gv7WXaEWDXUGv_Jq25uWBNnih=YQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 2/2] udp: allow forwarding of plain
 (non-fraglisted) UDP GRO packets
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Antoine Tenart <atenart@kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Andrew Lunn <andrew@lunn.ch>,
        Meir Lichtinger <meirl@mellanox.com>,
        Aya Levin <ayal@mellanox.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 1:20 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> Commit 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.") actually
> not only added a support for fraglisted UDP GRO, but also tweaked
> some logics the way that non-fraglisted UDP GRO started to work for
> forwarding too.
> Commit 2e4ef10f5850 ("net: add GSO UDP L4 and GSO fraglists to the
> list of software-backed types") added GSO UDP L4 to the list of
> software GSO to allow virtual netdevs to forward them as is up to
> the real drivers.
>
> Tests showed that currently forwarding and NATing of plain UDP GRO
> packets are performed fully correctly, regardless if the target
> netdevice has a support for hardware/driver GSO UDP L4 or not.
> Add the last element and allow to form plain UDP GRO packets if
> we are on forwarding path, and the new NETIF_F_GRO_UDP_FWD is
> enabled on a receiving netdevice.
>
> If both NETIF_F_GRO_FRAGLIST and NETIF_F_GRO_UDP_FWD are set,
> fraglisted GRO takes precedence. This keeps the current behaviour
> and is generally more optimal for now, as the number of NICs with
> hardware USO offload is relatively small.
>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Acked-by: Willem de Bruijn <willemb@google.com>
