Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF12F5D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbhANJYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:24:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726374AbhANJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610616196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OEsWq5QL48O8qaE7/imzssejhlq+Va2mSt6WB4e+5Ck=;
        b=eU5RKKdkHgAYSRdh72v7AweJ+NAeSddzRY05ZPBrrY9Mtatmc3Oe2lC/c/PLg0iSIxvyN3
        d0ppwZT+W8GvA3R30k1FZqoMuPxWfHI94OJmSBa2yjkiVNEHXb/Es1FylBxx86ZwX36q/J
        rTnWXkulSvL6UHHZjJOh3UnFUp/NfZU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-NCLJ8uXDP8urhxccP-hw4w-1; Thu, 14 Jan 2021 04:23:14 -0500
X-MC-Unique: NCLJ8uXDP8urhxccP-hw4w-1
Received: by mail-pg1-f199.google.com with SMTP id l2so3372855pgi.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEsWq5QL48O8qaE7/imzssejhlq+Va2mSt6WB4e+5Ck=;
        b=UuiKN9SSTbyNF6hZJ0hHXq9R+FhXl0ykyMID+JtYftnGdsRlJED0ptn0v0t1B7PITI
         vuqVVd2Xk8tHV32KPjEMeisZAsTcCviv8PQyzpU/ukPCUyXRebfxaYNs0IkAFgIy5Mr0
         Bb2wXsAvO6lj0P9sJQRvC3ew6fNjzLTdxiFpnt6fO2/V7+7G3HFrsuJn91SP13n1UpqW
         wDxOJMQZRp2g/FhcSmHihJYooT6YN7ZbSbfPrplg8cGdQ6YAfKCHtzmhaRaUcCTKFA4W
         hVBYuJrIGNkqoA0AR/FK3cG/qNpvFF0dmATTKxHa54uP91RYtlGXNkIr0JSxvHYqwUzl
         lqIQ==
X-Gm-Message-State: AOAM531JN0Fuc/nSc873ff+A3Ib1M+f3W2Npp77adGTnZLAR2B/F/hsM
        +S288ps+ATaZztThsXudldH9ythlyp06v/FsQfdXdklfcXVDCRNqA/GkzAsS3/EVYYkVtEN2c5P
        UL0BJqhSP8v7gqn8Zf2BwcuV963LatFUYW44/kqKD
X-Received: by 2002:a17:902:8487:b029:dc:20bc:2812 with SMTP id c7-20020a1709028487b02900dc20bc2812mr6792184plo.66.1610616193581;
        Thu, 14 Jan 2021 01:23:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/LLjQIR4gNqTyKg6e2SkY5X3uI+i4g6i29bINK92pruthJqJ6A7y9+necGTTIiZ38o68Qo6k76m/eEALRacs=
X-Received: by 2002:a17:902:8487:b029:dc:20bc:2812 with SMTP id
 c7-20020a1709028487b02900dc20bc2812mr6792170plo.66.1610616193324; Thu, 14 Jan
 2021 01:23:13 -0800 (PST)
MIME-Version: 1.0
References: <X//jjawwbm8FxbQU@google.com>
In-Reply-To: <X//jjawwbm8FxbQU@google.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 14 Jan 2021 10:23:02 +0100
Message-ID: <CAO-hwJK5QxxX26hFiVfQr2EfnwdZSEB2paCsZBbX58iPxJvfww@mail.gmail.com>
Subject: Re: [PATCH] HID: hid-input: avoid splitting keyboard, system and
 consumer controls
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Sean O'Brien" <seobrien@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Thu, Jan 14, 2021 at 7:24 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> A typical USB keyboard usually splits its keys into several reports:
>
> - one for the basic alphanumeric keys, modifier keys, F<n> keys, six pack
>   keys and keypad. This report's application is normally listed as
>   GenericDesktop.Keyboard
> - a GenericDesktop.SystemControl report for the system control keys, such
>   as power and sleep
> - Consumer.ConsumerControl report for multimedia (forward, rewind,
>   play/pause, mute, etc) and other extended keys.
> - additional output, vendor specific, and feature reports
>
> Splitting each report into a separate input device is wasteful and even
> hurts userspace as it makes it harder to determine the true capabilities
> (set of available keys) of a keyboard, so let's adjust application
> matching to merge system control and consumer control reports with
> keyboard report, if one has already been processed.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/hid/hid-input.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index f797659cb9d9..df45d8d07dc2 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1851,6 +1851,16 @@ static struct hid_input *hidinput_match_application(struct hid_report *report)
>         list_for_each_entry(hidinput, &hid->inputs, list) {
>                 if (hidinput->application == report->application)
>                         return hidinput;
> +
> +               /*
> +                * Keep SystemControl and ConsumerControl applications together
> +                * with the main keyboard, if present.
> +                */
> +               if ((report->application == HID_GD_SYSTEM_CONTROL ||
> +                    report->application == HID_CP_CONSUMER_CONTROL) &&
> +                   hidinput->application == HID_GD_KEYBOARD) {

I am not fundamentally against the patch, but I think that if the
device exposes first a HID_CP_CONSUMER_CONTROL and then a
HID_GD_KEYBOARD we will end up with 2 different input nodes. We likely
need to "convert" HID_GD_SYSTEM_CONTROL and HID_CP_CONSUMER_CONTROL to
HID_GD_KEYBOARD when creating the hidinput.

Cheers,
Benjamin

> +                       return hidinput;
> +               }
>         }
>
>         return NULL;
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
>
> --
> Dmitry
>

