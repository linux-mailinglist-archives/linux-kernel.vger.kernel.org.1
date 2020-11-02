Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9192A25E9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgKBIQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:16:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728091AbgKBIQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604304986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9E5xGx57vMbqA5TKhLA066RNqsSeQsOkkIf9/7DD/8=;
        b=QuOCydCGlzbRUGEl+vy6keZIfPTQxS3aagMqSLvjnlg/B/aM7DvBLg/4kRXcswX259Xn6/
        CNGAro28jaDKEu8o6VJYIBwOxXgfczcC7lvHCWzqAJqkXwieFDXA57IpTG9GmafIBs2DXn
        0M2ktAXDr+YgiFWo+VI0TO2S58YjOP0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-x-WuHKyXNLWHX-ijPI4Nyg-1; Mon, 02 Nov 2020 03:16:23 -0500
X-MC-Unique: x-WuHKyXNLWHX-ijPI4Nyg-1
Received: by mail-pg1-f200.google.com with SMTP id j13so8640929pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 00:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9E5xGx57vMbqA5TKhLA066RNqsSeQsOkkIf9/7DD/8=;
        b=VMb1ts57BMdiJAKL/uUfg/ayt2zSeofZhldHA6/L/rkI1pjpriyRu7MhxLHahSnD38
         Mu8BNz2h8kLVaoAJAW7zTyvhAGGEhfq8aA2HctpTYq0LPyHto3qKQtdOCCbJIs7dHbx0
         dmgNotwyBZL1zjdMj6PSNYOKELm+tzlkZS7MspJ14KaB2yGzjg/OXCYuEX3LTKWNoFQX
         ugm5gJhgiqSATsptiBTzztrZHUtrNdxWreOFuvzcBC6FYercvzjx6YnCy36fMpPkN2qy
         XCB+6icB778Npp9vxOOfAjn+h3GnBAoZ8dqz4DMYqKUf0nKE7nLI4KwsADySn56ImEyU
         5adA==
X-Gm-Message-State: AOAM531dVDr+Pplj7xT9MA/fc+1POWfF1HyY565202m7lSO8s5L2Y6o8
        YFJ/BXN4CM1V+uwTJyjI/7Ng099H3HWS6lwI14j4FA5YpEdxmtfwjLRlEPwvDKvtB0JdmIftuky
        23gOmHN+UWA/KcSUaly05pCcoFJOUA7t/lxIKmDsn
X-Received: by 2002:a63:490e:: with SMTP id w14mr12552243pga.275.1604304982621;
        Mon, 02 Nov 2020 00:16:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztUX3eP7skIbxCCAfi1EqTTwLBQl5m0NBWbi48evSolymGVkpdQ1W2X2JQlawbyE7IApgbR/0pj9gAN9TuRhg=
X-Received: by 2002:a63:490e:: with SMTP id w14mr12552233pga.275.1604304982407;
 Mon, 02 Nov 2020 00:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20201101193504.679934-1-lzye@google.com>
In-Reply-To: <20201101193504.679934-1-lzye@google.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 2 Nov 2020 09:16:11 +0100
Message-ID: <CAO-hwJJVKOM7Om8E+kmYXTrA7SiOFgFt46BHfv+0j+ORhepbaQ@mail.gmail.com>
Subject: Re: [PATCH v2] Input: Fix the HID usage of DPAD input event generation.
To:     Chris Ye <lzye@google.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, trivial@kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linzhao.ye@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,


On Sun, Nov 1, 2020 at 8:35 PM Chris Ye <lzye@google.com> wrote:
>
> Generic Desktop DPAD usage is mapped by hid-input, that only the first
> DPAD usage maps to usage type EV_ABS and code of an axis. If HID
> descriptor has DPAD UP/DOWN/LEFT/RIGHT HID usages and each of usage size
> is 1 bit, then only the first one will generate input event, the rest of
> the HID usages will be assigned to hat direction only.
> The hid input event should check the HID report value and generate
> HID event for its hat direction.
>
> Test: Connect HID device with Generic Desktop DPAD usage and press the
> DPAD to generate input events.

Thanks for the patch, but I would rather have a proper tests added to
https://gitlab.freedesktop.org/libevdev/hid-tools

We already have gamepads tests, and it would be very nice to have this
patch reflected as a test as well. This would also allow me to better
understand the problem. I am not sure I follow the whole logic of this
patch without seeing the 2 variants of report descriptors.

Cheers,
Benjamin

>
> Signed-off-by: Chris Ye <lzye@google.com>
> ---
>  drivers/hid/hid-input.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 9770db624bfa..6c1007de3409 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1269,7 +1269,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>         struct input_dev *input;
>         unsigned *quirks = &hid->quirks;
>
> -       if (!usage->type)
> +       if (!usage->type && !field->dpad)
>                 return;
>
>         if (usage->type == EV_PWR) {
> @@ -1286,9 +1286,17 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>                 int hat_dir = usage->hat_dir;
>                 if (!hat_dir)
>                         hat_dir = (value - usage->hat_min) * 8 / (usage->hat_max - usage->hat_min + 1) + 1;
> -               if (hat_dir < 0 || hat_dir > 8) hat_dir = 0;
> -               input_event(input, usage->type, usage->code    , hid_hat_to_axis[hat_dir].x);
> -               input_event(input, usage->type, usage->code + 1, hid_hat_to_axis[hat_dir].y);
> +               if (hat_dir < 0 || hat_dir > 8 || value == 0)
> +                       hat_dir = 0;
> +               if (field->dpad) {
> +                       input_event(input, EV_ABS, field->dpad, hid_hat_to_axis[hat_dir].x);
> +                       input_event(input, EV_ABS, field->dpad + 1, hid_hat_to_axis[hat_dir].y);
> +               } else {
> +                       input_event(input, usage->type, usage->code,
> +                               hid_hat_to_axis[hat_dir].x);
> +                       input_event(input, usage->type, usage->code + 1,
> +                               hid_hat_to_axis[hat_dir].y);
> +               }
>                 return;
>         }
>
> --
> 2.29.1.341.ge80a0c044ae-goog
>

