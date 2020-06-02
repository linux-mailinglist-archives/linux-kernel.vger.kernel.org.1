Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A8E1EBB27
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 14:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgFBMDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 08:03:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34116 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:03:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id b8so1133625oic.1;
        Tue, 02 Jun 2020 05:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncUahkMlR8RcEuHvwU1aMqYYdzOJso8KWIzaPU8BmKE=;
        b=YJI96lvZWvEQJhFCPrr4+u3xqwrNH/GZ7NwXKnjdCo6taR87HruLU3e07Pp712E17i
         ADEqXKwaryfOkQ/0WxZCwsmLwa0GuRrIarsbI06e6kdPXhpohTIBrW16HYNOImpYbczc
         TBfk9esqiq6N4R8JrHlKxvLommxtjxOWuU2Kp5d8z+1mur/cgkvM242+J6iXLfasz3wu
         XkJ9EtWPUhURYDQ99R9v6B/vX00Fp1NCy5TtyWRl5+r22eNW/nkNzT2+vsSwrtNnbCRt
         f63K5q/FX5kGQPE8+wvvYWvv8udPcTdDt4jH9fNSzOUhgslDeqzUQMn+M9EWve7oQdwH
         qi7A==
X-Gm-Message-State: AOAM531EJYFk3N+omIqsc8R6VPWG9+zN41o3Wka//CNqSccThnW6znLW
        lLG3LttthqmWSLyC82BPSdLLkhyq3IjNCbzTHIc=
X-Google-Smtp-Source: ABdhPJzEcQPMgPom1yIf3zWleRm3zOSF/oQgx5/HyuKONRP9TVyRubZN2n1LbmblaEecYiJrxwiFTA/boKIBcGBzwjs=
X-Received: by 2002:aca:644:: with SMTP id 65mr2609554oig.148.1591099404240;
 Tue, 02 Jun 2020 05:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com> <767d36ff-22ec-8136-7ebc-1d9d0d3ac98d@samsung.com>
In-Reply-To: <767d36ff-22ec-8136-7ebc-1d9d0d3ac98d@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Jun 2020 14:03:12 +0200
Message-ID: <CAMuHMdWac+YE3qr0CTepn5K24tGZq0VHuQDGg-yUOHW1rJDbbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] video: fbdev: amifb: add FIXME about dead APUS support
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 1:50 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On 5/14/20 10:21 PM, Geert Uytterhoeven wrote:
> > These #ifdefs are relics from APUS (Amiga Power-Up System), which
> > added a PPC board.  APUS support was killed off a long time ago,
> > when arch/ppc/ was still king, but these #ifdefs were missed, because
> > they didn't test for CONFIG_APUS.
>
> Add FIXME about using the C code variants (APUS ones) in the future.
>
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
