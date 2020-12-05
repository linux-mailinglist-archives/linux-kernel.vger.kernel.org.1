Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E918F2CF889
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 02:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgLEBKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 20:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEBKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 20:10:11 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4836C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 17:09:30 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id h20so7358672qkk.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 17:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ldmvOFahKnoMmHYAh2zrzpTIHwKJiY0W59JNYPPaME=;
        b=b/G3GAmTQtMhBQhE2fmvDPJq8Wy6Z4UvIng6ZRzqolM4x5oZYPLJ2ndMIyakeEIGD6
         h2BAiuNBkfeibeJiowPQwOHCDTDe0IsZO/sDvp7KSbxLnYFWkHhgsMNn649yd+Rs9/QU
         LiA9ETbH9X47SjAdQe9gILcI3opUEZlqudZ5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ldmvOFahKnoMmHYAh2zrzpTIHwKJiY0W59JNYPPaME=;
        b=PTo5ztkr/T/aSMRM26gfgxd9AcFlXkXmX7TEbzIOPlnNoUclkUy/Byt0HaqKkj8W3m
         8r11Qz+Wgilp1MwDYqE/RMftgSymObKF/gX35Ls9E8EWAKQbXEYx8gR5r51EMm31uzoI
         X6IyugEozyu6jlD8OawMmTd+1enUXlrp3KtAGFZ3xYvIVG16GYouQPAgRl1Rl+EI6N2G
         Pw0GiaoFZ4X0AQrIFvxsASpmkULb9/xiSafM11/m/lqPR6yBg55BKlxfBeIN7KkF4Lnk
         WjdG7jbovpEb+ftlU8k75Rp8tHyOkdMtnqxKco8PVZbkClXdCY+pDxf2WOtXfRkNh+nq
         QLQw==
X-Gm-Message-State: AOAM5339xIxaDDLXp6DeLyHN8w9UZaRVUtdXimx8MwpahYZqiHNddZ6H
        HMOvDGdH//54SQRCVKTp1bEDzZXkLyA8J+ZcwvciBg==
X-Google-Smtp-Source: ABdhPJx84SfjHWTrRKsdW0Ob5tt1TnuLlE7ykm0c6CxciJ2pJW1FV+nmxh8vH+y+AZrBklppkOu6WE5/WBPSftYSM+Y=
X-Received: by 2002:a37:ad17:: with SMTP id f23mr12618844qkm.121.1607130570021;
 Fri, 04 Dec 2020 17:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20201106020305.767202-1-pmalani@chromium.org> <20201120073201.GA4120550@kuha.fi.intel.com>
In-Reply-To: <20201120073201.GA4120550@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 4 Dec 2020 17:09:19 -0800
Message-ID: <CACeCKadt_=4+Xc+8OojSg7isXgL2dhfnaUHCMKhtDe_HwPQwdQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Tolerate unrecognized mux flags
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Short <keithshort@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping. If there are not other reservations, can we pick this
patch? It doesn't depend on any other patch series.

Thanks,

On Thu, Nov 19, 2020 at 11:32 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Nov 05, 2020 at 06:03:05PM -0800, Prashant Malani wrote:
> > On occasion, the Chrome Embedded Controller (EC) can send a mux
> > configuration which doesn't map to a particular data mode. For instance,
> > dedicated Type C chargers, when connected, may cause only
> > USB_PD_MUX_POLARITY_INVERTED to be set. This is a valid flag combination
> > and should not lead to a driver abort.
> >
> > Modify the mux configuration handling to not return an error when an
> > unrecognized mux flag combination is encountered. Concordantly, make the
> > ensuing print a debug level print so as to not pollute the kernel logs.
> >
> > Cc: Keith Short <keithshort@chromium.org>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>
> FWIW:
>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index ce031a10eb1b..5b8db02ab84a 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -537,10 +537,9 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
> >               port->state.mode = TYPEC_STATE_USB;
> >               ret = typec_mux_set(port->mux, &port->state);
> >       } else {
> > -             dev_info(typec->dev,
> > -                      "Unsupported mode requested, mux flags: %x\n",
> > -                      mux_flags);
> > -             ret = -ENOTSUPP;
> > +             dev_dbg(typec->dev,
> > +                     "Unrecognized mode requested, mux flags: %x\n",
> > +                     mux_flags);
> >       }
> >
> >       return ret;
> > --
> > 2.29.1.341.ge80a0c044ae-goog
>
> thanks,
>
> --
> heikki
