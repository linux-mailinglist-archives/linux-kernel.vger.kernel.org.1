Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A62AE54F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbgKKBIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbgKKBIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:08:37 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4E7C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:08:36 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id dk16so408129ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hHQDiEVFp1foYy6daRs4fHFD9ayYaszDLVuF2Z51ya8=;
        b=Lovjln1fIbkD2LOWfwf5p5B1YNXCK0mWG+9fGH4sigwtycevhDKQ0AeODjSfHWpjwF
         iNdy65rI1Wq5x2Grg8/Relh95qlXkU51w/ZD0lb9LhW7+fZEozkHk34DrT0UMCUN6cZK
         iPllHOzKkEliSAK+mJhJhzW+6hAXS8kRfEc/mBC9gPXCg/l/b8iy2GV7cFhZDAUD+UIi
         j4prnHj/aTGgJC/9VBDvxk8HE9lsb0hdMkmXEc2OhmWjr10S6kulM4D/D/k2NonVfPgX
         1Uj1X6kTPhq9mHhJF+/r4mwzp3aPzJFUKDSUdlBWYLIeWryBNUUdb8Mdv+M7VDq8KMqv
         Mbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hHQDiEVFp1foYy6daRs4fHFD9ayYaszDLVuF2Z51ya8=;
        b=HshU1EvqTuj00WvVxSGazLRKhlp6aYKqSAiD0bIPJaULPZIwSxeUDBwvcmDyuqGyw3
         dJAsfIXVTBDvxmu/p+AZnAWF4RSSTmcnpL8s/tbNB1xuNT/Djs2h2D4vqIYBS3dA9geZ
         ULTsRjvG3oY3DJ3cQ6ZriuAYv20GJDiTZnOhryWhDZRftk6zyX9/mIurGg3/NipFlhtn
         145Ze3pHoOyNQJQ7RAS+k5rODUFIRpOqXdJ2yjvUblK8ny4t5UcAyk3dThxnulYYdQUW
         PgKr6qF0blFyLGBF0tA5PBf4hLLUGsCQyq9yvCeuzRAXMBM1GaEqVv9o3H2AWVWSvaY4
         OwUA==
X-Gm-Message-State: AOAM532EX/AaoaPFMsbGSJlGY2ozxz4w2JExkylHDoU4oM4F1Q4l7y3c
        jkpXiozvhf34jT9zSuaDaS+eolxxnvFmQt1oPk+Wzg==
X-Google-Smtp-Source: ABdhPJxTkNCrHxkNrKMGfx/redHh8XOwE0W/+nPr1awBqj+Z+Er5yh4soUAWZNDAv2tGIUavyTgUj5FavxbQfUNMpTU=
X-Received: by 2002:a17:906:3541:: with SMTP id s1mr23454310eja.413.1605056913762;
 Tue, 10 Nov 2020 17:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20201109162244.16531-1-linkmauve@linkmauve.fr>
In-Reply-To: <20201109162244.16531-1-linkmauve@linkmauve.fr>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 10 Nov 2020 22:08:21 -0300
Message-ID: <CAAEAJfDhQpZYRMQoQRy=2AUSQFpmy2cQ4y=2sczWgkDp03dYEw@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/2] media: uapi: Expose VP8 probability lengths as defines
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emmanuel,

Thanks for the patch.

On Mon, 9 Nov 2020 at 15:37, Emmanuel Gil Peyrot <linkmauve@linkmauve.fr> w=
rote:
>
> These values will be used by various drivers implementing the VP8
> stateless API.
>
> This had been suggested by Ezequiel Garcia for the Cedrus VP8 driver.
>
> The only driver using this API (until now) has also been updated to use
> these new defines.
>
> This is a resend because I forgot to include most maintainers, sorry for
> that.  It=E2=80=99s my very first patch to the kernel, I didn=E2=80=99t k=
now about
> scripts/get_maintainers.pl
>

I haven't validated these two patches, but on a first look,
it seems it's a low-hanging fruit nice cleanup. Thanks for that!

Since it seems you are looking for interesting things to contribute,
note that the vp8-ctrls.h header is lacking some nice documentation
on each structure.

This should be done by looking at the VP8 syntax spec and documenting
things appropriately. See how it's done for H.264 and VP9:

https://patchwork.linuxtv.org/project/linux-media/patch/20200928201433.3270=
68-1-ezequiel@collabora.com/
https://patchwork.kernel.org/project/linux-rockchip/patch/20201102190551.12=
23389-3-adrian.ratiu@collabora.com/

Thanks,
Ezequiel

> Emmanuel Gil Peyrot (2):
>   media: uapi: Expose probability lengths as defines
>   media: hantro: Use VP8 lengths defined in uapi
>
>  drivers/staging/media/hantro/hantro_vp8.c | 4 ++--
>  include/media/vp8-ctrls.h                 | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> --
> 2.29.2
>
