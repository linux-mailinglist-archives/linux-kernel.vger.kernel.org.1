Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDD22C8CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgK3SfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbgK3SfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:35:24 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7756BC0613D3;
        Mon, 30 Nov 2020 10:34:38 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l23so114745pjg.1;
        Mon, 30 Nov 2020 10:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j2KSOF6GgSjfisRweLKXl6J6Qui7lp0yoyE8s99vP+4=;
        b=QFyiYDuGLfs67t7fG78E+/0luvRO0T1XYzV/ZtG42Z5I01erPpF9V1rYbHtEC6RK/r
         l4eH9DQzIQPGvymQC2v2+WQ3EnlvaL1Dow+5vW8ns2AOCX3QpNih19JsbxUCyStchlhl
         7LsHjaFUd+e9XXh/9H8yIwqwcLrN0WAt1y6Qw2uSxi0Dp44oUrJml5HSuTvifIcAVdKd
         +4azmGf5b4Hhd2ML0H/f8pyh5/pTBME7jjg/OIGwvTffc2eo13yXe5z/D/8rsAtjIeoW
         5Hq9aOvXZT+3gotycaneY7FrX4itU3Drn1gbKlsb0cYm2erxZw0/gj7fqcV4Wxmezp+j
         ve8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j2KSOF6GgSjfisRweLKXl6J6Qui7lp0yoyE8s99vP+4=;
        b=jDANirQRMax5BTnNOCvKZ+8C7HVSvJhd34u4IzEfGO8XdC2T9N9/jm4byZdRESJz3a
         qtdSxq6tZ+U1zYqYKSgrIwhCLUHfKgPMO4sEIj2pfHNZV0Kox1Lq+280kvIl7n6nqq5c
         q1BkNoWcXXgvzCBZOg1f59QfF33JdUXab0z5lqM3plxSnlZS7BA0F1xFrR06XtVMANYY
         ghWwTpdOJA9A0VX0y58aL8jTX0jofOyWZhphOSwjyJQCXB4OzDx9VxLv4QJw7rwoPLGc
         KTnD0Hy76yVz3i37GsNMP2ve8y1/Mze0OSOlWgp3y3dX3bm5yjWB1p8G9JUZXb9e6Qq9
         BRAA==
X-Gm-Message-State: AOAM530sBMHVXBdaADGlaNbLQCDH1Ti5ns6KkyPl5Zbx0i21QZ9qVaQs
        0hGKs9BzoOwYrOQR04tHSSAe1Z4MKBeQ65NXDGODfTKEQTbQ5w==
X-Google-Smtp-Source: ABdhPJwJYfAZ0+IKqF2o1HM/74rPGcSVlPR1G9poAx/st3CMfEugZLT2JJJpWNc6/rWYtGDDsBFciTk4kL8rjeQ3mps=
X-Received: by 2002:a17:90b:350:: with SMTP id fh16mr157207pjb.228.1606761278036;
 Mon, 30 Nov 2020 10:34:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606481420.git.agx@sigxcpu.org> <91c27b323786445f6b33c6a7e89e93755d05e3a2.1606481420.git.agx@sigxcpu.org>
In-Reply-To: <91c27b323786445f6b33c6a7e89e93755d05e3a2.1606481420.git.agx@sigxcpu.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Nov 2020 20:35:26 +0200
Message-ID: <CAHp75VeLZtm85Y=3QMkPGb332wn05-zr-_mrrwXvnqLhazR1Gg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: typec: tps6598x: Export some power supply properties
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 2:57 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> This allows downstream supplies and userspace to detect
> whether external power is supplied.

> +       if (!(pwr_status & TPS_POWER_STATUS_CONNECTION) ||
> +           !(pwr_status & TPS_POWER_STATUS_SOURCESINK)) {
> +               val->intval =3D 0;
> +       } else {
> +               val->intval =3D 1;
> +       }

Can we please use positive conditionals (which usually are easier to read)?

       if ((pwr_status & TPS_POWER_STATUS_CONNECTION) &&
           (pwr_status & TPS_POWER_STATUS_SOURCESINK)) {
               val->intval =3D 1;
       } else {
               val->intval =3D 0;
       }

--=20
With Best Regards,
Andy Shevchenko
