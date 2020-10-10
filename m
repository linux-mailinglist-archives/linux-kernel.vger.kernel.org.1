Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C051B289CB6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 02:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgJJA01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 20:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgJJAXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 20:23:52 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31BFC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 17:23:50 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id s15so5956756vsm.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 17:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avBDTcm5gU0Af/+YPoKt2EvMb/tJEqNyS5fFLJ2/b0M=;
        b=Y/NhiiS+Zfn8VRdPyWWuSGBztlV2QZZ8b9SZ3Ndlma9YNNzdn6p4llK/RR1GQxHmzF
         1ZAiZl0NoZM/5+yZH4GDCMKNENX9/IqoSNEaohoXAizPxcESjgrZt6V92ekyuS72gR8d
         skP7cwBRzmU50ynTIlkWM9RiGssU0QSmV/wX/6Q64pLtFtn8R10Mz4O2zDGUhR3JOWBh
         33fbh1kzK5MPp/G68q3m+OHVoRkanTMMus0iU0oEBGzeBcPVaco871cSFPf1m62pIEpS
         1Huk2Whx1qDY7piCBqsG8qmOnkfPcbHnLXKexkTYQZos6o1WiwjAWhZdw9Sfv5WpWoid
         h+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avBDTcm5gU0Af/+YPoKt2EvMb/tJEqNyS5fFLJ2/b0M=;
        b=saqQu8bFtqHaKIOPRT2UuFPl0ML97M6UMDs1jWFFbmTGCRsdHoIVFLiTM4ui2aUy2d
         WdXpbF9j6z/2JKEMZa/3kRH9fqXyECZ4uMbjyp5A7T7lq5neZAvNIgcQgsoqlJ8o0pQV
         a0niO8WroTfyhLfZ+xAEwhIZMyKw2opSLnffIIIlYil2y/Annvtz4F0hhSEfp9LRMnx4
         DyK9ie2zlpYHYqlZd9R7u7j8eVy5LGF+cWB6nBkI9obnfZXfyu8L7EPLwIwu2sOpqyoe
         SWfGR8sWoLGSRhJgkMeoMV+K0C7GpMNU6XthB+5xgWv6GJNb9GUC+a1s56XjZf9zA4od
         gZ1g==
X-Gm-Message-State: AOAM5324oBeAMqgxr8tjDjM92LLijxyzDufIQeLt4GDAyAvdGvzaxrUX
        hoVFdIBxuxEDnna6b58mhGRl7EvnMos=
X-Google-Smtp-Source: ABdhPJyErvFXfzV/V3RkRZ9cD68L7S2AwnNLO7JGKyELNaASefUdS3jINnQ++Y2lKMzVDNHyk/gOPA==
X-Received: by 2002:a67:89c9:: with SMTP id l192mr2571677vsd.36.1602289429504;
        Fri, 09 Oct 2020 17:23:49 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id s8sm1389413vke.48.2020.10.09.17.23.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 17:23:48 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id x26so3638841uan.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 17:23:47 -0700 (PDT)
X-Received: by 2002:ab0:7718:: with SMTP id z24mr9365648uaq.92.1602289427332;
 Fri, 09 Oct 2020 17:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201009103121.1004-1-ceggers@arri.de>
In-Reply-To: <20201009103121.1004-1-ceggers@arri.de>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 9 Oct 2020 20:23:10 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfkHkyBarmp-wi-zo-04fPWAOu_6fxwGPVAo7S5xP6c8w@mail.gmail.com>
Message-ID: <CA+FuTSfkHkyBarmp-wi-zo-04fPWAOu_6fxwGPVAo7S5xP6c8w@mail.gmail.com>
Subject: Re: [PATCH net 1/2] socket: fix option SO_TIMESTAMPING_NEW
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

On Fri, Oct 9, 2020 at 6:32 AM Christian Eggers <ceggers@arri.de> wrote:
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
> ---
>  net/core/sock.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 34a8d12e38d7..3926804702c1 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1024,16 +1024,15 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
>                 }
>
>                 sk->sk_tsflags = val;
> +               if (optname != SO_TIMESTAMPING_NEW)
> +                       sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> +
>                 if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
>                         sock_enable_timestamp(sk,
>                                               SOCK_TIMESTAMPING_RX_SOFTWARE);
> -               else {
> -                       if (optname == SO_TIMESTAMPING_NEW)
> -                               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> -

The idea is to select new vs old behavior depending on which of the
two setsockopts is called.

This suggested fix still sets and clears the flag if calling
SO_TIMESTAMPING_NEW to disable timestamping. Instead, how about

        case SO_TIMESTAMPING_NEW:
-               sock_set_flag(sk, SOCK_TSTAMP_NEW);
                fallthrough;
        case SO_TIMESTAMPING_OLD:
[..]
+               sock_valbool_flag(sk, SOCK_TSTAMP_NEW,
+                                 optname == SO_TIMESTAMPING_NEW);
+
                if (val & SOF_TIMESTAMPING_OPT_ID &&

That is a subtle behavioral change, because it now leaves
SOCK_TSTAMP_NEW set also when timestamping is turned off. But this is
harmless, as in that case the versioning does not matter. A more
pedantic version would be

+               sock_valbool_flag(sk, SOCK_TSTAMP_NEW,
+                                 optname == SO_TIMESTAMPING_NEW &&
+                                 val & SOF_TIMESTAMPING_TX_RECORD_MASK);
