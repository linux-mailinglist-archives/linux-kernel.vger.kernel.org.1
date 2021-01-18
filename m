Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A292F2FA806
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436710AbhARRxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:53:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59660 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436653AbhARRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:46:44 -0500
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l1Yb0-0004aO-Su
        for linux-kernel@vger.kernel.org; Mon, 18 Jan 2021 17:45:53 +0000
Received: by mail-lf1-f71.google.com with SMTP id 7so6911416lfz.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ooFCSpxNJTp9XtUwL6uKTwDWwzCSip4jz+DezusF5A=;
        b=i+r8DV0uXH2WVac77CJ8Mt0H+YhX0AEUUIxJwfGsRgOi0xeO5MJCjzwTBNMhsjFmSA
         C4qVCHwfkJrTY/LRqR+WpnrwCo9PYF9Ow+pRlYdHoGEJDSPX7r2VCrp3relm9QUCuHj2
         UGo96AoW3grTqkwXREAlfWfeurz/b1akOj/Edvify6PgitAK2M/PksuMljwvQ0hMOvaX
         82MyGEBK2KuHjaoOtlX+N7QP6T4d57gsknKngdHWalWYCZV/ySNwdv9xfFfI53ZMyUaZ
         xFOGOZom8ncSixYKKuigy31aHNfb2ev4+d6WhC1ylrDRsv1poQgpvga/tHeL3bwOHf1S
         kBAg==
X-Gm-Message-State: AOAM531A6xeZN2lljR8E2iXzbTMUAG49XUlMWn4NMLfTWiEM90OOKHbT
        FyRVyExqHglU+o2MzUbB43czyH3Uzg/+RrykYstTzbSIm9+UxQxJqAgZuNKZv/A25eTCgIdIwc6
        N8k5XWH+SnW6Xa4xqLtrr01s+YWOWqmw8euzn98SXawElQBBkfw6Fdy0RWw==
X-Received: by 2002:ac2:561b:: with SMTP id v27mr96328lfd.425.1610991942362;
        Mon, 18 Jan 2021 09:45:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuGUEvNmZZQTHUk/701mXMBvtSTVf4z3qsKQY/HZdODD33tzB7RECpncnDEPw+84K5lE4EfDpC8UXPo4rOcIs=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr96320lfd.425.1610991942149;
 Mon, 18 Jan 2021 09:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20210118134523.178605-1-kai.heng.feng@canonical.com> <CAO-hwJ+29t8D1RkEh23=k_x4vOWwo3HvR_3GAA9M2pPNMaGLNQ@mail.gmail.com>
In-Reply-To: <CAO-hwJ+29t8D1RkEh23=k_x4vOWwo3HvR_3GAA9M2pPNMaGLNQ@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 19 Jan 2021 01:45:30 +0800
Message-ID: <CAAd53p4JHX5R1KxSuz_PMsdJiZ85rnJR_LwG-RmgNs-0hKubrQ@mail.gmail.com>
Subject: Re: [PATCH] HID: multitouch: Apply MT_QUIRK_CONFIDENCE quirk for
 multi-input devices
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 18, 2021 at 10:41 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi,
>
> On Mon, Jan 18, 2021 at 2:45 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Palm ejection stops working on some Elan and Synaptics touchpad after
> > commit 40d5bb87377a ("HID: multitouch: enable multi-input as a quirk for
> > some devices").
> >
> > The commit changes the mt_class from MT_CLS_WIN_8 to
> > MT_CLS_WIN_8_FORCE_MULTI_INPUT, so MT_QUIRK_CONFIDENCE isn't applied
> > anymore.
> >
> > So also apply the quirk since MT_CLS_WIN_8_FORCE_MULTI_INPUT is
> > essentially MT_CLS_WIN_8.
> >
> > Fixes: 40d5bb87377a ("HID: multitouch: enable multi-input as a quirk for some devices")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Thanks for the patch.
>
> IIt seems I was too lazy to write a regression test for it, and this
> strikes back.
> Can you also work on a regression test for this at
> https://gitlab.freedesktop.org/libevdev/hid-tools ?

Of course. I'll do it later this week. Currently I have both affected
Elan and Synaptics touchpad in hand.
Will this be a blocker of getting the patch merged?

Kai-Heng

>
> Cheers,
> Benjamin
>
>
>
>
> > ---
> >  drivers/hid/hid-multitouch.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> > index 0743ef51d3b2..8429ebe7097e 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -758,7 +758,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> >                         MT_STORE_FIELD(inrange_state);
> >                         return 1;
> >                 case HID_DG_CONFIDENCE:
> > -                       if (cls->name == MT_CLS_WIN_8 &&
> > +                       if ((cls->name == MT_CLS_WIN_8 ||
> > +                            cls->name == MT_CLS_WIN_8_FORCE_MULTI_INPUT) &&
> >                                 (field->application == HID_DG_TOUCHPAD ||
> >                                  field->application == HID_DG_TOUCHSCREEN))
> >                                 app->quirks |= MT_QUIRK_CONFIDENCE;
> > --
> > 2.29.2
> >
>
