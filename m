Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591E71CBE9D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 09:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgEIH6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 03:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgEIH6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 03:58:18 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EA1C061A0C;
        Sat,  9 May 2020 00:58:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so4079699ljn.7;
        Sat, 09 May 2020 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=TafQCK6tAd0yq03DXqWrNxrSJP+TPrYx9bpHoe0Sd4U=;
        b=RZQt9KHVCFlHdeT2qHVtd1pDK+5U9d0KvjvPmeAwXursxX7yiUgK+Vzrq2ODXDcHNF
         534SxZQEFWrOBj9wBCO6qTg+A26DGLKVYL6zZHZX8EDTfmaMfP1kKPYsk0ZvimWeDTAF
         R1fDJQapG1NFKuDU4eXdaeCptButkGxEFa8wmq3ITkGhlDwG6McPuudNHlD8p/rg2Stj
         6hS5cBlvdql+1aiz5Otfe/B0Q17AW8B8qwqvtnKZAmmBgGUwt/MHojbiJ/0z1TBCvjZ3
         wf42NsVXGjK+grP5n6NXsmC27M5xWfwY0/9StKFeAdpaXMgchrYaUSBm+INQcFadcCtW
         Uiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=TafQCK6tAd0yq03DXqWrNxrSJP+TPrYx9bpHoe0Sd4U=;
        b=BXbu13zJGhZtowMgOUG6R6Qd6+y9GdFsx79fj21vKEYpJveOM0vZrvj7dnNo2sr3gl
         qK6YTbmypqZFXv/6DmbNPsh9lm5xo290kLRccApYMpy4NcGYRP0CIW9FJcgmTTr3oyeU
         ND/7PW19lYpwDs/NlKgehrO6/aL+l+P+3qDZ0WIhTUSlWe7cbnhFWWUNGBDsURLMn4py
         Ttx+avzDhbSTfuZBf5+RWmbzLaVI2e7KZtSRL5CuDaNbpIMLn5IWsPn5hStKD7gi2NX2
         2mzHMbNNBf3QsyeurXZ4t4T8UEUC1vlIhKqkHgage8+00uQVLGA5iLdTDN3mGiovClxp
         wVsQ==
X-Gm-Message-State: AOAM5339c7CDrRHLeQnGRdl9Y6Nwl/FqD1dE8AqgsuvmiplkXEyC01te
        mJIbuDhrSmkpJS29iO/65yk=
X-Google-Smtp-Source: ABdhPJxxyto/zfBKhpdXiFyvKKUc1PMZtVj8b44i2N+GdhSIdMFO+z9fQwJ3lb2oW54xXFN6P6jE9Q==
X-Received: by 2002:a2e:87d3:: with SMTP id v19mr3888627ljj.176.1589011096588;
        Sat, 09 May 2020 00:58:16 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id f10sm3243389lfl.82.2020.05.09.00.58.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 May 2020 00:58:15 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Kyungtae Kim <kt0755@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Tian <dave.jing.tian@gmail.com>
Subject: Re: [PATCH] USB: gadget: fix illegal array access in binding with UDC
In-Reply-To: <CAEAjamuZR-amiVWK4BMWReq7=1Vus+bXsB-97t3hhsYHLfUstQ@mail.gmail.com>
References: <CAEAjamuZR-amiVWK4BMWReq7=1Vus+bXsB-97t3hhsYHLfUstQ@mail.gmail.com>
Date:   Sat, 09 May 2020 10:58:11 +0300
Message-ID: <875zd5mtf0.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Kyungtae Kim <kt0755@gmail.com> writes:

> FuzzUSB (a variant of syzkaller) found an illegal array access
> using an incorrect index while binding a gadget with UDC.
>
> Reference: https://www.spinics.net/lists/linux-usb/msg194331.html
>
> This bug occurs when a size variable used for a buffer
> is misused to access its strcpy-ed buffer.
> Given a buffer along with its size variable (taken from user input),
> from which, a new buffer is created using kstrdup().
> Due to the original buffer containing 0 value in the middle,
> the size of the kstrdup-ed buffer becomes smaller than that of the origin=
al.
> So accessing the kstrdup-ed buffer with the same size variable
> triggers memory access violation.
>
> The fix makes sure no zero value in the buffer,
> by comparing the strlen() of the orignal buffer with the size variable,
> so that the access to the kstrdup-ed buffer is safe.
>
>
> BUG: KASAN: slab-out-of-bounds in gadget_dev_desc_UDC_store+0x1ba/0x200
> drivers/usb/gadget/configfs.c:266
> Read of size 1 at addr ffff88806a55dd7e by task syz-executor.0/17208
>
> CPU: 2 PID: 17208 Comm: syz-executor.0 Not tainted 5.6.8 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2=
011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xce/0x128 lib/dump_stack.c:118
>  print_address_description.constprop.4+0x21/0x3c0 mm/kasan/report.c:374
>  __kasan_report+0x131/0x1b0 mm/kasan/report.c:506
>  kasan_report+0x12/0x20 mm/kasan/common.c:641
>  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
>  gadget_dev_desc_UDC_store+0x1ba/0x200 drivers/usb/gadget/configfs.c:266
>  flush_write_buffer fs/configfs/file.c:251 [inline]
>  configfs_write_file+0x2f1/0x4c0 fs/configfs/file.c:283
>  __vfs_write+0x85/0x110 fs/read_write.c:494
>  vfs_write+0x1cd/0x510 fs/read_write.c:558
>  ksys_write+0x18a/0x220 fs/read_write.c:611
>  __do_sys_write fs/read_write.c:623 [inline]
>  __se_sys_write fs/read_write.c:620 [inline]
>  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
>  do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
>
> Signed-off-by: Kyungtae Kim <kt0755@gmail.com>
> Reported-and-tested-by: Kyungtae Kim <kt0755@gmail.com>
>
> ---
>  drivers/usb/gadget/configfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 32b637e3e1fa..6a9aa4413d64 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -260,6 +260,9 @@ static ssize_t gadget_dev_desc_UDC_store(struct
> config_item *item,

patch is line-wrapped, please fix and resend.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl62YpMACgkQzL64meEa
mQbKpA//Z486DL8X0hqFPDgO5wfBd4Qx9RDpWgkkU55ksg2yWatnmk4GPVtQj8Kf
udYw4yxiJwE3GN43cX3iQNqrG0VA1TCM3v3Ljtw9m/BsjBy9DEBI7c5Uj/8KYVZs
GJqVnJPuYdF1A/C3R9kHt/473t5+KLi3OnGaai+DQjjMhmGfkGjk9SeOtuhaS8Lp
9Cg2Z1vzOdQeGIOL6J504eYT1fmUqXoBU8lE9AJXEVsmHbMLDlHlOByDMqzMxaJJ
I4mjyZLGZ/9zAFhnUkaI9rpvHXjriidzNT/C/abPfwT/kvyCjh829Tr8jEtdzYKV
TFqWQ32XA1e0eOibo2dWmM0N5RUF3m8cCYnR0FZpf3NlQglaOe6hp9QrTLZrcJW0
fqXC7hHbG0FXviOAEEqtcQ21ZZQ4xmebQZzKKG2RRVqhaYakeBR6YqtW9gqYf9Le
+V1YhCcaTWnEcdb2f6tYttKAXO3gSB59RcgMsV1qok23LludksZvxPiPHcc6JCrd
/W+qx/XHfTsZFtbpI1Quo+nEKV+Szy4zJ2/vlbA8gE9QnGWK6qNBs2qg/pKvqG2i
LM+ahabxsLFE7ItA6JUwv9mgN1uh0MoVeKEnQRxFMyeX4cjr+U8dvdPLoOwBJlvR
2ZmP7sHeb3Xgbos9ZNK9DXOsUY/fG5V8zLUtBYJnTg3/V/qI7P8=
=12iV
-----END PGP SIGNATURE-----
--=-=-=--
