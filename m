Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DFD28B987
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgJLOB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731203AbgJLNib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:38:31 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417A6C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:38:29 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id l6so8264036vsr.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qoV1BfVdJZsinq1maVaibHxEqbflhmKT48S5ZU728Qg=;
        b=tcYUB4C2mYNzgj9n3WDo4iGUsBORwa7h6zIm0OOVB4fwMOctooJ9mJqC8BtdPyFwOm
         xBWnw3tvq0FoOgptFSalZkv5U92OpM5O1sddNa/grvI9ICtJl9jzpCkZo7D8d2Wkeb9U
         KtU3NR/FMBMDN76/2JaIv+BZyYzsexaodydLqhkVrex9df59GtlGi7KtaFO7ut7bg2g4
         E68NhztWMBhL37VLiOtiqa2aIRZJxAaPL3RKBDBaHWZTUL/fHjZXMqmuUgiKByQTjHi0
         PuBS/tSEvM0NvyYkMON6TObgoVPU2KTKzljetrJob90XRyZ5a99yBbdPnn1y7a1cBrfA
         71DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qoV1BfVdJZsinq1maVaibHxEqbflhmKT48S5ZU728Qg=;
        b=LPJ/r+T0thEDstL2u/UUUqiAmprbAhCVESmNPOCipB7mpiGB8IcQkGzk0s67J0dwNS
         WBosnquomIZ3Rc9tGUGJr8cPHJBNFQPVUHvxRCl3Kl083fZwwlhKLlncXoRsXgH/j6+0
         NRijrg/BkPVh4esA21Wc1ViVIgXQy20aXnMWxbXZZU1z6jG6QBnjVpO9o9jJRJIz6Zrh
         bQNXto4p1hDCtHnoIecEck+TosWre0KaScQvvZPZsXuH2Rplp4GLUbktT9mOy/98ZAEc
         3OY0FspUphGGvx8zTSvfgwU+KXGBzZ5sg82ryNrID+tBs3PFQS7IuPS54E+iw07AQ9Af
         +9AA==
X-Gm-Message-State: AOAM5322EQlH29rVA9wSPqq0u/Q8eu5pBkx8g9R1++Nnas1Za2TMJUi1
        RgRrZgoqxWYiTzqcO+cy+5BttUfmUFk=
X-Google-Smtp-Source: ABdhPJxkEqM+Yhc/T2gQ65qiNxPZJ/VIS1Fu3Z2nqv1sSGQ16E4HpnMJypGPSVJJyhY1ogSB7bkRsg==
X-Received: by 2002:a05:6102:2406:: with SMTP id j6mr6580315vsi.49.1602509908125;
        Mon, 12 Oct 2020 06:38:28 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id t6sm2209307vke.28.2020.10.12.06.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 06:38:27 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id l23so2774110vkm.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:38:26 -0700 (PDT)
X-Received: by 2002:a1f:6dc2:: with SMTP id i185mr13578365vkc.3.1602509906266;
 Mon, 12 Oct 2020 06:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201012093542.15504-1-ceggers@arri.de>
In-Reply-To: <20201012093542.15504-1-ceggers@arri.de>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 12 Oct 2020 09:37:49 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfkBHtKqjppMmqudj9GwZBidSqvOP6WCzoxLGihqiz5Qw@mail.gmail.com>
Message-ID: <CA+FuTSfkBHtKqjppMmqudj9GwZBidSqvOP6WCzoxLGihqiz5Qw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] socket: fix option SO_TIMESTAMPING_NEW
To:     Christian Eggers <ceggers@arri.de>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 5:36 AM Christian Eggers <ceggers@arri.de> wrote:
>
> The comparison of optname with SO_TIMESTAMPING_NEW is wrong way around,
> so SOCK_TSTAMP_NEW will first be set and than reset again. Additionally
> move it out of the test for SOF_TIMESTAMPING_RX_SOFTWARE as this seems
> unrelated.
>
> This problem happens on 32 bit platforms were the libc has already
> switched to struct timespec64 (from SO_TIMExxx_OLD to SO_TIMExxx_NEW
> socket options). ptp4l complains with "missing timestamp on transmitted
> peer delay request" because the wrong format is received (and
> discarded).
>
> Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> Reviewed-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Reviewed-by: Deepa Dinamani <deepa.kernel@gmail.com>

We have not yet reviewed this second patch. Please do not add such
tags on behalf of other people.

That said, I now have and do agree with the change, so

Acked-by: Willem de Bruijn <willemb@google.com>

> ---
> v2:
> -----
> - integrated proposal from Willem de Bruijn
> - added Reviewed-by: from Willem and Deepa
>
>
> On Saturday, 10 October 2020, 02:23:10 CEST, Willem de Bruijn wrote:
> > This suggested fix still sets and clears the flag if calling
> > SO_TIMESTAMPING_NEW to disable timestamping.
> where is it cleared?
>
> > Instead, how about
> >
> >         case SO_TIMESTAMPING_NEW:
> > -               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> >                 fallthrough;
> >         case SO_TIMESTAMPING_OLD:
> > [..]
> > +               sock_valbool_flag(sk, SOCK_TSTAMP_NEW,
> > +                                 optname == SO_TIMESTAMPING_NEW);
> > +
> using you version looks clearer
>
> >                 if (val & SOF_TIMESTAMPING_OPT_ID &&
> >
> I would like to keep this below the "ret = -FOO; break" statements. IMHO the
> setsockopt() call should either completely fail or succeed.

Agreed.


>  net/core/sock.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 34a8d12e38d7..669cf9b8bb44 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -994,8 +994,6 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
>                 __sock_set_timestamps(sk, valbool, true, true);
>                 break;
>         case SO_TIMESTAMPING_NEW:
> -               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> -               fallthrough;
>         case SO_TIMESTAMPING_OLD:
>                 if (val & ~SOF_TIMESTAMPING_MASK) {
>                         ret = -EINVAL;
> @@ -1024,16 +1022,14 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
>                 }
>
>                 sk->sk_tsflags = val;
> +               sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname == SO_TIMESTAMPING_NEW);
> +
>                 if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
>                         sock_enable_timestamp(sk,
>                                               SOCK_TIMESTAMPING_RX_SOFTWARE);
> -               else {
> -                       if (optname == SO_TIMESTAMPING_NEW)
> -                               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> -
> +               else
>                         sock_disable_timestamp(sk,
>                                                (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE));
> -               }
>                 break;
>
>         case SO_RCVLOWAT:
> --
> Christian Eggers
> Embedded software developer
>
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
> Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
> Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
> Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler
>
