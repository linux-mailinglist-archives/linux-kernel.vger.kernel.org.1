Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9E2CEA8C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgLDJMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:12:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbgLDJMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:12:48 -0500
X-Gm-Message-State: AOAM533eQRmps6nPP+bV6XDxMQOzYe01tXz4xPLf0YfI5cINATJ5xexV
        iZi9JMuVv4YZrLvMyZO5BUNAVijCZKs36zrgKbg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607073127;
        bh=JmG8FBaTzbt/kYkShldS7G1ItAyjwRZb31/e3OGqfUM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CY2MOA8pzaahG6laGVMt7huzhQHFwtUjxBSMMrv0kH/aeQQ4gl4p/l9Tn1DLIEei+
         GiR+Iw8c+zK289IuEfzp6egRvS/qo6Q3bHxZu2MdqYB3Z8MtS701RI7ROMWFI0GGcU
         hCxqAuOybA8BksUepjYRlg3rVyziuspg1+bnTQf1/0fdgwZC2X4ALoZowsgfDZxi+E
         rcle56e4VmEffS+uSNJHQhqh04jH9WsfMU2QOyqCSl/phHvlNB+kx3N74XqJ+SFhjE
         dc9lkbmBmh0RobWETDm9q9g4nEfjw5ChAEPiCxHVvDppULs/1sMjRgoa4GjhDR7QsS
         XfSaYWil8yp9A==
X-Google-Smtp-Source: ABdhPJxE5YcToNs/naZOB0pqVvNjNVeYst+MYN/gRehfo8nYfGYKjmuMOWvelXELXZ/AfJWI2lV13OfDu5hEncMg/m4=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr2436708oib.67.1607073126708;
 Fri, 04 Dec 2020 01:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20201204083624.2711356-1-arnd@kernel.org> <CA+Px+wVYCp=x1_zPkmgd3LLYH=wp1yYHCHZbuT4ecMgPCuYXMA@mail.gmail.com>
In-Reply-To: <CA+Px+wVYCp=x1_zPkmgd3LLYH=wp1yYHCHZbuT4ecMgPCuYXMA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 4 Dec 2020 10:11:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1t-JhJ73ikf=FZQn1L0AbT3e=e7zJGkOMvCXky6apj+w@mail.gmail.com>
Message-ID: <CAK8P3a1t-JhJ73ikf=FZQn1L0AbT3e=e7zJGkOMvCXky6apj+w@mail.gmail.com>
Subject: Re: [PATCH] [v2] ASoC: cros_ec_codec: fix uninitialized memory read
To:     Tzung-Bi Shih <tzungbi@google.com>
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

On Fri, Dec 4, 2020 at 9:57 AM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Fri, Dec 4, 2020 at 4:36 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> > index 58894bf47514..6ec673573c70 100644
> > --- a/sound/soc/codecs/cros_ec_codec.c
> > +++ b/sound/soc/codecs/cros_ec_codec.c
> > @@ -348,7 +348,7 @@ static int i2s_rx_event(struct snd_soc_dapm_widget *w,
> >         }
> >
> >         return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
> > -                                   (uint8_t *)&p, sizeof(p), NULL, 0);
> > +                                   &p.cmd, sizeof(p.cmd), NULL, 0);
> >  }
>
> I would prefer your v1.
>
> Reasons:
> 1. The change is not just kernel related.
> There is a EC (embedded controller) firmware to collaborate with the
> code.  The firmware doesn't know the kernel only copies the first byte
> of the packet (at least for now).  See
> https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/common/audio_codec_i2s_rx.c#120.
>
> 2. We don't copy partial packets in a EC host command.
> IMHO, it is also not a big deal if copying a few unused bytes in the packet.

Ok, so if the EC does access the uninitialized data, then it is indeed
better to initialize it to zero as I first thought.

      Arnd
