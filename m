Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBAD2E0D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgLVQmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgLVQmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:42:37 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E324C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 08:41:57 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i7so8705814pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 08:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xcAHW0XBCyUGubD++/OVWBJA5lPhprCBQF9D05n+MI=;
        b=BX0G3WyK1dfrzWtYs4Z6SUG9+r6N8uOuIxQpfrWqGbpeqaMOpG5/04cJQGiT3d9vAD
         QpkY14Q/R0crgbtoaadRnFGof6sczgtA3/mQigkWIUQfvwbpKG6oxlNlzfGc/neVodly
         Nk7Amu3ZyeMz3Qeslo/cTk482BsB2dXH/Pwk9N4c2uXZlwBcZfV1Rm8Nv4QB2fUS/sa2
         7Sp6loUGG5qGV3J+Bp30hPjInuwl0ZLxC0eN2oc2Icdk42ZmnhVUxVHPsaMaWFqh/eDJ
         +6vtekmV/QD/P2qC1Tw8GN0dQtIZ65hzlJp5YsfLTtEZJo9OLd4wpIPVjtKEN/KBHjvq
         6C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xcAHW0XBCyUGubD++/OVWBJA5lPhprCBQF9D05n+MI=;
        b=MG4O0FCiN7G/6tOoBvoEGBjTKVKjQvoVMVVtqB/f9cEWq48mdpfr8l8e4T1lvndNdA
         Uh9dhbLpgkWKtPctjXdGsSXNtd7SFBvPPEIbIqpHcvhfZLSX3OhE3PfvOLg3qtJOmk6W
         Ywe+vjbipxeG4NvTnOTSQZkNjsswud3dw1PT7PT/IsOJZgvcZhake6A6N6Yu1shcuT0x
         r0pyh/aB/FszBtkJlvvcJHpRph1cp/Au8jW4dQvWXR0/jscZYRGc79AxbLK1rUt/ONaa
         4LEavTGFwinT8duZFo1ZLeRAkW/1J+Z9TkyZyMarpc7aGxyyd1GRdAOjgzuBG6MAaOgX
         PrKQ==
X-Gm-Message-State: AOAM530MFe235HacFHxRSvsX2RddQ/5h062Hx3ilgj6UAnxsxDD3QhWt
        owlsECs23aJKGMQbPU8U/1lczV1H0grOgC5Qu9dgZg==
X-Google-Smtp-Source: ABdhPJw/oiTxxOPfcDoKXuyGtxsBCVwI1p6WYXr+n7mhIIfjr0tV8CwKPD2wC2UV4ncGjs1M/kJvEi7d7C5OsSTQqO4=
X-Received: by 2002:a63:220b:: with SMTP id i11mr20732958pgi.2.1608655316551;
 Tue, 22 Dec 2020 08:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20201222073855.98490-1-jhp@endlessos.org>
In-Reply-To: <20201222073855.98490-1-jhp@endlessos.org>
From:   Chris Chiu <chiu@endlessos.org>
Date:   Wed, 23 Dec 2020 00:41:45 +0800
Message-ID: <CAB4CAwfFQrMDYuzjL2nuUnHgXO031ty-mA7GGxW+-nHFkZTGTg@mail.gmail.com>
Subject: Re: [PATCH] HID: Add Wireless Radio Control feature for Chicony devices
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

On Tue, Dec 22, 2020 at 3:41 PM Jian-Hong Pan <jhp@endlessos.org> wrote:
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
> ---
>  drivers/hid/hid-chicony.c | 58 +++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h     |  1 +
>  2 files changed, 59 insertions(+)
>
> diff --git a/drivers/hid/hid-chicony.c b/drivers/hid/hid-chicony.c
> index 3f0ed6a95223..aca963aa0f1e 100644
> --- a/drivers/hid/hid-chicony.c
> +++ b/drivers/hid/hid-chicony.c
> @@ -21,6 +21,42 @@
>
>  #include "hid-ids.h"
>
> +#define KEY_PRESSED                    0x01
> +#define CH_WIRELESS_CTL_REPORT_ID      0x11
> +
> +static int ch_report_wireless(struct hid_report *report, u8 *data, int size)
> +{
> +       struct hid_device *hdev = report->device;
> +       struct input_dev *input;
> +
> +       if (report->id != CH_WIRELESS_CTL_REPORT_ID ||
> +           report->maxfield != 1 ||
> +           *report->field[0]->value != KEY_PRESSED)

Maybe replace this line with hid_check_keys_pressed() and the KEY_PRESSED
is not required.

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
> @@ -77,10 +113,30 @@ static __u8 *ch_switch12_report_fixup(struct hid_device *hdev, __u8 *rdesc,
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
> @@ -91,6 +147,8 @@ static struct hid_driver ch_driver = {
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
