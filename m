Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE17F21338B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 07:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgGCFeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 01:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCFd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:33:59 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C04BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 22:33:59 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d15so26571335edm.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 22:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vr5c0L1rLWCP9M1VAYm/mEwO9A0z23CicG6nUFMruNQ=;
        b=C0tiH8s1cuWq04m/sVyKw6ARueRXh9QIK/mxxpbLBcssWeBQV2/qKi7GTQMfxDZIsK
         Al4Pg6HsFLz+VfvzekOfSybi8s0LCDgHm+u4PAXQqJKMHSBnUeUF03s14TXRz0JDDSvj
         PlquAQARdIoU3uiOyr61TBsqp9ArwIrnnviwfIlS1kb4ySpr8QZZTfy0fbqWAQsr6h9W
         t/zrEsoGc8Rp3KZqodhyVRleLixQp6HMcvFP7sG3xFVbdkQ9BiC60Jf44E3+jGp0LgKC
         jv1eKsEDGfwjDr92axHRg4/76uY59PuNK8JUDnIHRyeGf4JvutpeXQeBLXjqk7VhiE3Q
         UDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vr5c0L1rLWCP9M1VAYm/mEwO9A0z23CicG6nUFMruNQ=;
        b=QNPUPnZZFO+Va2yOIkuCo2amTyO+3STT6BhLrmvQdzo09490u1pz8BBVqWP6bgutTP
         WAkZ8abgUtzW/zranIYixKlFlFx2xKf95f/Ebc4O+N0TBK1TXJfCCgFt8CygaAl4rA4m
         FUJTIdLwPbSL85qqfTn6HCaA6OUKK8pFz54hlM5I+YCNthy6ijTdCnSZ2QLIHCXf3e/o
         Xu2Y9HQSu3TUKRS1ST/TS5aPhuvCkj2ixYFlKyMW9RWXG9hQQvFTWXJ4c+Ttna7DjLUi
         aqlzegwYjUB2Er2/YSNmxp+q+XMVXNIDp2F2fkhMgK1Bok2oiYo3tcHdV9TXCo0QyO3/
         4cWQ==
X-Gm-Message-State: AOAM531eDK8fPzfz8djiTTTI9RUfxxmXIr4Q47Mx2uh8W4PElJeNOoyo
        O/m+6+BKliqluMFRHG8eCIBwCTX40Oa7Sv2C9q6tyw==
X-Google-Smtp-Source: ABdhPJzAeLBC6ue2bO19iEG+xcUUJ6HFdGxGHSzpvhD0HMJhUwMC47/S3rC5UCdKAqz2bgjKGzKGAPViC3TTpACt+fY=
X-Received: by 2002:a05:6402:16db:: with SMTP id r27mr39373377edx.139.1593754437656;
 Thu, 02 Jul 2020 22:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200703032948.2185290-1-yuhsuan@chromium.org>
In-Reply-To: <20200703032948.2185290-1-yuhsuan@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 2 Jul 2020 22:33:46 -0700
Message-ID: <CABXOdTezM+N+kO=BYTggfDvCyqBtQzYzVEZtrd183VUYP6KwKA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: cros_ec_codec: Log results when EC commands fail
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 8:30 PM Yu-Hsuan Hsu <yuhsuan@chromium.org> wrote:
>
> Log results of failed EC commands to identify a problem more easily.
>
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> ---
>  sound/soc/codecs/cros_ec_codec.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index 8d45c628e988e..a4ab62f59efa6 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -90,10 +90,17 @@ static int send_ec_host_command(struct cros_ec_device *ec_dev, uint32_t cmd,
>         if (outsize)
>                 memcpy(msg->data, out, outsize);
>
> -       ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> +       ret = cros_ec_cmd_xfer(ec_dev, msg);

This change isn't explained in the description.

Guenter

>         if (ret < 0)
>                 goto error;
>
> +       if (msg->result != EC_RES_SUCCESS) {
> +               dev_err(ec_dev->dev, "Command %d failed: %d\n", cmd,
> +                       msg->result);
> +               ret = -EPROTO;
> +               goto error;
> +       }
> +
>         if (insize)
>                 memcpy(in, msg->data, insize);
>
> --
> 2.27.0.212.ge8ba1cc988-goog
>
