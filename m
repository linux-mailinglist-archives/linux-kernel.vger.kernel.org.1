Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37AE2C6A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbgK0QvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbgK0QvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:51:15 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1F6C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:51:14 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id s135so1272592vkh.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X7jtzNs0NbYHlVVmlLsP7b2/FUYkvw9tqQfhdc87EyE=;
        b=r7N5PALFBkMVMurrPrTyIWvenPdAmItRtcw/fq7VdG/Lmay5Gng1oWK0qXANy6S+tt
         NCHXnAci/9v1VUarKydxLMEOj7yjlJ8X+EdUoZvLCg8bKqjyvrrfbJ3gKdt09gu1LWbf
         s2O04IakYss1f17gOqG0NgUvL3lhSXMbKSmCd/8nPD82Ue3fvgcUmHiZ9cK9vGgi2LYV
         Ca68HvMxWcglGqLXp8mCNjVqoxMa4SnJ33UD84nS4AyTlkP8Yp/PW2T+IY6j6Bi1w9R0
         Zwg/549g3eVRVfL+X+xY1iz2odmNfd6W44KcyMlEWKItU+42UkW1rl0WxlhhcPLfthwt
         nK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X7jtzNs0NbYHlVVmlLsP7b2/FUYkvw9tqQfhdc87EyE=;
        b=EBtPoedYNEalXXds4Wvn20OAeVD0AkdHP8kFfUGQDCzp6lXib8kQJULyCcKuCumlJX
         e+soF1lPAlURQg/GGKgKPCKUSkwTGTZro5Lu2n6dQ3F+bzjVnF9Xrc715Qt1vtJSkI1Z
         rJyuApbQXEoGI7z7PFI57Dx1uEmIPXu8l0E4x86ed5gnMieGdj2HeoH4VzW6mS2CvFfM
         mZN8OH7/asP09M+l7QQYP9wrjzz+lKCr8/GvhHUlWvvqA1IudhD1OVRVwssnVB92b2xZ
         oyi27Vc80E9Mp5G0uKkrov9BCxrhBPSbyKMH/RkQjvMsfKw/nhRQJvDihY+ddcJ1i1xw
         1cjQ==
X-Gm-Message-State: AOAM533ANEctwwjE3NMYhBCshaxDppoCfIokFTwOubEagm2Sz6ieYwsz
        Jq7MRUHVCVL+EhXnRB+gANXEHuXRFEE=
X-Google-Smtp-Source: ABdhPJz0XwWbvkG4FO+A8fdtRwupeCPWCN/chQ//MDU/W4W4i7jpP/pcpt0eli0tymjMakbI+LqetA==
X-Received: by 2002:ac5:cce1:: with SMTP id k1mr6895240vkn.11.1606495873416;
        Fri, 27 Nov 2020 08:51:13 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id h79sm573463vka.50.2020.11.27.08.51.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 08:51:12 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id j140so2858969vsd.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:51:12 -0800 (PST)
X-Received: by 2002:a05:6102:1173:: with SMTP id k19mr6628798vsg.51.1606495871475;
 Fri, 27 Nov 2020 08:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20201125173436.1894624-1-elver@google.com> <20201125124313.593fc2b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CANpmjNP_=Awx0-eZisMXzgXxKqf7hcrZYCYzFXuebPcwZtkoLw@mail.gmail.com>
 <CAF=yD-JtRUjmy+12kTL=YY8Cfi_c92GVbHZ647smWmasLYiNMg@mail.gmail.com> <CANpmjNO8H9OJDTcKhg4PRVEV04Gxnb56mJY2cB9j4cH+4nznhQ@mail.gmail.com>
In-Reply-To: <CANpmjNO8H9OJDTcKhg4PRVEV04Gxnb56mJY2cB9j4cH+4nznhQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 27 Nov 2020 11:50:34 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfCSZFC2Bz5WpnaoU__jrd8sSwsDqN1TNar3yeGNbVeQQ@mail.gmail.com>
Message-ID: <CA+FuTSfCSZFC2Bz5WpnaoU__jrd8sSwsDqN1TNar3yeGNbVeQQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: switch to storing KCOV handle directly in sk_buff
To:     Marco Elver <elver@google.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Aleksandr Nogikh <a.nogikh@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ido Schimmel <idosch@idosch.org>,
        Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 7:26 AM Marco Elver <elver@google.com> wrote:
>
> On Thu, 26 Nov 2020 at 17:35, Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > On Thu, Nov 26, 2020 at 3:19 AM Marco Elver <elver@google.com> wrote:
> [...]
> > > Will send v2.
> >
> > Does it make more sense to revert the patch that added the extensions
> > and the follow-on fixes and add a separate new patch instead?
>
> That doesn't work, because then we'll end up with a build-broken
> commit in between the reverts and the new version, because mac80211
> uses skb_get_kcov_handle().
>
> > If adding a new field to the skb, even if only in debug builds,
> > please check with pahole how it affects struct layout if you
> > haven't yet.
>
> Without KCOV:
>
>         /* size: 224, cachelines: 4, members: 72 */
>         /* sum members: 217, holes: 1, sum holes: 2 */
>         /* sum bitfield members: 36 bits, bit holes: 2, sum bit holes: 4 bits */
>         /* forced alignments: 2 */
>         /* last cacheline: 32 bytes */
>
> With KCOV:
>
>         /* size: 232, cachelines: 4, members: 73 */
>         /* sum members: 225, holes: 1, sum holes: 2 */
>         /* sum bitfield members: 36 bits, bit holes: 2, sum bit holes: 4 bits */
>         /* forced alignments: 2 */
>         /* last cacheline: 40 bytes */

Thanks. defconfig leaves some symbols disabled, but manually enabling
them just fills a hole, so 232 is indeed the worst case allocation.

I recall a firm edict against growing skb, but I don't know of a
hard limit at exactly 224.

There is a limit at 2048 - sizeof(struct skb_shared_data) == 1728B
when using pages for two ETH_FRAME_LEN (1514) allocations.

This would leave 1728 - 1514 == 214B if also squeezing the skb itself
in with the same allocation.

But I have no idea if this is used anywhere. Certainly have no example
ready. And as you show, the previous default already is at 224.

If no one else knows of a hard limit at 224 or below, I suppose the
next technical limit is just 256 for kmem cache purposes.

My understanding was that skb_extensions was supposed to solve this
problem of extending the skb without growing the main structure. Not
for this patch, but I wonder if we can resolve the issues exposed here
and make usable in more conditions.
