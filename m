Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3D2A1831
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 15:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgJaOde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 10:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgJaOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 10:33:33 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975DBC0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 07:33:33 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id t8so2196343vsr.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSmSd5/7EMO6jTYvd/Ux0krNFC+ksXG3dHJDGCcMgeY=;
        b=HiAv2R9GB4tL+alNeA0EGREM+n6XPc+f8UrKfIMI2MmtfPoeNDJ+89W1GB5osGzGeM
         ufQXD6lZGrLXPrCMkhzywGm34OhG9LATd9VDmMCaJoiry9sAWddiX1gdVgyWIjVJB0hb
         u9jZMPFAw5fpqB327F7e+Vm0MwuCd7PA+nfHUpTdmuZEeMVStQhSZXKSssvm9kAe+MIz
         97yQd9rKvwk9/pXpjQqfuF5E1em0E1DM2ikn1KQAH6NeQ1sul40m+8ox8q9Ey9PlFPMJ
         0Gt/lnBCGWlpgPHy+uIrAJaljaF+4iN3oJ5bKumQifsgjEttMGbh2+YkLsVEKzfB7Y23
         WHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSmSd5/7EMO6jTYvd/Ux0krNFC+ksXG3dHJDGCcMgeY=;
        b=F1/SVkmNLg/z/Dn8GhvSMOvfIli3SXWx3uIJH4yHX7qfAtWCKwHl36N+iFY3JiSLwY
         pFSGIQyxfy96+SeC1F/IjyjgGBZloeLILzE41uwAnn7KFYEaOLC5ixjTvnlLzmsnqrYK
         +Zt2k9lQpE5s3enzokuwFT3BvumWr5RRlr19HUbX1XtKOiV2+gsEo8nY3A7M0Xr1KbdH
         jZYoPSrK+gcc2XKl4J0x/5bhEuYzXROcu5MvTEGF61R9cNtD2rBzFuqqwiqSUF8y0oUF
         lyNwq8NZSoETkcsbpp3Rcudmw8rYETPgmpzRervXRj8MTl+JTNpJCh8nHWGTfG8rvV59
         PjVg==
X-Gm-Message-State: AOAM533qg7u8d8yJWK46jzE0YMf/ayaBlqkm4WviFuYSioJ5wnwMFmLB
        bXyPR+P1eqqOUbmZ3rlx92o+mBg7mT8=
X-Google-Smtp-Source: ABdhPJzo88sC7WStKkOfR0MIKu7fzl9bbKuyvAyPe8q8KCPPulNUX7Fk1OVZr/ehkZYq1V7HHDeBcQ==
X-Received: by 2002:a67:3251:: with SMTP id y78mr5251494vsy.36.1604154812542;
        Sat, 31 Oct 2020 07:33:32 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 123sm1216349vsr.6.2020.10.31.07.33.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 07:33:31 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id p16so2064391vkf.13
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 07:33:31 -0700 (PDT)
X-Received: by 2002:a05:6122:10eb:: with SMTP id m11mr10139318vko.8.1604154810964;
 Sat, 31 Oct 2020 07:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201031004918.463475-1-xie.he.0141@gmail.com> <20201031004918.463475-2-xie.he.0141@gmail.com>
In-Reply-To: <20201031004918.463475-2-xie.he.0141@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 31 Oct 2020 10:32:53 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfKzKZ02st-enPfsgaQwTunPrmyK2x2jobZrWGb16KN0w@mail.gmail.com>
Message-ID: <CA+FuTSfKzKZ02st-enPfsgaQwTunPrmyK2x2jobZrWGb16KN0w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/5] net: hdlc_fr: Simpify fr_rx by using
 "goto rx_drop" to drop frames
To:     Xie He <xie.he.0141@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Krzysztof Halasa <khc@pm.waw.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 8:50 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> When the fr_rx function drops a received frame (because the protocol type
> is not supported, or because the PVC virtual device that corresponds to
> the DLCI number and the protocol type doesn't exist), the function frees
> the skb and returns.
>
> The code for freeing the skb and returning is repeated several times, this
> patch uses "goto rx_drop" to replace them so that the code looks cleaner.
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> ---
>  drivers/net/wan/hdlc_fr.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wan/hdlc_fr.c b/drivers/net/wan/hdlc_fr.c
> index 409e5a7ad8e2..4db0e01b96a9 100644
> --- a/drivers/net/wan/hdlc_fr.c
> +++ b/drivers/net/wan/hdlc_fr.c
> @@ -904,8 +904,7 @@ static int fr_rx(struct sk_buff *skb)
>                 netdev_info(frad, "No PVC for received frame's DLCI %d\n",
>                             dlci);
>  #endif
> -               dev_kfree_skb_any(skb);
> -               return NET_RX_DROP;
> +               goto rx_drop;
>         }
>
>         if (pvc->state.fecn != fh->fecn) {
> @@ -963,14 +962,12 @@ static int fr_rx(struct sk_buff *skb)
>                 default:
>                         netdev_info(frad, "Unsupported protocol, OUI=%x PID=%x\n",
>                                     oui, pid);
> -                       dev_kfree_skb_any(skb);
> -                       return NET_RX_DROP;
> +                       goto rx_drop;
>                 }
>         } else {
>                 netdev_info(frad, "Unsupported protocol, NLPID=%x length=%i\n",
>                             data[3], skb->len);
> -               dev_kfree_skb_any(skb);
> -               return NET_RX_DROP;
> +               goto rx_drop;
>         }
>
>         if (dev) {
> @@ -982,12 +979,12 @@ static int fr_rx(struct sk_buff *skb)
>                 netif_rx(skb);
>                 return NET_RX_SUCCESS;
>         } else {
> -               dev_kfree_skb_any(skb);
> -               return NET_RX_DROP;
> +               goto rx_drop;
>         }
>
> - rx_error:
> +rx_error:
>         frad->stats.rx_errors++; /* Mark error */
> +rx_drop:
>         dev_kfree_skb_any(skb);
>         return NET_RX_DROP;

I meant that I don't think errors should be double counted in rx_error
and rx_drop. It is fine to count drops as either.

Especially without that, I'm not sure this and the follow-on patch add
much value. Minor code cleanups complicate backports of fixes.
