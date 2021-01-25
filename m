Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC63033A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbhAZFBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:01:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726374AbhAYJVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611566425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z6HAUaL66VmRs9IXdRIQEq0vq86CNUbZkJ41gCNQKso=;
        b=RteDrmVN3g6Fkm54lvTFOu4cA5GUV6jP/GimWf1SmcboQ8gX806CCfvrd+l2QHV3pLxOf8
        UxufbnMqcHEtIVj2TGgWBq2wdUFnbFcXg21VgSGt5v0O/nYMDBvhcvZ0qvd4khVJvvefdH
        i9AAwYbMhV6OiKiZ6fIf2tjD/4Cj3kc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-_qme4RkCMJiRne4JXpmkyQ-1; Mon, 25 Jan 2021 04:06:08 -0500
X-MC-Unique: _qme4RkCMJiRne4JXpmkyQ-1
Received: by mail-pj1-f70.google.com with SMTP id a18so8875398pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6HAUaL66VmRs9IXdRIQEq0vq86CNUbZkJ41gCNQKso=;
        b=Xcyjd0FmgIjE/WvHg7Y7VY2DTtAWzsc34QHlnw5nQ/59I67RnspsxAhXSrQxB0dnAj
         N8kF1uEh2uJqJKGAHTOKxiimVx235KD9M469RfeUpOlnVJbNa+tgBfbIKc9N5E8WdBXb
         uXZMQbG527Eb2AzVdKanKhEvUokJvNMwxAi7UAQG4ibC+nTyYpIJG0QBbxIqDUxmqPXu
         ZjLzzQr7ct5KjmdXsyEYHS2BHSTZMC6cZEsMU76/mpRAfSRfB+zm1bL37MuZ0WpBgc1F
         0R0Lpho+FfooAKahL0U7SKAaeKZLWRFLli9kW3Tv/0bLnhHmAuioYT/2wd/yEeOvDCeO
         iMEw==
X-Gm-Message-State: AOAM530mgXsjm5gGwlelyejJ25xfwap9UtATy81EbDR55orKe6FilHfx
        LKMBcy9vZ+CMBfrFctx1RQOfylGxhY9Cm3776af3LJsJstph3+EZDKbcyDHyb51Gk2pH3hwoihV
        jR0d2SQwlUb1kZBOrgkyb33ji0vAvetW8kotQetYo
X-Received: by 2002:a17:90b:78f:: with SMTP id l15mr13878510pjz.234.1611565567590;
        Mon, 25 Jan 2021 01:06:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvl7W3nwIIt2lEJSZJBAoNTkifQKmHHI82LoAwhySwgpFDjajl1Eeq9X5qOXQrhX2tEdpdxhTWqnfTqqtjWI0=
X-Received: by 2002:a17:90b:78f:: with SMTP id l15mr13878490pjz.234.1611565567402;
 Mon, 25 Jan 2021 01:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20210118134523.178605-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210118134523.178605-1-kai.heng.feng@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 25 Jan 2021 10:05:56 +0100
Message-ID: <CAO-hwJKjNXO_uy4YvqeTk+mFM=6b25YDN0XexyN4fNpxmHm8=Q@mail.gmail.com>
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
> ---

Thanks for the patch, and for the hid-tools MR.

I have now added the "Cc: stable@vger.kernel.org" tag and pushed to
for-5.11/upstream-fixes.

Cheers,
Benjamin

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

