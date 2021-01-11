Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23F2F1E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbhAKSwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbhAKSwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:52:53 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E31C0617A3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:52:13 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d20so705800otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rvew6cqVQniXIqwsUnCnTwK4rV3/PNHAJceO8utJLLk=;
        b=Ue034u5m1alXCz0yam8z4ML3f8BUq3NE+BNDAj5vPgNhkLiQj5PMokmGL0HUVkQS89
         5hYptgGnoHI6paU47QAPGm/H46VmW6+d3bRYuA8Cm/0eCTdfEsoieI5HKuldyk2F4ZLF
         YETtpLHMvzqbpu0SNYoUWN1qpBj4L7DhRVwJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rvew6cqVQniXIqwsUnCnTwK4rV3/PNHAJceO8utJLLk=;
        b=KkUZU/nrwXXlcSzpkaU/t716FvLFYRd3UPQgW7zfncup4YW2KL1n3n85Ot4Ii3kfYi
         sAQ/3VdFtnq36GwK1yWZL6bsirK0/hwKoJEyIcjhr0DG+91+K1xCm/bwDpza2dnUTaMj
         dcXVDzrngWGMO4pVwvXhP17rZlfGezrcSfUtiRiIq4lyZT7c+ha8dJH92eV92Q3uzTCL
         nNXJukdSGUS2CQ80NmzrdKD4TG6euBvVt9uN0Fx7rCPejKpHF/2MI80f5nB31eVrYY+H
         iobiziLuJhUgLQlC43rZcjLPa8BXXYPsA7+H3nI/3WvJE6QDThkP5TLVlxh9hNn4ZOMZ
         vFdg==
X-Gm-Message-State: AOAM531b6mcJ7oTS6J+J4m4g6OY6FdRalsvsLEAoolWqwtTgTfyW7qLL
        cP9HsNqX007ctnzQUxK/FURNo+iigE7Ebw==
X-Google-Smtp-Source: ABdhPJzPcSjRI9UQpKZiBx4V4QabMPo8cO8XxYGX5F3NhajzJD0jgNIsMkgddWhjdM5E2QFVY/eciA==
X-Received: by 2002:a9d:6847:: with SMTP id c7mr389321oto.134.1610391130987;
        Mon, 11 Jan 2021 10:52:10 -0800 (PST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id b188sm122455oif.49.2021.01.11.10.52.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 10:52:09 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id l200so371587oig.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:52:09 -0800 (PST)
X-Received: by 2002:aca:af4d:: with SMTP id y74mr130054oie.105.1610391128693;
 Mon, 11 Jan 2021 10:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20201208124523.8169-1-ruc_zhangxiaohui@163.com> <20210109160844.4ca73bf1@gmx.net>
In-Reply-To: <20210109160844.4ca73bf1@gmx.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 11 Jan 2021 10:51:57 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPkLg2GGFJTt25YO7wae==YAHftf8JXu520pL_vZaT3ug@mail.gmail.com>
Message-ID: <CA+ASDXPkLg2GGFJTt25YO7wae==YAHftf8JXu520pL_vZaT3ug@mail.gmail.com>
Subject: Re: [PATCH 1/1] mwifiex: Fix possible buffer overflows in mwifiex_config_scan
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Note: this is version 1; there's a later version posted, which does
not have a v2 tag...)

https://lore.kernel.org/linux-wireless/20201208150951.35866-1-ruc_zhangxiaohui@163.com/

On Sat, Jan 9, 2021 at 7:11 AM Peter Seiderer <ps.report@gmx.net> wrote:
> On Tue,  8 Dec 2020 20:45:23 +0800, Xiaohui Zhang <ruc_zhangxiaohui@163.com> wrote:
> > From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> > mwifiex_config_scan() calls memcpy() without checking
> > the destination size may trigger a buffer overflower,
> > which a local user could use to cause denial of service
> > or the execution of arbitrary code.
> > Fix it by putting the length check before calling memcpy().
> >
> > Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/scan.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
> > index c2a685f63..b1d90678f 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> > @@ -930,6 +930,8 @@ mwifiex_config_scan(struct mwifiex_private *priv,
> >                                   "DIRECT-", 7))
> >                               wildcard_ssid_tlv->max_ssid_length = 0xfe;
> >
> > +                     if (ssid_len > 1)
> > +                             ssid_len = 1;
>
> Why do your believe the available size is only '1'? A SSID is expected
> to be of size IEEE80211_MAX_SSID_LE/32 and the wildcard_ssid_tlv pointer
> is casted from tlv_pos (some lines above) which is a pointer/index into
> scan_cfg_out->tlv_buf...

I pointed out this discrepancy already, taking a slightly different approach:

https://lore.kernel.org/linux-wireless/CA+ASDXPVu5S0Vm0aOcyqLN090u3BwA_nV358YwkpXuU223Ug9g@mail.gmail.com/

> And the define (line 44) indicates there should be enough space for a SSID:
>
>   42 /* Memory needed to store a max number/size WildCard SSID TLV for a firmware
>   43         scan */
>   44 #define WILDCARD_SSID_TLV_MAX_SIZE  \
>   45         (MWIFIEX_MAX_SSID_LIST_LENGTH *                                 \
>   46                 (sizeof(struct mwifiex_ie_types_wildcard_ssid_params)   \
>   47                         + IEEE80211_MAX_SSID_LEN))

Ah, good catch. So this may not be a true overflow issue at all, even
if it's confusing and bad code. The "problem" is that this piece of
the struct is variable-length, and unless we're going to dynamically
resize/reallocate the whole buffer, we have to assume the initial
allocation was large enough (and per your note, it is).

> For sure something to improve here instead of using a confusing 'u8 ssid[1]'
> in struct mwifiex_ie_types_wildcard_ssid_params...

Yep.

Brian
