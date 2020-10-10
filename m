Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27533289CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 03:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgJJA6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 20:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgJJAfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 20:35:47 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57FEC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 17:35:21 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id d4so334034vsk.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 17:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9rKXSF/+hOI03cJwnGoLbAyTG21JC0lh29VXlgWeNs=;
        b=aeRxJRaUwpmvk5KWcdoE6rCvPblB+M7cGALUmirIFb2WcDkLHUl3aBF+cUpmmebMw9
         FJxsJxSN/AAwru+LtKja/qluYuOJCx3j9VCOGFr27IWqr6i26YEU0/YJacFKrNG+RQ/L
         ppl1QfsuEAxcA7gZ975bhR2K/nVMdd9+WmubC6Wu3eHUpfwZpJnmeci3RmnsO2JrKMFt
         u0E0Dzu0PgaY+5FPPWDhqkkkyQln4+43KWfJmTHJKMck6xrkBDQrNSO8xSVRgjm6xoYV
         793yzgNreu3G0EW+XuBI59zylCcomR+aGWHofbcv4eFVYz1QUXPPODhv+YtmCXfteAbC
         qo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9rKXSF/+hOI03cJwnGoLbAyTG21JC0lh29VXlgWeNs=;
        b=eKv8sRq30i5u4cpgc2xMTV5y5+P1p71LndreUnPvlwjvBlJSEJQmOob8C/4RQOutoA
         N5lqRDQkuCyPngDKyd6fKjaswqNxzkSL0jFR2vBKjAfZUxGbg6qIOPoys1LQrI54Iz7K
         0Va7wu7SwU70fflQC5f+M+3ox25X5mwCcXCIRMw1Y2ezS6zHUwYq2bq94/RRbzayeVaa
         ofab7fYFqwvfNjE3m+UJMCLIzA2gzH6+NlBmgQlTaWNqp1BGcdk6ZE5/JRoVgpMeWreB
         B3XdDAlAjfoIVwrBJ7rJ29Sbe2vx2FuhNKT6JoGWJQrqLI3ksMuj3CaCkQleEBVVl3tX
         UgDw==
X-Gm-Message-State: AOAM531xxUe6dUDx7zDcjTqMroZ+81ur1CUFFgQJm2ZRMgcTEal+Fgcm
        NKQelDVszoYH5GbUOdcqE/QKJL5x4Hc=
X-Google-Smtp-Source: ABdhPJwuSfQl2jztLDABm+OLX+/qk65TYS+gNMLezZgZDpmSAy9snZ3oFmecHOwRpP0gEG0z8WlJrQ==
X-Received: by 2002:a67:eb50:: with SMTP id x16mr9217599vso.6.1602290119938;
        Fri, 09 Oct 2020 17:35:19 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id m1sm537691vsd.14.2020.10.09.17.35.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 17:35:18 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id c7so3655711uaq.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 17:35:18 -0700 (PDT)
X-Received: by 2002:ab0:76cd:: with SMTP id w13mr9533714uaq.37.1602290117899;
 Fri, 09 Oct 2020 17:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201009103121.1004-1-ceggers@arri.de> <20201009103121.1004-2-ceggers@arri.de>
In-Reply-To: <20201009103121.1004-2-ceggers@arri.de>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 9 Oct 2020 20:34:40 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfjZL-AMQy5PvVs6f3K8SEkWzdUrXz_4LniWFezVdfL8A@mail.gmail.com>
Message-ID: <CA+FuTSfjZL-AMQy5PvVs6f3K8SEkWzdUrXz_4LniWFezVdfL8A@mail.gmail.com>
Subject: Re: [PATCH net 2/2] socket: don't clear SOCK_TSTAMP_NEW when
 SO_TIMESTAMPNS is disabled
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
> SOCK_TSTAMP_NEW (timespec64 instead of timespec) is also used for
> hardware time stamps (configured via SO_TIMESTAMPING_NEW).
>
> User space (ptp4l) first configures hardware time stamping via
> SO_TIMESTAMPING_NEW which sets SOCK_TSTAMP_NEW. In the next step, ptp4l
> disables SO_TIMESTAMPNS(_NEW) (software time stamps), but this must not
> switch hardware time stamps back to "32 bit mode".
>
> This problem happens on 32 bit platforms were the libc has already
> switched to struct timespec64 (from SO_TIMExxx_OLD to SO_TIMExxx_NEW
> socket options). ptp4l complains with "missing timestamp on transmitted
> peer delay request" because the wrong format is received (and
> discarded).
>
> Fixes: 887feae36aee ("socket: Add SO_TIMESTAMP[NS]_NEW")
> Fixes: 783da70e8396 ("net: add sock_enable_timestamps")
> Signed-off-by: Christian Eggers <ceggers@arri.de>

Acked-by: Willem de Bruijn <willemb@google.com>

Yes, we should just select SOCK_TSTAMP_NEW based on which of the two
syscall variants the process uses.

There is no need to reset on timestamp disable: in the common case the
selection is immaterial as timestamping is disabled.

As this commit message shows, with SO_TIMESTAMP(NS) and
SO_TIMESTAMPING that can be independently turned on and off, disabling
one can incorrectly switch modes while the other is still active.
