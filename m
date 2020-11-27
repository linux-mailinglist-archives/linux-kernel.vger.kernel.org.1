Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341A22C67C0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgK0OVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbgK0OVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:21:35 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6C2C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 06:21:35 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id r5so2634201vsp.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 06:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8RO9atRNHdYldNSGmaQaTCeJbnbZeVqGELEiXjpI7As=;
        b=Udqp5DAW7J30LmJqH6FoiBa2ezgB+t0lUaIp+KucxDq6wkej2M3+sknmpgpRLnSh03
         YoMrr5EYyU9rYoa/Lhv+uxqkMMQ/PXmEHOvd5KKHMiB/MaTN/Z6ar7JU9UIotZMTzxOm
         argViY9+yJLXwc1Xh6suS3clxriTdYtNnC4dL0equO3T8Pn9QDREhDOKzq5pAtUVKvrS
         5wuS6/e/XNbreeQm61ibYnuStyf4kHWmS+tKoR/ohDpKPX3EgxQ7rY/tRjnSfjd1u5gZ
         yJeMEntQ5jz9YPTmlXkEWDM235F17X5Wf2WXckIjd7v/ml6ztRj+DVdzPHxc+0Qksvia
         j50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8RO9atRNHdYldNSGmaQaTCeJbnbZeVqGELEiXjpI7As=;
        b=uinf77aj9SrD/qiSBTac3zYJfsiwnRzoiOQDy/ESmh3zYxcPrLnawzJ45VDrNSftXu
         nxJ+e3z6y8oHgv374SRzp1K03QpceBqeO/FU1bnie33L4nWAp2kwIF2oQ9YVcRWWkFW/
         WColna4cC4OoTOIAVT02MzRLNWJtic2pUmOlf8Irb+dpx5S7qXysyPNkGkO1jxlskw5S
         VTFVwf2HxCcda4sMFxOrLhCjSGxyH0ocyWQinOgyiEJAdkeKXBgnRdvARJubvvOywLWq
         Ah/u6dq02GF1LgO1fLWF+Y/bsUhb6Td5ViEsMCYamuyMbNsW6hqPgNdIe38f2gRoG1kG
         dKSQ==
X-Gm-Message-State: AOAM530Y7Z1kuxpwcXQTft5UHgm4JxzFoBTotp6FZ0dmfnk3e6yGSYj6
        WWoVNbms+M3tanlP+qvRlAJ+ck3jvH4=
X-Google-Smtp-Source: ABdhPJxd3xEAaR6m8M3QcAok3ovC7T3WTlGur4gkV7IRCsBH59B9IuACit1FVPsTmBwZn2b0bBzzdQ==
X-Received: by 2002:a67:32c1:: with SMTP id y184mr1991455vsy.5.1606486892165;
        Fri, 27 Nov 2020 06:21:32 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id o193sm506886vkd.27.2020.11.27.06.21.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 06:21:31 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id m62so2638239vsd.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 06:21:30 -0800 (PST)
X-Received: by 2002:a67:e210:: with SMTP id g16mr5804237vsa.28.1606486889898;
 Fri, 27 Nov 2020 06:21:29 -0800 (PST)
MIME-Version: 1.0
References: <d0ac1a26ed5943127cb0156148735f5f52a07075.1606459576.git.mchehab+huawei@kernel.org>
In-Reply-To: <d0ac1a26ed5943127cb0156148735f5f52a07075.1606459576.git.mchehab+huawei@kernel.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 27 Nov 2020 09:20:53 -0500
X-Gmail-Original-Message-ID: <CA+FuTSenOoVxM6W9viwXQmPHo_MEoQzQ=GPxJi72fYGHHmqmwA@mail.gmail.com>
Message-ID: <CA+FuTSenOoVxM6W9viwXQmPHo_MEoQzQ=GPxJi72fYGHHmqmwA@mail.gmail.com>
Subject: Re: [PATCH] media: gp8psk: initialize stats at power control logic
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 1:46 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> As reported on:
>         https://lore.kernel.org/linux-media/20190627222020.45909-1-willemdebruijn.kernel@gmail.com/
>
> if gp8psk_usb_in_op() returns an error, the status var is not
> initialized. Yet, this var is used later on, in order to
> identify:
>         - if the device was already started;
>         - if firmware has loaded;
>         - if the LNBf was powered on.
>
> Using status = 0 seems to ensure that everything will be
> properly powered up.
>
> So, instead of the proposed solution, let's just set
> status = 0.
>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Reported-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/media/usb/dvb-usb/gp8psk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/dvb-usb/gp8psk.c b/drivers/media/usb/dvb-usb/gp8psk.c
> index c07f46f5176e..b4f661bb5648 100644
> --- a/drivers/media/usb/dvb-usb/gp8psk.c
> +++ b/drivers/media/usb/dvb-usb/gp8psk.c
> @@ -182,7 +182,7 @@ static int gp8psk_load_bcm4500fw(struct dvb_usb_device *d)
>
>  static int gp8psk_power_ctrl(struct dvb_usb_device *d, int onoff)
>  {
> -       u8 status, buf;
> +       u8 status = 0, buf;
>         int gp_product_id = le16_to_cpu(d->udev->descriptor.idProduct);
>
>         if (onoff) {
> --
> 2.28.0


Is it okay to ignore the return value of gp8psk_usb_in_op here?
