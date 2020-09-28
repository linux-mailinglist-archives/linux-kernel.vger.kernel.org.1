Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DA227AA32
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgI1JGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgI1JGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:06:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935AAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:06:14 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id a2so175477otr.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLMEwo1GTL8rxXudG0GEtZJfPOiss5JdOgm8YTgj2ew=;
        b=CuyOduRhEkNZODuCVzegsNXw2bIgsJ/2DykzPHgIqv0B1FArA+4Lxc3NeipV062q/H
         GIoxRScktP5IDFGaNlu/6riiJ2zJ4MlUQqqTYVUx8OhazSEjtFnbLowDUf54dXhw8C7/
         6R+tL7c1tsD/hykM3Bo5VCGy61woKjidXTSMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLMEwo1GTL8rxXudG0GEtZJfPOiss5JdOgm8YTgj2ew=;
        b=jn/K6xzz6FMY56xjcNT2QB7Shp944kkeRr6UrbCscLNhmTn5qUvGqhY+ZKzjrpVtMx
         nSXbyltg3sirGP6SRu/c2POpKXpFUIVzqTletQGHFIsAlb3SWupCGbK8k6MtAIN1snwk
         KwodG/kxKKDqdIyq7zJqRO+zt6sFvchFMqEUH/nlbx+6xWvk5ZEeBjz6/5+7vddj0CRW
         lwRydSTBUBbweYD/8262usHBpsipBP3SwL2PhH6T9NQF8ocMiscW6ZqZ1uzIC+MZEGaC
         9toOXd5eKLL7SU68pTCgCaDU7LccbjksFAHj8UkUoeg1nn1UlN0fjii72E31QcrPgdkT
         b4Yw==
X-Gm-Message-State: AOAM5335t7jjD/AVay631IVJ4SyC5rOPwS1MYcpFaDlBz5szNJganxoX
        83DNXVP4aiPLlhIVnvSF6R4WecbzHJuUOAP4cwUFSA==
X-Google-Smtp-Source: ABdhPJxs/FZB02Ft8ZmDTuS0bYLgBEPkG0xHeAkww2lbFRxtnPCC8MW6Nr++yZFeBJr/uUIJk4Ekbp6bKiCXxI/Gyrs=
X-Received: by 2002:a05:6830:12c7:: with SMTP id a7mr308019otq.334.1601283973942;
 Mon, 28 Sep 2020 02:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200925095630.49207-1-lmb@cloudflare.com> <20200925095630.49207-2-lmb@cloudflare.com>
 <20200925215359.l5lbicqdyx44spoc@kafai-mbp>
In-Reply-To: <20200925215359.l5lbicqdyx44spoc@kafai-mbp>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 28 Sep 2020 10:06:02 +0100
Message-ID: <CACAyw9-iXY5GqpLOOHkkDMvhPnES_1HMR8PMz0K2PR8wfbHqew@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: sockmap: enable map_update_elem from bpf_iter
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 at 22:54, Martin KaFai Lau <kafai@fb.com> wrote:
>
> > +     if (unlikely(!sk))
> sk_fullsock(sk) test is also needed.
>
> > +             return -EINVAL;
>
> > +
> >       if (!sock_map_sk_is_suitable(sk))
> sk->sk_type is used in sock_map_sk_is_suitable().
> sk_type is not in sock_common.

Oh my, thanks!

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
