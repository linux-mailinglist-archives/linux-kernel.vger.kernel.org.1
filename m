Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADE52B2084
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgKMQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:34:51 -0500
Received: from netrider.rowland.org ([192.131.102.5]:59825 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726157AbgKMQeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:34:50 -0500
Received: (qmail 324707 invoked by uid 1000); 13 Nov 2020 11:34:49 -0500
Date:   Fri, 13 Nov 2020 11:34:49 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     John Boero <boeroboy@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Null deref in kernel with USB webcams.
Message-ID: <20201113163449.GB322940@rowland.harvard.edu>
References: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
 <X61rce8GANHW1ysh@kroah.com>
 <CAO5W59iGm3kN-HhA_g78iJH9cV3fHzjQORM_b3xqo1Mg+XEi2g@mail.gmail.com>
 <X613chtPVIg8kquH@kroah.com>
 <CAO5W59jZdDgSBE3Tr79u7TuCrdsirhisFxKH6aCH5oE4soOz1g@mail.gmail.com>
 <20201112192524.GB287229@rowland.harvard.edu>
 <CAO5W59hXOHAd_D0K3HnvJmf883e_u+s6oM+DGJMqpr392N5Gww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO5W59hXOHAd_D0K3HnvJmf883e_u+s6oM+DGJMqpr392N5Gww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 01:18:05PM +0000, John Boero wrote:
> Thanks for the tips.
> 
> I've spent some more time on this this morning.
> It looks like it's not the dev after all.

What isn't the dev?

> Every interface in the dev is set NULL after init.

I can't tell what this means.  Please be more explicit.

> Just like in the original Ubuntu bug 1827452 filed by someone else
> the device seems to disconnect itself after uvcvideo initialization.
> Then there is a 5 second pause before usb_ifnum_to_if tries
> to iterate through its 8 interfaces - all of which are null.
> It looks like uvc properly locks the dev, so maybe this could
> be caused by any device being unplugged after init?

More likely there is a bug in the uvcvideo driver.

> The WARNING handle preserves USB function though,
> and subsequent lsusb behaves fine:

No, the WARN only writes a message to the system log.  The "return" 
statement is what prevented the system from crashing.

> $ lsusb | fold -w 80
> Bus 002 Device 002: ID 8087:8002 Intel Corp. 8 channel internal hub
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 001 Device 002: ID 8087:800a Intel Corp. Hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 004 Device 002: ID 0451:8140 Texas Instruments, Inc. TUSB8041 4-Port Hub
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 005: ID 1ea7:0064 SHARKOON Technologies GmbH 2.4GHz Wireless rech
> argeable vertical mouse [More&Better]
> Bus 003 Device 004: ID 145f:025c Trust Trust USB Microphone
> Bus 003 Device 002: ID 1050:0407 Yubico.com Yubikey 4/5 OTP+U2F+CCID
> Bus 003 Device 009: ID 0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0
> Bus 003 Device 008: ID 0451:8142 Texas Instruments, Inc. TUSB8041 4-Port Hub
> Bus 003 Device 006: ID 062a:4101 MosArt Semiconductor Corp. Wireless Keyboard/Mo
> use
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> 8x (0-7) occurences of the following WARNING:
> 
> [ 140.678756] usb 3-4: USB disconnect, device number 3
> [ 145.995855] ------------[ cut here ]------------
> [ 145.995863] dev interface is NULL in usb_ifnum_to_if
> [ 145.995907] WARNING: CPU: 31 PID: 5617 at drivers/usb/core/usb.c:289
> usb_ifnum_to_if+0x58/0x80

You removed the most important part of the log message!  What appears 
below this point?

In fact, you should just post the entire log (or put it on a server 
somewhere and post a URL).

Alan Stern
