Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D82E04BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 04:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgLVD1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 22:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgLVD1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:27:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0671BC06179C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 19:26:56 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s26so28609354lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 19:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DuYh69TS1gggLotCn6ERQcD55cxnc82V29wS9VHcJs=;
        b=WdJDWBFZxJ1uV3TfY51XO/idtHjYEIQPxRxDXv6oiW9yM6d7H70ZTkUAINBtJEzQHa
         vJS8JXiyFU76yxGYTeo8/QLRtGgsyUzN5GQzt5Lbe6xnNEQ/POe9PIjNdi2qqsjzyxJp
         YragRbGE+erGUY/5wZsROIPbKDen6IicXMsxDkCD0q4jx2fuJSuQNqJ7Co3ZTAg4P6lC
         DU/t21uYsSJXoKdqxbf0r2x/2enmPhpop4f+5Q2rDUx+E96cspGugwxSjmvuA9RsLPM4
         l1E4GrOj7hrOFWKM2OU5O/97vCKDQg4M7Cch3HQ9jlaDypfKHokibzBoeIv7Gukxs5/Z
         OY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DuYh69TS1gggLotCn6ERQcD55cxnc82V29wS9VHcJs=;
        b=HHMAGtMtw2h0L1M/pjqofM27hMutaXhm7vDiBLBaORkisDZnIOzYVwh/tLiOKGxJ+Q
         1R6fdBT//FiDmxAQn7dH9GPY+Ltz28oHvd7xIQUVjR30WSTBE2hmMdeOeGvmu/Ykg2Yu
         MTEPrCy0kO4jDjmzPy1ULF4GmG5CEfnCmCmykwEHyDoIFglfpxVdqv8tFXk05Rzju7yL
         f9PoWg42UbFVQcQd4Mqik9aTba3IBa0KWtJL/GYf2dD9WTsviKyEgj8gPF2vJsz++rvv
         NDyn/ofKwMHNuE2X2h90fG5ESJ5WCEtw14kCbq+2QvV9fhI3OfFgCL6peTJLog/2mj6T
         ZURw==
X-Gm-Message-State: AOAM530Qow2j4Ie/t4scvZt3Qaa8fn/at8oovBeHbgLfMkuq65KyV9E0
        rwr9l3UlMR05T+y9+fFYlafZ6WaHfQTji4GG45n82A==
X-Google-Smtp-Source: ABdhPJyydnV50sAF97g4pkHQR5JB1TgCTbhsPNMp+KFO7FBqrNHPukIGxBtqgi+y+1PLSGMSyPHdJvYMBUw1iSbyhzs=
X-Received: by 2002:a2e:9053:: with SMTP id n19mr5967972ljg.283.1608607615185;
 Mon, 21 Dec 2020 19:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20201216043335.2185278-1-apusaka@google.com> <20201216123317.v3.4.I215b0904cb68d68ac780a0c75c06f7d12e6147b7@changeid>
 <73E2D097-F8D4-4BFA-8EC1-C04B079F1BFC@holtmann.org>
In-Reply-To: <73E2D097-F8D4-4BFA-8EC1-C04B079F1BFC@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 22 Dec 2020 11:26:44 +0800
Message-ID: <CAJQfnxHrvnsLRDHNFWAN9uPJmWiTpE6x4YAmgs77KO6QQBFW7w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] Bluetooth: advmon offload MSFT handle controller reset
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Mon, 21 Dec 2020 at 17:12, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > When the controller is powered off, the registered advertising monitor
> > is removed from the controller. This patch handles the re-registration
> > of those monitors when the power is on.
> >
> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> >
> > ---
> >
> > (no changes since v1)
> >
> > net/bluetooth/msft.c | 79 +++++++++++++++++++++++++++++++++++++++++---
> > 1 file changed, 74 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
> > index f5aa0e3b1b9b..7e33a85c3f1c 100644
> > --- a/net/bluetooth/msft.c
> > +++ b/net/bluetooth/msft.c
> > @@ -82,8 +82,15 @@ struct msft_data {
> >       struct list_head handle_map;
> >       __u16 pending_add_handle;
> >       __u16 pending_remove_handle;
> > +
> > +     struct {
> > +             u8 reregistering:1;
> > +     } flags;
> > };
>
> hmmm. Do you have bigger plans with this struct? I would just skip it.
>
This struct is also used in patch 5/5 to store the "enabled" status of
the filter.
Suspend/resume would need to enable/disable the filter, but it is not
yet implemented in this patch series.

Thanks,
Archie
