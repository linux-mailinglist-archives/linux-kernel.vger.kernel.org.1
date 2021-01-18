Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4EB2FA365
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405089AbhAROnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:43:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393161AbhAROmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610980887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uEqfmUs2U7YlcQztfzJZToke7xdfCbfYWSoDMToy3VI=;
        b=WAWEkqyLYMxTXNu3clX9fCIKMTuDV7wHvAavfiAqML7QZhO78Do7nW/qp3CCCmjVwnJgZH
        pxGYB/ocIjQl4m7amNZpt10ahgg/xamA7iIEU+ud3YlJIKF5Df2Vz7ijD9iRuTzjrPzk5t
        h/6K2T71tUupIlOCOm3LkMEoAt18zjc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-BiPs8eRnMkut6CWRyRbcbA-1; Mon, 18 Jan 2021 09:41:24 -0500
X-MC-Unique: BiPs8eRnMkut6CWRyRbcbA-1
Received: by mail-pj1-f72.google.com with SMTP id v14so4241723pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEqfmUs2U7YlcQztfzJZToke7xdfCbfYWSoDMToy3VI=;
        b=mL+vsENLXwI92D9ZQMwhBzR3Q2QnrKHSwbILGxcDsQniGyEPmycysYDXS/06KIbMD5
         2iQ9sSy6dXWrOiTNe+M104cNBY/DyVgsDkdTY5EDJ8/RGdMOq2IfRrdcaurxDSbfpsCI
         RkLgZ0KtdtG2P67D3EMZuoa+cqnGvig5Pn3l5pZIt4P38o2cqqnBta7hz5mxFaqrP6k3
         DzWR6vug7Uwl/Pg1txBThh8ZGGh7CjpWw3lQdw4qm2UliXp2ei7CF6Pxx1Aeok9EHROP
         xlFj5cL8REBZyBBNEx+SEOc0/WFmNBg02L2LSjv1uSXwR16n9dje+9i/nrQwD4IYBlHc
         X5bg==
X-Gm-Message-State: AOAM531BS4QSiQZreCKmcGe7Fhki4s5Km1XGV4fiMTjLSsLFVOH+PT0B
        AA0vOHbq8pR1VU3UWOIPXtnP3pIPWQf6Wb07Ee/plQ6GWUr+9BcsNWZI8a77UypHbHKJYFGH/qj
        fNaK/I0flP6uh/bAQhiA32xS5w7rrJnPJTtBEjSL3
X-Received: by 2002:a63:fb54:: with SMTP id w20mr25836178pgj.419.1610980883648;
        Mon, 18 Jan 2021 06:41:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyCCW/HTfkwwAokVUmKSOBLcFIO5ocMaaHWbwHvZEJHyyyVlpSZz63R8NF3aGloEqenwFRZ9f1OBYzxqxoWR8=
X-Received: by 2002:a63:fb54:: with SMTP id w20mr25836165pgj.419.1610980883431;
 Mon, 18 Jan 2021 06:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20210118134523.178605-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210118134523.178605-1-kai.heng.feng@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 18 Jan 2021 15:41:12 +0100
Message-ID: <CAO-hwJ+29t8D1RkEh23=k_x4vOWwo3HvR_3GAA9M2pPNMaGLNQ@mail.gmail.com>
Subject: Re: [PATCH] HID: multitouch: Apply MT_QUIRK_CONFIDENCE quirk for
 multi-input devices
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 18, 2021 at 2:45 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Palm ejection stops working on some Elan and Synaptics touchpad after
> commit 40d5bb87377a ("HID: multitouch: enable multi-input as a quirk for
> some devices").
>
> The commit changes the mt_class from MT_CLS_WIN_8 to
> MT_CLS_WIN_8_FORCE_MULTI_INPUT, so MT_QUIRK_CONFIDENCE isn't applied
> anymore.
>
> So also apply the quirk since MT_CLS_WIN_8_FORCE_MULTI_INPUT is
> essentially MT_CLS_WIN_8.
>
> Fixes: 40d5bb87377a ("HID: multitouch: enable multi-input as a quirk for some devices")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks for the patch.

IIt seems I was too lazy to write a regression test for it, and this
strikes back.
Can you also work on a regression test for this at
https://gitlab.freedesktop.org/libevdev/hid-tools ?

Cheers,
Benjamin




> ---
>  drivers/hid/hid-multitouch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 0743ef51d3b2..8429ebe7097e 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -758,7 +758,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>                         MT_STORE_FIELD(inrange_state);
>                         return 1;
>                 case HID_DG_CONFIDENCE:
> -                       if (cls->name == MT_CLS_WIN_8 &&
> +                       if ((cls->name == MT_CLS_WIN_8 ||
> +                            cls->name == MT_CLS_WIN_8_FORCE_MULTI_INPUT) &&
>                                 (field->application == HID_DG_TOUCHPAD ||
>                                  field->application == HID_DG_TOUCHSCREEN))
>                                 app->quirks |= MT_QUIRK_CONFIDENCE;
> --
> 2.29.2
>

