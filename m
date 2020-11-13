Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB22B1BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKMNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgKMNSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:18:18 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB22EC0613D1;
        Fri, 13 Nov 2020 05:18:17 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id d9so10360070oib.3;
        Fri, 13 Nov 2020 05:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPcP8H+ygJb1ZXOJp2or6+WwDjqV5ksGM0RmudhzwZo=;
        b=HuJWgWUSpu0Ruc/b7hiNaSpXBVMbjY9fGa/oen58CP+tKVPm6i00chQ7dUih1y3FhU
         /fguMtM6UAtIdOoSVn5b2fS9CkggnlZD07+0NhAE+1BI1AAa4XUYyKINty4ZdgyEHNju
         ex4di3825I0MLLEm4vbvMStmaGMAhwmCIyQVoqtr/qcrL8AYfT1Aw+cqfYGzOU5lFbm8
         w2qX9pe8+sDOi1O1Il21kzFhb2RsEYZmXfljPb58KS/vLDq2pkeQ4SdN7cUmjXVIK5T/
         dRc9W7VEfbtu7rCtnXkCEbWV37wZXqRbH2dvnG/82kVdrVD1u3bRUvRhREapsQoJO4HL
         XM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPcP8H+ygJb1ZXOJp2or6+WwDjqV5ksGM0RmudhzwZo=;
        b=LD4rhSrY18H6RxZ14s5JdIOm5Oqv4eDFb4tv8GdEaUflr8wBJK4LwamIP/PVo6HXzD
         P43HrY1UNoX8Xw+aaOY5u9DV6gaka4MCNmc/voB80zkRMUYz/z8Gyngy4ObdOhhyRPQH
         GFYHV6pXPdcHcRDEskkH0DXcHPHPXzcPROrTGAwrI5QZ781VUW8z696YRstmZ4im6c/F
         n1YbuOcpIdY3ypNc4G0hNKeG2O0Wc/8irL3v92JTmIU8nfM1M+gNhOl6VNwx8IE4/yx2
         BFC7t511ZF6LZvGCyHDt7zHNPy+Bh7Y1M0xBEYWT0UKg4pvqichFxS8V+FKHi6gh1p5y
         ZUlQ==
X-Gm-Message-State: AOAM530byX7nnfw5hB2uM7rIPfTBoiTexrkPDBhuDUOmqPV4/5LmxkfG
        TOuOy02LO8K09sI++LYg2D8XAyeFvuFZsBvn2lk=
X-Google-Smtp-Source: ABdhPJx4vSbxPx9BNlVbdA+iVJwL5QQgr6Y3egYc30ZR82ksrXD+swaL5icpSAIA7lNqySaagWf0aFURc6ESf7Qm1SY=
X-Received: by 2002:aca:c60c:: with SMTP id w12mr1460750oif.174.1605273497227;
 Fri, 13 Nov 2020 05:18:17 -0800 (PST)
MIME-Version: 1.0
References: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
 <X61rce8GANHW1ysh@kroah.com> <CAO5W59iGm3kN-HhA_g78iJH9cV3fHzjQORM_b3xqo1Mg+XEi2g@mail.gmail.com>
 <X613chtPVIg8kquH@kroah.com> <CAO5W59jZdDgSBE3Tr79u7TuCrdsirhisFxKH6aCH5oE4soOz1g@mail.gmail.com>
 <20201112192524.GB287229@rowland.harvard.edu>
In-Reply-To: <20201112192524.GB287229@rowland.harvard.edu>
From:   John Boero <boeroboy@gmail.com>
Date:   Fri, 13 Nov 2020 13:18:05 +0000
Message-ID: <CAO5W59hXOHAd_D0K3HnvJmf883e_u+s6oM+DGJMqpr392N5Gww@mail.gmail.com>
Subject: Re: [PATCH] usb: core: Null deref in kernel with USB webcams.
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the tips.

I've spent some more time on this this morning.
It looks like it's not the dev after all.
Every interface in the dev is set NULL after init.

Just like in the original Ubuntu bug 1827452 filed by someone else
the device seems to disconnect itself after uvcvideo initialization.
Then there is a 5 second pause before usb_ifnum_to_if tries
to iterate through its 8 interfaces - all of which are null.
It looks like uvc properly locks the dev, so maybe this could
be caused by any device being unplugged after init?

The WARNING handle preserves USB function though,
and subsequent lsusb behaves fine:

$ lsusb | fold -w 80
Bus 002 Device 002: ID 8087:8002 Intel Corp. 8 channel internal hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 8087:800a Intel Corp. Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 002: ID 0451:8140 Texas Instruments, Inc. TUSB8041 4-Port Hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 005: ID 1ea7:0064 SHARKOON Technologies GmbH 2.4GHz Wireless rech
argeable vertical mouse [More&Better]
Bus 003 Device 004: ID 145f:025c Trust Trust USB Microphone
Bus 003 Device 002: ID 1050:0407 Yubico.com Yubikey 4/5 OTP+U2F+CCID
Bus 003 Device 009: ID 0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0
Bus 003 Device 008: ID 0451:8142 Texas Instruments, Inc. TUSB8041 4-Port Hub
Bus 003 Device 006: ID 062a:4101 MosArt Semiconductor Corp. Wireless Keyboard/Mo
use
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

8x (0-7) occurences of the following WARNING:

[ 140.678756] usb 3-4: USB disconnect, device number 3
[ 145.995855] ------------[ cut here ]------------
[ 145.995863] dev interface is NULL in usb_ifnum_to_if
[ 145.995907] WARNING: CPU: 31 PID: 5617 at drivers/usb/core/usb.c:289
usb_ifnum_to_if+0x58/0x80

On Thu, Nov 12, 2020 at 7:25 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, Nov 12, 2020 at 06:15:08PM +0000, John Boero wrote:
> > Then why does line 278 right below it check for NULL?
>
> Are you asking about line 278 in drivers/usb/core/usb.c?  The statement
> which says:
>
>         if (!config)
>                 return NULL;
>
> This is because it is perfectly valid for config to be NULL at this
> point.  But it is not valid for dev to be NULL.  If dev is NULL then
> there is a bug in the caller.
>
> Alan Stern
