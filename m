Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD79258CD5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 12:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIAKcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 06:32:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51389 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgIAKcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598956328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=orjqWGMPGIbjs2BtW1dTTBT2WpkyFXIf8RMOJhYRAHc=;
        b=QkJFG6pKAdn4uxyipDElOg31+cVJecZs4VrczWrtuCysQihsfDGGznb6wFqnNOuSciX6nA
        dFCkCTO32teaH9TwzfHp5v+YTquT29piBtShq/pWAsQXTL/Dm71BPhe2TkDN2UY1OsbFBR
        7OvxHxGE5q6U6/fhi9fLOhryEe1X3Vk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-i7Qp4cQUOaGuufnPiyTuPg-1; Tue, 01 Sep 2020 06:32:06 -0400
X-MC-Unique: i7Qp4cQUOaGuufnPiyTuPg-1
Received: by mail-pj1-f72.google.com with SMTP id j1so304294pjs.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 03:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orjqWGMPGIbjs2BtW1dTTBT2WpkyFXIf8RMOJhYRAHc=;
        b=WQf9mqpJwzcdd+eY9GS1x3mdoh9Iv24R9GP4akzJ1mnd9bLoN5bcI/0OIr8I1J7j49
         HaPJN5Gz3VdO52V52N/lE+H13l6TSjNjnQphaJuR6dHSQ/gtbizkx1fQ1AkNqU5EQ3oB
         WAi9NFiW9j6MCPd4LJO6GYB3M1JhzCgcBL3dtmJXwItjMuR5iXXygCrnnqLFu76h2w9d
         HX9+sjqyrRcHE2OIraGaDMWCslg+9w8baIB+tmaU+BvNPA4Hjnla22VPK4L53IpXXe96
         CsP3cMGRuiDBDDDNpIUQHlFKavo5BozotK+9WGIqiWQD3mI6Qf+3i4PGrr+cNsBXWftL
         RtHg==
X-Gm-Message-State: AOAM5300vCpJBryJDkQnYS/xS3vw/lR33zD4RxSWLrPF9GEKKgA4+4UQ
        n6QIu/9DdF4x01xYwZInZjkcH4aMn7qgKOh1+Y/unoGJDBSQMBl8E4gWT51BpPf2JVaOEZYivoq
        JR0+L3Kagh+oB+AtnD5gHcjoz2FZCHFEsLYewsI8q
X-Received: by 2002:a63:df13:: with SMTP id u19mr922834pgg.275.1598956325498;
        Tue, 01 Sep 2020 03:32:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVwFAW9GZ1QG4XY5sg1uzFq7QM+YlerG0MXjXNQpchgXwjU1ooxwkmQFnZFwmnjAmHFtXFzORi6Wi9FOJZcGg=
X-Received: by 2002:a63:df13:: with SMTP id u19mr922814pgg.275.1598956325157;
 Tue, 01 Sep 2020 03:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200901095233.1069194-1-maz@kernel.org>
In-Reply-To: <20200901095233.1069194-1-maz@kernel.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 1 Sep 2020 12:31:53 +0200
Message-ID: <CAO-hwJ+L5HyamPm4DGfzJx9iUyvHJTAks8KA5bmu-Fgq2ABFHQ@mail.gmail.com>
Subject: Re: [PATCH v4] HID: core: Sanitize event code and type when mapping input
To:     Marc Zyngier <maz@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 11:52 AM Marc Zyngier <maz@kernel.org> wrote:
>
> When calling into hid_map_usage(), the passed event code is
> blindly stored as is, even if it doesn't fit in the associated bitmap.
>
> This event code can come from a variety of sources, including devices
> masquerading as input devices, only a bit more "programmable".
>
> Instead of taking the event code at face value, check that it actually
> fits the corresponding bitmap, and if it doesn't:
> - spit out a warning so that we know which device is acting up
> - NULLify the bitmap pointer so that we catch unexpected uses
>
> Code paths that can make use of untrusted inputs can now check
> that the mapping was indeed correct and bail out if not.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---

Pushed to for-5.9/upstream-fixes

Cheers,
Benjamin

> * From v3:
>   - Drop totally unrelated mfd/syscon change from the patch
>
> * From v2:
>   - Don't prematurely narrow the event code so that hid_map_usage()
>     catches illegal values beyond the 16bit limit.
>
> * From v1:
>   - Dropped the input.c changes, and turned hid_map_usage() into
>     the validation primitive.
>   - Handle mapping failures in hidinput_configure_usage() and
>     mt_touch_input_mapping() (on top of hid_map_usage_clear() which
>     was already handled)
>
>  drivers/hid/hid-input.c      |  4 ++++
>  drivers/hid/hid-multitouch.c |  2 ++
>  include/linux/hid.h          | 42 +++++++++++++++++++++++++-----------
>  3 files changed, 35 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index b8eabf206e74..88e19996427e 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1132,6 +1132,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>         }
>
>  mapped:
> +       /* Mapping failed, bail out */
> +       if (!bit)
> +               return;
> +
>         if (device->driver->input_mapped &&
>             device->driver->input_mapped(device, hidinput, field, usage,
>                                          &bit, &max) < 0) {
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 3f94b4954225..e3152155c4b8 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -856,6 +856,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>                         code = BTN_0  + ((usage->hid - 1) & HID_USAGE);
>
>                 hid_map_usage(hi, usage, bit, max, EV_KEY, code);
> +               if (!*bit)
> +                       return -1;
>                 input_set_capability(hi->input, EV_KEY, code);
>                 return 1;
>
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 875f71132b14..c7044a14200e 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -959,34 +959,49 @@ static inline void hid_device_io_stop(struct hid_device *hid) {
>   * @max: maximal valid usage->code to consider later (out parameter)
>   * @type: input event type (EV_KEY, EV_REL, ...)
>   * @c: code which corresponds to this usage and type
> + *
> + * The value pointed to by @bit will be set to NULL if either @type is
> + * an unhandled event type, or if @c is out of range for @type. This
> + * can be used as an error condition.
>   */
>  static inline void hid_map_usage(struct hid_input *hidinput,
>                 struct hid_usage *usage, unsigned long **bit, int *max,
> -               __u8 type, __u16 c)
> +               __u8 type, unsigned int c)
>  {
>         struct input_dev *input = hidinput->input;
> -
> -       usage->type = type;
> -       usage->code = c;
> +       unsigned long *bmap = NULL;
> +       unsigned int limit = 0;
>
>         switch (type) {
>         case EV_ABS:
> -               *bit = input->absbit;
> -               *max = ABS_MAX;
> +               bmap = input->absbit;
> +               limit = ABS_MAX;
>                 break;
>         case EV_REL:
> -               *bit = input->relbit;
> -               *max = REL_MAX;
> +               bmap = input->relbit;
> +               limit = REL_MAX;
>                 break;
>         case EV_KEY:
> -               *bit = input->keybit;
> -               *max = KEY_MAX;
> +               bmap = input->keybit;
> +               limit = KEY_MAX;
>                 break;
>         case EV_LED:
> -               *bit = input->ledbit;
> -               *max = LED_MAX;
> +               bmap = input->ledbit;
> +               limit = LED_MAX;
>                 break;
>         }
> +
> +       if (unlikely(c > limit || !bmap)) {
> +               pr_warn_ratelimited("%s: Invalid code %d type %d\n",
> +                                   input->name, c, type);
> +               *bit = NULL;
> +               return;
> +       }
> +
> +       usage->type = type;
> +       usage->code = c;
> +       *max = limit;
> +       *bit = bmap;
>  }
>
>  /**
> @@ -1000,7 +1015,8 @@ static inline void hid_map_usage_clear(struct hid_input *hidinput,
>                 __u8 type, __u16 c)
>  {
>         hid_map_usage(hidinput, usage, bit, max, type, c);
> -       clear_bit(c, *bit);
> +       if (*bit)
> +               clear_bit(usage->code, *bit);
>  }
>
>  /**
> --
> 2.27.0
>

