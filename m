Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D651DF9BF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 19:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbgEWRqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 13:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387660AbgEWRqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:46:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A2BC061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:46:09 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f83so13883675qke.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=EO/OR4syNWfvjvjOkotRTz4hRW+RKtwkmV3zC1m0SIM=;
        b=sVMJAxz/VSFAlXU3/Em+EJ3ay23sqsHG5avMclNOcfBGWjOSxKa3xcAG/MjUaUkO8w
         IRDxcpyWX7jjmjVGkfZs9uEVV0F8QHkKsvIJbg06BL+S3Qs7M+Bw77NCjV8I5I7N94+N
         M7/WTkB9rpM10DkYKEWGlUPwFi/KwZHDjRv7E9JEgv2cXteoRGt0SQB+BeY+Z9G5JbIT
         Rmk2y6VpdnmJJmIb9wC1jIaFQ9Ehgztq6t7mFklRAsII+LxlRcaO9ZNm7GssaPGlFQq2
         I7zUTdS78MzxKCWyyt1jYwjtLfMGYoVubuNsA2zr/jy9mF1mxySou/pkbmCEp+m8QVvn
         RokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=EO/OR4syNWfvjvjOkotRTz4hRW+RKtwkmV3zC1m0SIM=;
        b=o0ZQ5o3ifwpeWm+aCB9Km23e2k6E3eUhrfw/fbHT8RJwRP4S5zyOswkHGMa2/ftwlY
         7Dl6sDEdhqDuUk0Q+N2WCfpdMENZL4SMu37zj8y4Ba2CSmgdlk5aul8RVNpG2ZpPCe5y
         baP2Ptp1nhCFivGLqTC9Etz0uUaN33ZDX/Ct9bKSaCr3CoqMBSYANFKuT0zm1bUI7tcx
         zSh559pdv0HTQPdec1iuKMY3ZcUwZKE6MGQGLXE9GXTLAONo+gPe9g+UUwvvFDUF2dMq
         7+rjw/zBKvGWXKgQBMFo0+VEwC9DajQmv+yjmMz7MfbshfcRDHTte7rFeI6D494KkxBy
         nElA==
X-Gm-Message-State: AOAM5317fS+Cy172iWVSa7URKShu+1elrGlMy7Wf976TfKRpq7OY4Th1
        C7ZjlZRqrTNuhopPVHqirtwVCLGbRztTTi9eX1xVbQ==
X-Google-Smtp-Source: ABdhPJyvvBtLzzl9xdq8BURmgbhoO+JugQTQqZSScg/GlQVS1GIax5Fn88q4O2ETOmGlWTe62speKivX7jnnuH99KrY=
X-Received: by 2002:a37:2f86:: with SMTP id v128mr20362352qkh.413.1590255967402;
 Sat, 23 May 2020 10:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200523173903.5136-1-anarsoul@gmail.com>
In-Reply-To: <20200523173903.5136-1-anarsoul@gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sat, 23 May 2020 10:45:41 -0700
Message-ID: <CA+E=qVcCx2DAnjfWtKwmgSYVCZ4svT-fKFyzhqdTK7-Ooz3KqA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: line6: add hw monitor volume control for POD HD500
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Allison Randal <allison@lohutok.net>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 10:39 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> Add hw monitor volume control for POD HD500. The same change may
> work for HD500X but I don't have it to test.

Ugh, found a bug in it right after sending (value is clamped to
ARRAY_SIZE() while should be to ARRAY_SIZE()-1)

Please discard this patch, I'll send v2 shortly.

> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  sound/usb/line6/driver.c |   3 +-
>  sound/usb/line6/driver.h |   4 ++
>  sound/usb/line6/podhd.c  | 124 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 129 insertions(+), 2 deletions(-)
>
> diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
> index 7629116f570e..597a36c0a51d 100644
> --- a/sound/usb/line6/driver.c
> +++ b/sound/usb/line6/driver.c
> @@ -97,7 +97,7 @@ static void line6_stop_listen(struct usb_line6 *line6)
>  /*
>         Send raw message in pieces of wMaxPacketSize bytes.
>  */
> -static int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
> +int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
>                                   int size)
>  {
>         int i, done = 0;
> @@ -132,6 +132,7 @@ static int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
>
>         return done;
>  }
> +EXPORT_SYMBOL(line6_send_raw_message);
>
>  /*
>         Notification of completion of asynchronous request transmission.
> diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
> index 1a4e3700c80c..62c686bed0ca 100644
> --- a/sound/usb/line6/driver.h
> +++ b/sound/usb/line6/driver.h
> @@ -108,6 +108,8 @@ enum {
>         LINE6_CAP_CONTROL_MIDI = 1 << 4,
>         /* device provides low-level information */
>         LINE6_CAP_CONTROL_INFO = 1 << 5,
> +       /* device provides hardware monitoring volume control */
> +       LINE6_CAP_HWMON_CTL =   1 << 6,
>  };
>
>  /*
> @@ -185,6 +187,8 @@ extern int line6_read_data(struct usb_line6 *line6, unsigned address,
>                            void *data, unsigned datalen);
>  extern int line6_read_serial_number(struct usb_line6 *line6,
>                                     u32 *serial_number);
> +extern int line6_send_raw_message(struct usb_line6 *line6,
> +                                       const char *buffer, int size);
>  extern int line6_send_raw_message_async(struct usb_line6 *line6,
>                                         const char *buffer, int size);
>  extern int line6_send_sysex_message(struct usb_line6 *line6,
> diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
> index e39dc85c355a..a40115625c01 100644
> --- a/sound/usb/line6/podhd.c
> +++ b/sound/usb/line6/podhd.c
> @@ -11,6 +11,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <sound/core.h>
> +#include <sound/control.h>
>  #include <sound/pcm.h>
>
>  #include "driver.h"
> @@ -37,6 +38,9 @@ struct usb_line6_podhd {
>
>         /* Firmware version */
>         int firmware_version;
> +
> +       /* Monitor level */
> +       int monitor_level;
>  };
>
>  #define line6_to_podhd(x)      container_of(x, struct usb_line6_podhd, line6)
> @@ -250,6 +254,115 @@ static void podhd_disconnect(struct usb_line6 *line6)
>         }
>  }
>
> +static const unsigned int float_zero_to_one_lookup[] = {
> +0x00000000, 0x3C23D70A, 0x3CA3D70A, 0x3CF5C28F, 0x3D23D70A, 0x3D4CCCCD,
> +0x3D75C28F, 0x3D8F5C29, 0x3DA3D70A, 0x3DB851EC, 0x3DCCCCCD, 0x3DE147AE,
> +0x3DF5C28F, 0x3E051EB8, 0x3E0F5C29, 0x3E19999A, 0x3E23D70A, 0x3E2E147B,
> +0x3E3851EC, 0x3E428F5C, 0x3E4CCCCD, 0x3E570A3D, 0x3E6147AE, 0x3E6B851F,
> +0x3E75C28F, 0x3E800000, 0x3E851EB8, 0x3E8A3D71, 0x3E8F5C29, 0x3E947AE1,
> +0x3E99999A, 0x3E9EB852, 0x3EA3D70A, 0x3EA8F5C3, 0x3EAE147B, 0x3EB33333,
> +0x3EB851EC, 0x3EBD70A4, 0x3EC28F5C, 0x3EC7AE14, 0x3ECCCCCD, 0x3ED1EB85,
> +0x3ED70A3D, 0x3EDC28F6, 0x3EE147AE, 0x3EE66666, 0x3EEB851F, 0x3EF0A3D7,
> +0x3EF5C28F, 0x3EFAE148, 0x3F000000, 0x3F028F5C, 0x3F051EB8, 0x3F07AE14,
> +0x3F0A3D71, 0x3F0CCCCD, 0x3F0F5C29, 0x3F11EB85, 0x3F147AE1, 0x3F170A3D,
> +0x3F19999A, 0x3F1C28F6, 0x3F1EB852, 0x3F2147AE, 0x3F23D70A, 0x3F266666,
> +0x3F28F5C3, 0x3F2B851F, 0x3F2E147B, 0x3F30A3D7, 0x3F333333, 0x3F35C28F,
> +0x3F3851EC, 0x3F3AE148, 0x3F3D70A4, 0x3F400000, 0x3F428F5C, 0x3F451EB8,
> +0x3F47AE14, 0x3F4A3D71, 0x3F4CCCCD, 0x3F4F5C29, 0x3F51EB85, 0x3F547AE1,
> +0x3F570A3D, 0x3F59999A, 0x3F5C28F6, 0x3F5EB852, 0x3F6147AE, 0x3F63D70A,
> +0x3F666666, 0x3F68F5C3, 0x3F6B851F, 0x3F6E147B, 0x3F70A3D7, 0x3F733333,
> +0x3F75C28F, 0x3F7851EC, 0x3F7AE148, 0x3F7D70A4, 0x3F800000
> +};
> +
> +static void podhd_set_monitor_level(struct usb_line6_podhd *podhd, int value)
> +{
> +       unsigned int fl;
> +       static const unsigned char msg[16] = {
> +               /* Chunk is 0xc bytes (without first word) */
> +               0x0c, 0x00,
> +               /* First chunk in the message */
> +               0x01, 0x00,
> +               /* Message size is 2 4-byte words */
> +               0x02, 0x00,
> +               /* Unknown */
> +               0x04, 0x41,
> +               /* Unknown */
> +               0x04, 0x00, 0x13, 0x00,
> +               /* Volume, LE float32, 0.0 - 1.0 */
> +               0x00, 0x00, 0x00, 0x00
> +       };
> +       unsigned char *buf;
> +
> +       buf = kmalloc(sizeof(msg), GFP_ATOMIC);
> +       memcpy(buf, msg, sizeof(msg));
> +
> +       if (value < 0)
> +               value = 0;
> +
> +       if (value > ARRAY_SIZE(float_zero_to_one_lookup))
> +               value = ARRAY_SIZE(float_zero_to_one_lookup);
> +
> +       fl = float_zero_to_one_lookup[value];
> +
> +       buf[12] = (fl >> 0) & 0xff;
> +       buf[13] = (fl >> 8) & 0xff;
> +       buf[14] = (fl >> 16) & 0xff;
> +       buf[15] = (fl >> 24) & 0xff;
> +
> +       line6_send_raw_message(&podhd->line6, buf, sizeof(msg));
> +       kfree(buf);
> +
> +       podhd->monitor_level = value;
> +}
> +
> +/* control info callback */
> +static int snd_podhd_control_monitor_info(struct snd_kcontrol *kcontrol,
> +                                       struct snd_ctl_elem_info *uinfo)
> +{
> +       uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +       uinfo->count = 1;
> +       uinfo->value.integer.min = 0;
> +       uinfo->value.integer.max = 100;
> +       uinfo->value.integer.step = 1;
> +       return 0;
> +}
> +
> +/* control get callback */
> +static int snd_podhd_control_monitor_get(struct snd_kcontrol *kcontrol,
> +                                      struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
> +       struct usb_line6_podhd *podhd = line6_to_podhd(line6pcm->line6);
> +
> +       ucontrol->value.integer.value[0] = podhd->monitor_level;
> +       return 0;
> +}
> +
> +/* control put callback */
> +static int snd_podhd_control_monitor_put(struct snd_kcontrol *kcontrol,
> +                                      struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
> +       struct usb_line6_podhd *podhd = line6_to_podhd(line6pcm->line6);
> +
> +       if (ucontrol->value.integer.value[0] == podhd->monitor_level)
> +               return 0;
> +
> +       podhd_set_monitor_level(podhd, ucontrol->value.integer.value[0]);
> +       return 1;
> +}
> +
> +/* control definition */
> +static const struct snd_kcontrol_new podhd_control_monitor = {
> +       .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +       .name = "Monitor Playback Volume",
> +       .index = 0,
> +       .access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> +       .info = snd_podhd_control_monitor_info,
> +       .get = snd_podhd_control_monitor_get,
> +       .put = snd_podhd_control_monitor_put
> +};
> +
>  /*
>         Try to init POD HD device.
>  */
> @@ -298,6 +411,15 @@ static int podhd_init(struct usb_line6 *line6,
>                         return err;
>         }
>
> +       if (pod->line6.properties->capabilities & LINE6_CAP_HWMON_CTL) {
> +               podhd_set_monitor_level(pod, 100);
> +               err = snd_ctl_add(line6->card,
> +                                 snd_ctl_new1(&podhd_control_monitor,
> +                                              line6->line6pcm));
> +               if (err < 0)
> +                       return err;
> +       }
> +
>         if (!(pod->line6.properties->capabilities & LINE6_CAP_CONTROL_INFO)) {
>                 /* register USB audio system directly */
>                 return snd_card_register(line6->card);
> @@ -354,7 +476,7 @@ static const struct line6_properties podhd_properties_table[] = {
>                 .id = "PODHD500",
>                 .name = "POD HD500",
>                 .capabilities   = LINE6_CAP_PCM | LINE6_CAP_CONTROL
> -                               | LINE6_CAP_HWMON,
> +                               | LINE6_CAP_HWMON | LINE6_CAP_HWMON_CTL,
>                 .altsetting = 1,
>                 .ctrl_if = 1,
>                 .ep_ctrl_r = 0x81,
> --
> 2.26.2
>
