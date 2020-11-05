Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FAD2A76AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 05:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbgKEEwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 23:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731609AbgKEEwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 23:52:14 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2533DC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 20:52:14 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id p10so258274ile.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 20:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFKnx/vpZwo9U/6MPDhCzbjPU6Vx1O0lBliYS2CeHn4=;
        b=QXWnLjhfdNunSpS4ejd1MnneScMJz/j5iSbKnduG62upL58nWyBexHnlAn3XsnrS9W
         sN8pa5y834luUu/QEpApzyqTuWcoyh6kPFXhLCaTigaZHagRt4jgfSIwJ4a0qh7e632r
         2H2zAG+VhoAoMQs87oYPtuFGXhzmH7YnftidaH7Q/XtzCWamL4m48cqWPWQPj9AMPbQi
         R+1toM2wEjP7eJaplhGWJ6CbeTA5xxBTncpZoH5lH7Fl3zdZ8n8zITcFjpT+eGY7eF+d
         cajccXK7E2JtTsFQt99EWv0EVLqv2jWufMY/41rvI6e08dj4SyHXao5AXKqcL8/hshba
         wGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFKnx/vpZwo9U/6MPDhCzbjPU6Vx1O0lBliYS2CeHn4=;
        b=mI+Rw018oH2sM2NR7e2+UMkRE4YB51kGSxRRgQc736Dz8qaeWQAV39xAnN0Mgwoy6A
         KIguIgVY5VKhryIG9XY6merak8nSW49MyJDvm3EL1kdpL3B0P1JSkU7IECyNm0ftNOIl
         0goLDFM1uPWiDQxcblivoPHjz20ulY5Wl85ChLLP6bqmY0mU0LLcCJxGJxLkF6399hKf
         j7B0LMTA7unxybtHcfukSNklLCrQ2axPytAycS6qnhgUvSyPgzi+kWSSfioQbAB5IAWg
         bMhevTH02qt/INQcUu1FVm6i6iipjNGj78Kxa4Hd4M4VzePDKQgJEvRE7vaMvid4E7rQ
         QM/g==
X-Gm-Message-State: AOAM533oTApMqgcC3KJse/AK4KSiy+Kn+akjsIHURZwJT55hEQPlVMOt
        vIBT7HuxPVxi8+QQaUyNjusTDFOiBd8Yq8BmiGaSFw==
X-Google-Smtp-Source: ABdhPJz1SWWD5W+3pRNN441tb9Wq4qGpIBbin32Bf9e9S1YzVmfQZT4mO5VQPrcHJzdSuYAHBQGsyLCwYUJWrpjdpNA=
X-Received: by 2002:a92:d081:: with SMTP id h1mr601565ilh.187.1604551933340;
 Wed, 04 Nov 2020 20:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20200909062613.18604-1-lina.wang@mediatek.com> <20200915073006.GR20687@gauss3.secunet.de>
In-Reply-To: <20200915073006.GR20687@gauss3.secunet.de>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Thu, 5 Nov 2020 13:52:01 +0900
Message-ID: <CAKD1Yr1VsueZWUtCL4iMWLhnADypUOtDK=dgqM2Y2HDvXc77iw@mail.gmail.com>
Subject: Re: [PATCH] xfrm:fragmented ipv4 tunnel packets in inner interface
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     mtk81216 <lina.wang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux NetDev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Greg Kroah-Hartman <gregkh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 4:30 PM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
> > In esp's tunnel mode,if inner interface is ipv4,outer is ipv4,one big
> > packet which travels through tunnel will be fragmented with outer
> > interface's mtu,peer server will remove tunnelled esp header and assemble
> > them in big packet.After forwarding such packet to next endpoint,it will
> > be dropped because of exceeding mtu or be returned ICMP(packet-too-big).
>
> What is the exact case where packets are dropped? Given that the packet
> was fragmented (and reassembled), I'd assume the DF bit was not set. So
> every router along the path is allowed to fragment again if needed.

In general, isn't it just suboptimal to rely on fragmentation if the
sender already knows the packet is too big? That's why we have things
like path MTU discovery (RFC 1191). Fragmentation is generally
expensive, increases the chance of packet loss, and has historically
caused lots of security vulnerabilities. Also, in real world networks,
fragments sometimes just don't work, either because intermediate
routers don't fragment, or because firewalls drop the fragments due to
security reasons.

While it's possible in theory to ask these operators to configure
their routers to fragment packets, that may not result in the network
being fixed, due to hardware constraints, security policy or other
reasons. Those operators may also be in a position to place
requirements on devices that have to use their network. If the Linux
stack does not work as is on these networks, then those devices will
have to meet those requirements by making out-of-tree changes. It
would be good to avoid that if there's a better solution (e.g., make
this configurable via sysctl).
