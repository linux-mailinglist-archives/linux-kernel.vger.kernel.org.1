Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC54E2CE994
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgLDI3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:29:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgLDI3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:29:09 -0500
X-Gm-Message-State: AOAM530pPy1UhylqktQmBvlFwA1raLdYzVhHE07EUZgdMYDUS2PPqdDU
        CFaYahFwDhgdYyK7dbnuOjPtJJboE4u2dNVcsuQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607070508;
        bh=BFz3wtlydRdBCLt2TC7R8FQN/cjuYB3BQdmcqZcvaC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sMUOuwpM1mjcyB7jBZde6GKfioq7mpVZo5v2qaWgUQtGD59LKTyMibetZjT1GsYuX
         4EZLfWSZOn5qjOPyHIEuLcJafyb6qkJs7df/PlKByeJb0je+jekrRBAgLF1YiOU5ox
         lbccItDj6OuOoJ2qZxVymeUSrf/1tBw1MFeHHFAmBx/RS3ytoXjPtUXoBDsdsY9/HD
         LsrEAKc38CQ3mQM2lYlDcafO0jmukrpx4dURW9sXQ4xIfPKvNpE9KsmE1sVEqX7MQ/
         xEen1CaZcc0793EA789I3/O2/dgt/hN5OQrjdTXjEK6rHzEzP3NsD1P9Ak+0VfdlxB
         GlpAdWZCQAHLQ==
X-Google-Smtp-Source: ABdhPJxHBJQFwzULk9x5VQBenjJYD648I/eZ8dzgx9dnZcZOXrI7Q96m0GQGG2BEeb+MJg4Vyh9/QLizXMl6+0QMev0=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr2769894otk.251.1607070508028;
 Fri, 04 Dec 2020 00:28:28 -0800 (PST)
MIME-Version: 1.0
References: <20201203225458.1477830-1-arnd@kernel.org> <CA+Px+wWmJrS46TzWgKWiufJH7ryB+mOH7H4xfGZex2j=NutfLA@mail.gmail.com>
In-Reply-To: <CA+Px+wWmJrS46TzWgKWiufJH7ryB+mOH7H4xfGZex2j=NutfLA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 4 Dec 2020 09:28:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3qrPa0Jue-eLrXn+ufBsvY4+UQr7SQ9ZHxuEMtvoYMhA@mail.gmail.com>
Message-ID: <CAK8P3a3qrPa0Jue-eLrXn+ufBsvY4+UQr7SQ9ZHxuEMtvoYMhA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: cros_ec_codec: fix uninitialized memory read
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
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 3:56 AM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Fri, Dec 4, 2020 at 6:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > gcc points out a memory area that is copied to a device
> > but not initialized:
> >
> > sound/soc/codecs/cros_ec_codec.c: In function 'i2s_rx_event':
> > arch/x86/include/asm/string_32.h:83:20: error: '*((void *)&p+4)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >    83 |   *((int *)to + 1) = *((int *)from + 1);
> >
> > Initialize all the unused fields to zero.
> >
> > Fixes: 727f1c71c780 ("ASoC: cros_ec_codec: refactor I2S RX")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Tzung-Bi Shih <tzungbi@google.com>
>
> In the case in i2s_rx_event(), only the "cmd" member is used.  But it
> is fine to please the compiler.

I wouldn't do it just to please the compiler. I sent this patch since
the code clearly copies the uninitialized data here. If only
one byte is meant to be copied, then we should change the
function call to not pass the entire structure. I'll send a new
patch for that.

> struct __ec_align4 ec_param_ec_codec_i2s_rx {
>         uint8_t cmd; /* enum ec_codec_i2s_rx_subcmd */
>         uint8_t reserved[3];
>
>         union {
>             ...
>         };
> };
>
> I am a bit curious about, in other use cases of
> ec_param_ec_codec_i2s_rx, why the compiler doesn't complain about
> uninitialization of the "reserved" member?

The -Wmaybe-uninitialized warning is fundamentally unreliable.
In this case, the __constant_memcpy() function accesses the
members one at a time, and the warning is for the first 'int' array
member that is completely uninitialized, while the 'reserved'
part of the structure is still in the first 'int' that is partially initialized.

      Arnd
