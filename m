Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526E92A188A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 16:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgJaP1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 11:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgJaP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 11:27:05 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B265C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 08:27:05 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id k12so2635643uad.11
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsssXiVqnK5kDFStHInJQ/Mg9YENJ6l9cDu6hzCz+TU=;
        b=OR8mvdW88OPW8LXt7qNm0Tgjh1KLCYSrmKIbrmf2lWZMzBc0XKL20E3rG6jY8zY+zC
         YxupvNAyHov+dJTqVxZree/bkdRjE0zpBLWL/OYKrN8BAJyutNF0zXUetPf3Sw+lGF9l
         n3vqVxBWwwzSwIOd6oPywQcB0OjDnyc4ItadgRQLEcOnAkXbZlBfoHhxZilCHOXf6oe2
         XZsHlxY2A4YwzRyUKSvKP5DiMriuYCpI0L0H7T4rTvZdzYbL/9MHVT1UEF2oTjRbjsw9
         xYxrvXuFU+riPwRT3xljYyGbv2FCAFD5sT4ha96F7L59/5ekm+n7APQLKybUOnjo+T++
         5CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsssXiVqnK5kDFStHInJQ/Mg9YENJ6l9cDu6hzCz+TU=;
        b=MgQbAqs2ethjv8jungSvbpA9fdl7GkA7x2hu3nAcR4vI3LhJdiNgbIbu91Ymy7JyJE
         uG+CmInALuCfamlTOqv+u4fRltQiSkCakUqcm5F5IK3FNvLymqQTcR5Xiq6rEZCnSI5j
         d2N+v6Nns8mN5N6YJ6yl1DdvvPtyMDd5xsRq+QkdxbTg3I+NaA41r5+ydZJAbdoDiJm6
         tGiQ6jJWyjhTYacbLYhpB6MME9ydLOqIiNi/edT/1/IcGrmoHBCVTo7ZADBOlQKX9Koa
         95Ck+CqwqHdi/RTnvhyjKjVxkArvDrlnxZkmZ1YnFaJ9lSDQXWZMewHHE5T9bHacXlZc
         M7gA==
X-Gm-Message-State: AOAM532Z24JyqAjyJVCAsUW6MtiH+kx0Gjd73IWC4b+N7mqBtXnOqQGy
        EWT1BDkgkAcSdHnBJCKXk54NbEYIc94=
X-Google-Smtp-Source: ABdhPJyaAiMcMt1aqu6LTdMaAGmtMpcZ45p6A8Ll8EO0QAXB854Yl/N/FPazcgjlaW1Cpj0/S0Y0vQ==
X-Received: by 2002:ab0:200c:: with SMTP id v12mr4489214uak.53.1604158023980;
        Sat, 31 Oct 2020 08:27:03 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id b13sm1329824vsm.16.2020.10.31.08.27.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 08:27:02 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id 128so2235870vso.7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 08:27:02 -0700 (PDT)
X-Received: by 2002:a67:7704:: with SMTP id s4mr10217152vsc.51.1604158021897;
 Sat, 31 Oct 2020 08:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <Mx3BWGop6fGORN6Cpo4mHIHz2b1bb0eLxeMG8vsijnk@cp3-web-020.plabs.ch>
 <CA+FuTSdiqaZJ3HQHuEEMwKioWGKvGwZ42Oi7FpRf0hqWdZ27pQ@mail.gmail.com>
 <TSRRse4RkO_XW4DtdTkz4NeZPwzHXaPOEFU9-J4VlpLbUzlBzuhW8HYfHCfFJ1Ro6FwztEO652tbnSGOE-MjfKez1NvVPM3v3ResWtbK5Rk=@pm.me>
 <MX6AwRxaXyMi3FALeN1gpN8y4XgaktZM2MHxQMOM@cp4-web-036.plabs.ch>
In-Reply-To: <MX6AwRxaXyMi3FALeN1gpN8y4XgaktZM2MHxQMOM@cp4-web-036.plabs.ch>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 31 Oct 2020 11:26:24 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdKYVc3w9if5zB6WSWJ3M1XWNmXb-6VGJqKS0WndnPLhw@mail.gmail.com>
Message-ID: <CA+FuTSdKYVc3w9if5zB6WSWJ3M1XWNmXb-6VGJqKS0WndnPLhw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: avoid unneeded UDP L4 and fraglist GSO resegmentation
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Antoine Tenart <atenart@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> I think it is fine to reenable this again, now that UDP sockets will
> >> segment unexpected UDP GSO packets that may have looped. We previously
> >> added general software support in commit 83aa025f535f ("udp: add gso
> >> support to virtual devices"). Then reduced its scope to egress only in
> >> 8eea1ca82be9 ("gso: limit udp gso to egress-only virtual devices") to
> >> handle that edge case.
>
> Regarding bonding and teaming: I think they should also use
> NETIF_F_GSO_SOFTWARE mask, not NETIF_F_ALL_TSO, as SCTP also has
> a software fallback. This way we could also remove a separate
> advertising of NETIF_F_GSO_UDP_L4, as it will be included in the first.
>
> So, if this one:
> 1. Add NETIF_F_GSO_UDP_L4 and NETIF_F_GSO_FRAGLIST to
>    NETIF_F_GSO_SOFTWARE;
> 2. Change bonding and teaming features mask from NETIF_F_ALL_TSO |
>    NETIF_F_GSO_UDP_L4 to NETIF_F_GSO_SOFTWARE;
> 3. Check that every virtual netdev has NETIF_F_GSO_SOFTWARE _or_
>    NETIF_F_GSO_MASK in its advertising.
>
> is fine for everyone, I'll publish more appropriate and polished v2 soon.

I think we can revert 8eea1ca82be9. Except for the part where it
defines the feature in NETIF_F_GSO_ENCAP_ALL instead of
NETIF_F_GSO_SOFTWARE. That appears to have been a peculiar choice. I
can't recall exactly why I chose that. Most likely because that was
(at the time) the only macro that covered all the devices I wanted to
capture.

As for SCTP: that has the same concern that prompted that commit for
UDP: is it safe to forward those packets to the ingress path today?
