Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481282CEA56
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgLDI6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgLDI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:58:37 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E783C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 00:57:57 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id z10so4541829ilu.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XmQjhzYNqgYZKImG2frkG1lyoH5e3l99E8yp4cXqbzc=;
        b=Rl9cs+dxyTbnMogdfA4TKp9g1jJVoy0vyFvk7aco83cP8exhCMI6tOc1Ug/PL50D9Q
         YE9hcHMa+RbKwwGPagyW0FE2TmEg0Y187GgZaSmcTCSQy0ayryDs8jDPubaLM6fg1upw
         YPPP/gtL5NhRuuZw8WL8Vw1J5WcANY2yvSOEbpIzBdZ+1ZE/P7ktp5JZsw/s2eFR3hjF
         AkPqjrI+S/Oc+H/v9TwTOQ/1rxI5s8/l55aH//NlVnvQ7iTtUid2dolKjgJqmvT75vs/
         caDHCTYz3Uyo0dEkunIew7hAgd9k6sdwcvkib3zOZplOYUuMTvrEZ5Sr7GIoIaYxQe3Y
         WTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XmQjhzYNqgYZKImG2frkG1lyoH5e3l99E8yp4cXqbzc=;
        b=QXHfd44it+P3RIBqPDzjaTESOr6ojHzrjyooxQRN6gNpjq75YJaUpXfRLCgEt3o5O7
         IHLbpt6kFc3rKZlCxz0Wa4O78vVL/LSnMvfFOjxjMX/pEMGoxKgoFTcFX4kTheawCZdI
         eFaxGX9/ESUxPLjzCe1bxTkCC6fRrEJ2fqo/VXwnSvMgOdeQi0prfZpLxyavk2TudCAE
         cGVu4zzeOIfMJjbp/TBvynQIIdVTfN4fzqC3510GaV9u+rX2GiQMjwDZdUMg6nl1Olea
         i9GlUu5pyFBwfUfipekUguhO1IOKcc52bDtbd/8a4V5z8pnGFdoEBLdlqeGLk+8+CgFd
         XSFg==
X-Gm-Message-State: AOAM531SuUVx6kqYW0xqaqyJvcI0YHerCMuSPCY5rKeOMPcKrTT3AnLe
        UMi+9y6R93Jhb+UvCtVvRxlsWl7P4bkAkUanXhgRFw==
X-Google-Smtp-Source: ABdhPJyfNbyd9YDuWkH1Fb7q5huunpM0zX4sCUACLW6U4Ts+ZB6wLIK6lHlD7+aZFvwwSVYOO3JnVKzPOXx5XyyKywc=
X-Received: by 2002:a92:6403:: with SMTP id y3mr5123195ilb.72.1607072276519;
 Fri, 04 Dec 2020 00:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20201204083624.2711356-1-arnd@kernel.org>
In-Reply-To: <20201204083624.2711356-1-arnd@kernel.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 4 Dec 2020 16:57:45 +0800
Message-ID: <CA+Px+wVYCp=x1_zPkmgd3LLYH=wp1yYHCHZbuT4ecMgPCuYXMA@mail.gmail.com>
Subject: Re: [PATCH] [v2] ASoC: cros_ec_codec: fix uninitialized memory read
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 4:36 PM Arnd Bergmann <arnd@kernel.org> wrote:
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index 58894bf47514..6ec673573c70 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -348,7 +348,7 @@ static int i2s_rx_event(struct snd_soc_dapm_widget *w,
>         }
>
>         return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
> -                                   (uint8_t *)&p, sizeof(p), NULL, 0);
> +                                   &p.cmd, sizeof(p.cmd), NULL, 0);
>  }

I would prefer your v1.

Reasons:
1. The change is not just kernel related.
There is a EC (embedded controller) firmware to collaborate with the
code.  The firmware doesn't know the kernel only copies the first byte
of the packet (at least for now).  See
https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/common/audio_codec_i2s_rx.c#120.

2. We don't copy partial packets in a EC host command.
IMHO, it is also not a big deal if copying a few unused bytes in the packet.
