Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D120227819D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgIYHcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:32:33 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgIYHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:32:33 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MQ5jC-1k8Z5T3k2q-00M6SL for <linux-kernel@vger.kernel.org>; Fri, 25 Sep
 2020 09:32:32 +0200
Received: by mail-qt1-f178.google.com with SMTP id b2so1134902qtp.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 00:32:31 -0700 (PDT)
X-Gm-Message-State: AOAM531cqrEfv3LJ9tCCjmq/mu/xUh5eMLbl6mU1ASqNRz3zZWcMheN2
        ZnIKwmzL90xeUevRYVAdFdKtkmEFk27I5jfu930=
X-Google-Smtp-Source: ABdhPJwNP8tIZnNGnYXs8Cd4GHdEedQDzc+eFbz3fC38Ps+5TWf/g0uQVaKnjQQbzGVFVCUulSt2khjeOUesmzfEHbI=
X-Received: by 2002:aed:2414:: with SMTP id r20mr3159148qtc.304.1601019150592;
 Fri, 25 Sep 2020 00:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200925071831.8025-1-sherry.sun@nxp.com> <20200925071831.8025-5-sherry.sun@nxp.com>
In-Reply-To: <20200925071831.8025-5-sherry.sun@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Sep 2020 09:32:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2jJBxEDD+FXpHsFXRd9BF3aND2jTtswzP1L6_T4BiS9A@mail.gmail.com>
Message-ID: <CAK8P3a2jJBxEDD+FXpHsFXRd9BF3aND2jTtswzP1L6_T4BiS9A@mail.gmail.com>
Subject: Re: [PATCH 4/4] mic: vop: copy data to kernel space then write to io memory
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:sc3J4dRvnjpJofrQ61zSJdWsVoZk+PKecmW6VY/YQVlG3vTaUhi
 ockvc8qFB3caOcj28nc3yESHLYzi7ENVJ8vflGSkcWZjmO2JxCHjKX7wxP7etyU45arVfEU
 93PL35CHtG2ajHCcZ5A3YFmQmvci6T/UK1IHmw+mrLed0A4m+6twpwMoW/m9oCRt6/JxUuh
 NIVB8Jx7VwCkgrZ37QpAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5bwVC7u/PX4=:7lkb16BVOHOL2hBJBmiYLc
 vG6i2Mepde0GcMfr1RkW9CxUcgl7LxSDq+D7LMUC/k0bak1F/DHAJNTd8DsVgSJueWeOBwtYh
 JIvEw2mkYHndisWaMwofjwp3V73kb6ocapkh3OiGlHWTMZWsCNJA3+KY85S7rXnHAvnRCDVBA
 gc2LTxDiS/3AEqIKPAm7t9VUPUcjJcKcJgtG+2c92ojNcDg7T119E+0FmeK+zOcTJ60k0PRw+
 t6CHhVn8ji3aIY+/G1zrOC9nmr6MmGh6VoFWCd+cgQ+OLLhjeOq8sJXlTmw579pRDVzupIqj2
 8ZpUDLrdmmuk0t8eqeZebadoS5aRYzYUsp71/Z/2I96Qj+vukmX0Tf12b9u3vi/fDTMcsbtSy
 4KhX5utFCGpnunr1P1GSyVFOk4iWmaCABwm5jSFqk48JQM9ODEuFWN6kaCuW2D7goHul3SNwH
 VcfoN3Rnxwl4CsGSmZL+R/gqACIvkq/VGL/L+mZbGUrsPDBp2exzIomi/277mU9pFLN7V7zzj
 ooQaCzjDeKes8h86mthSruZhpT7hXTIwnQjDmN12FkiUZtgWzP0YmVrplbh6nrqBWGcUkxrC+
 TeQmwe0F8hdDK+ifl8SiISPLc8rD65/TCx5myGdpSBXClpP4zbR+ZG3qmIYrOUcMkeeAwCYHt
 +qxhRJD/hSdB7Jl+vYq7BwoWKbFMf7Y890+k2kFth6F/9nJMdL4MEpnwWsHSgHIogmPc5nzYC
 N0QewwyhPbipqKa7MOgnFpNQhK7as87asRzBnu/y+sAiEkLRzAxZTsn3/xR7RpPqQocXp4dCH
 PKUGrTBKns7XcM2f5sbVapT9A2HBGBYOrVTQ8oXy16jdEJ0Jfj+dred6f2/+46V6fHmIv1ANx
 rqUfRbgh4ijioWxvCin7S4xjchEgbOORwIZpNeARvbVoYMpAnJOEXVc/f1Mb0LdPdUvEswCtH
 1Bc1kBRbcqPCC1wVlM6BOW5bANPwZ1RjghswUwTKCN+8Cm1zhLRYq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 9:22 AM Sherry Sun <sherry.sun@nxp.com> wrote:
>

> @@ -655,12 +656,15 @@ static int vop_virtio_copy_from_user(struct vop_vdev *vdev, void __user *ubuf,
>          * We are copying to IO below and should ideally use something
>          * like copy_from_user_toio(..) if it existed.
>          */
> -       if (copy_from_user((void __force *)dbuf, ubuf, len)) {
> +       temp = kmalloc(len, GFP_KERNEL);
> +       if (copy_from_user(temp, ubuf, len))

This needs to have error handling for a kmalloc() failure. As the length
appears to be user-provided, you might also want to limit the size of
the allocation and instead do a loop with multiple copies if there is
more data than fits into the allocation.

       Arnd
