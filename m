Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017DD2E9943
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbhADPzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbhADPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:55:12 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9537EC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 07:54:31 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 30so14604050pgr.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 07:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GzgRXftPpyvgtjMQlfzhW3qp/IcvYh5XWx/t98tY+ec=;
        b=CSYUkqwgOSEpxslY094j+5yGsTlNoKYN3c2GuQYYmFIVNA6mZCNj9u1RKrKxdgLbDv
         KLo/f9IyuFeT+HQoaAd+7ploErmhTGKMZFbC09Bf3MJAyIlC1ac4nEOCh5O8iZ2j43SW
         vwPc0Q7sA7feMjSN0YE3gItXUj81Wybns9n6VxD8STSgMT8geic+U/15GtrBbJ1xlbAL
         8C21I83X9MWh5P65d5SMldBFnjzMuoTbPKY5aEk8bJhYcMu6aNBmR6oabQS+N6yOeFPz
         /TxDUoLmBt2i8f8/PbO74iRYHi2OJVknXdKFReXfwi7F0Vl0s9yPQ8XVQJ064QOGOWE6
         BoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GzgRXftPpyvgtjMQlfzhW3qp/IcvYh5XWx/t98tY+ec=;
        b=Znxl8VoF66rDLdxO8igiFDXqUL0CEqjCc9HA6IWHs7ljWjkIHk/s9UAv0lIKc0RPPi
         oRxKdGQ4ZmsUXGIb8HEfLqXF2CeLBjwGsm+P9chJyj5gvbek79a0vIun/71XaHl+wBdz
         NamcJm54wVzR/VpmYIVam6Dzh01vU06iIIsK38yhIESFKin7YU97+oaZ5ZUDMRVZQJBf
         3kHWfYS1ktPYULndbjoPAW46INYVenu6jWt8bJkjZXgnpooiqarJmz+4LMKZaEfU/SLX
         gWy87B/Te/AmLFkRbEDEdLMs6XR8muD6TRr2Zf17VCp6DeOSvcvJUJczkRNe/kN/ZqaO
         euxw==
X-Gm-Message-State: AOAM531p5gZbn3hcBxVqPb0C06y1Ys4zrngHDhseQ6PStyu9Bx4yzQP/
        QulW7I7zuhB59MbkYjPiDSZWQXrpjbvtXmABIiabrg==
X-Google-Smtp-Source: ABdhPJwKQI47V7EC0NEx5ABj0zJQf3yInX/8oBwXLJTzw5VTdGYdsLmAKEIqVjO7U0cnL3duiZqOW4LCIi/tPLsO4pk=
X-Received: by 2002:a62:1dd5:0:b029:19d:fc87:5f45 with SMTP id
 d204-20020a621dd50000b029019dfc875f45mr66819183pfd.63.1609775671004; Mon, 04
 Jan 2021 07:54:31 -0800 (PST)
MIME-Version: 1.0
References: <CAB4CAwfFQrMDYuzjL2nuUnHgXO031ty-mA7GGxW+-nHFkZTGTg@mail.gmail.com>
 <20201223055540.204685-1-jhp@endlessos.org>
In-Reply-To: <20201223055540.204685-1-jhp@endlessos.org>
From:   Chris Chiu <chiu@endlessos.org>
Date:   Mon, 4 Jan 2021 23:54:18 +0800
Message-ID: <CAB4CAwdkv7ZetCF0s4LR7cderJfm9-jaeLOYEYO4r1FbvQ3xPQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: Add Wireless Radio Control feature for Chicony devices
To:     Jian-Hong Pan <jhp@endlessos.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 1:57 PM Jian-Hong Pan <jhp@endlessos.org> wrote:
>
> Some Chicony's keyboards support airplane mode hotkey (Fn+F2) with
> "Wireless Radio Control" feature. For example, the wireless keyboard
> [04f2:1236] shipped with ASUS all-in-one desktop.
>
> After consulting Chicony for this hotkey, learned the device will send
> with 0x11 as the report ID and 0x1 as the value when the key is pressed
> down.
>
> This patch maps the event as KEY_RFKILL.
>
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Reviewed-by: Chris Chiu <chiu@endlessos.org>
> ---
> v2: Remove the duplicated key pressed check.
>
>  drivers/hid/hid-chicony.c | 55 +++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h     |  1 +
>  2 files changed, 56 insertions(+)
>
> diff --git a/drivers/hid/hid-chicony.c b/drivers/hid/hid-chicony.c
> index 3f0ed6a95223..ca556d39da2a 100644
> --- a/drivers/hid/hid-chicony.c
> +++ b/drivers/hid/hid-chicony.c
> @@ -21,6 +21,39 @@
>
>  #include "hid-ids.h"
>
> +#define CH_WIRELESS_CTL_REPORT_ID      0x11
> +
> +static int ch_report_wireless(struct hid_report *report, u8 *data, int size)
> +{
> +       struct hid_device *hdev = report->device;
> +       struct input_dev *input;
> +
> +       if (report->id != CH_WIRELESS_CTL_REPORT_ID || report->maxfield != 1)
> +               return 0;
> +
> +       input = report->field[0]->hidinput->input;
> +       if (!input) {
> +               hid_warn(hdev, "can't find wireless radio control's input");
> +               return 0;
> +       }
> +
> +       input_report_key(input, KEY_RFKILL, 1);
> +       input_sync(input);
> +       input_report_key(input, KEY_RFKILL, 0);
> +       input_sync(input);
> +
> +       return 1;
> +}
> +
> +static int ch_raw_event(struct hid_device *hdev,
> +               struct hid_report *report, u8 *data, int size)
> +{
> +       if (report->application == HID_GD_WIRELESS_RADIO_CTLS)
> +               return ch_report_wireless(report, data, size);
> +
> +       return 0;
> +}
> +
>  #define ch_map_key_clear(c)    hid_map_usage_clear(hi, usage, bit, max, \
>                                         EV_KEY, (c))
>  static int ch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> @@ -77,10 +110,30 @@ static __u8 *ch_switch12_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>         return rdesc;
>  }
>
> +static int ch_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +       int ret;
> +
> +       hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
> +       ret = hid_parse(hdev);
> +       if (ret) {
> +               hid_err(hdev, "Chicony hid parse failed: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +       if (ret) {
> +               hid_err(hdev, "Chicony hw start failed: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
>
>  static const struct hid_device_id ch_devices[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS2) },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS3) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_ACER_SWITCH12) },
>         { }
>  };
> @@ -91,6 +144,8 @@ static struct hid_driver ch_driver = {
>         .id_table = ch_devices,
>         .report_fixup = ch_switch12_report_fixup,
>         .input_mapping = ch_input_mapping,
> +       .probe = ch_probe,
> +       .raw_event = ch_raw_event,
>  };
>  module_hid_driver(ch_driver);
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 4c5f23640f9c..06d90301a3dc 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -270,6 +270,7 @@
>  #define USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE 0x1053
>  #define USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE2        0x0939
>  #define USB_DEVICE_ID_CHICONY_WIRELESS2        0x1123
> +#define USB_DEVICE_ID_CHICONY_WIRELESS3        0x1236
>  #define USB_DEVICE_ID_ASUS_AK1D                0x1125
>  #define USB_DEVICE_ID_CHICONY_TOSHIBA_WT10A    0x1408
>  #define USB_DEVICE_ID_CHICONY_ACER_SWITCH12    0x1421
> --
> 2.29.2
>
