Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247172E9746
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbhADO3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbhADO3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:29:33 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B28C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 06:28:53 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id f26so23530963qka.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jw8ew9TnyT9X4xDw7u45cftjoE7A08Lbyl8yTyyadtM=;
        b=SUgLoRYDWSGcUEB9ZeTO3tHGBQFdwwXSBXS5bTE9+gt1MojRLRmbHM1O3MZ2yTCkRQ
         tO30XWto6Sa15pQvwMcNjfP4mKXHJMjpsy11dS+Cm87AWeaWInCZItfe2ddb8gZgT0Zg
         LEVXIE+Q+9t4NEFjrv6O017iy7TJInLToKlMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jw8ew9TnyT9X4xDw7u45cftjoE7A08Lbyl8yTyyadtM=;
        b=pItBsq+g9VrUJbSws4s0FnGaDyHov8XXT9ai1I0jZBWO+XOQ+riB+CZ9r7MuzD3l+M
         Gka3lBca/MOQhcmaSExO/Ftf4SqxMgUc35kQAs6CMRJT9tG7fpf9tnQGQjbzuPzS8una
         3GhacYwXqw/JGO7Xm9Fzr46dQIEFDw7g4Gz74uUKJvF4nVVEWbFsxtSMA4sn3nPi4ESK
         crjdNuBmMe+7zH/CLAFDxcTzSoYgQtSd6r7lFIhubgaimjKO55Ki/9AZuzA0bnlqVfN/
         EEtULPpjU8ANxR98xtDsJ8wU7FJc84Y9pp+RKLkUQeYo7not7GCCP6YPyWhR94h/x7qV
         G4bA==
X-Gm-Message-State: AOAM532PTPcjDidWxrGnHdx3EN2BwMoADpsGl4JgFb50AHKkLrIuFSsq
        DaascMaidR5jT7tE8LUeAzL/33dxawdlIa6NOX4kHA==
X-Google-Smtp-Source: ABdhPJz5NcOpqUdV7J8j9XoG/uLkITBirWvkmAQTZEh3zNF/3HEbUFm8MF1/s6DwC5XMh5V/QbKawCuonO3eQoAOm4k=
X-Received: by 2002:a37:bd84:: with SMTP id n126mr71633870qkf.54.1609770532326;
 Mon, 04 Jan 2021 06:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20201227031716.1343300-1-daniel@0x0f.com> <X/LuvBdeLVKyZkvO@hovoldconsulting.com>
In-Reply-To: <X/LuvBdeLVKyZkvO@hovoldconsulting.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 4 Jan 2021 23:29:39 +0900
Message-ID: <CAFr9PX=xr=xRaT18VN5ELDF=WBO+YqohC4Rvdg-TJNDXr3OqgA@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: option: add LongSung M5710 module support
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On Mon, 4 Jan 2021 at 19:32, Johan Hovold <johan@kernel.org> wrote:

> Also, would you mind posting the "lsusb -v" output for this device for
> reference?

The lsusb from busybox on this system doesn't support the -v option it seems.
Here is the output from /sys/kernel/debug/usb/devices:

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2df3 ProdID=9d03 Rev= 1.00
S:  Manufacturer=Marvell
S:  Product=Mobile Composite Device Bus
S:  SerialNumber=<snip>
C:* #Ifs= 5 Cfg#= 1 Atr=c0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=03
I:* If#= 0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=88(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

I can rebuild my rootfs with the usbutils lsusb tomorrow when I have
physical access to it again if needed.

>Do you know what each interface is used for?

The second tty responds to AT commands. The others don't do anything so far.
The hardware documentation doesn't say much aside that there is a usb interface.

Thanks,

Daniel
