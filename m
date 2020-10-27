Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBF829A723
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895243AbgJ0JAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:00:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43069 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407456AbgJ0JAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:00:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so842145ljg.10;
        Tue, 27 Oct 2020 02:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aoc6PFAHcsZ4k1n+rAPEIlc7fJ4qApC7bZXv5nNCWDo=;
        b=Hjxrq9kxNkaCeXNNiey16mkUKiieLSbNB8I0BFJ/EjxB/Xp5DvX7PHUXPzxtZlihkU
         tbhKWas2W/MUkHJuculPwl3M63HmV9BDNH0X95j56JbO1gV6UzgVLpXNL+r4AYkw03aE
         H4CjZE9wrg5x+O/Nc146miRGvn9C3KwNb1o+F67aRHz0H4qU7PHxyX7nvFIB/2DoEV31
         Uw6fgjxB+J27bOPopaIi7f5OoA/QDZGg330XJaumnCrQr8tP04fJFe3iNAJcw1xRs+sF
         RSwgA8r80oOu5h/QK5h9EwVTCpm8EAYZDSHyVBOPrXmmfPBpe+rLeVSFZts2mvpOy2zW
         Fl/A==
X-Gm-Message-State: AOAM5321ImFGOUG21wyLGTxYKmn3C6gVgHZXCBhJ/DCjx1v+q5sEF9fo
        gdDG0PKnUXy84vPg/IKvE6E=
X-Google-Smtp-Source: ABdhPJxJWrT+500Rqae99962YUMyLl1qAq5vzl313eUD61dYENLaqlKCvsUXPJ28lcsc0ayMVZQ7hw==
X-Received: by 2002:a2e:9905:: with SMTP id v5mr619154lji.222.1603789244634;
        Tue, 27 Oct 2020 02:00:44 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f26sm103575lfc.302.2020.10.27.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 02:00:43 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kXKqR-0002G6-DS; Tue, 27 Oct 2020 10:00:43 +0100
Date:   Tue, 27 Oct 2020 10:00:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: Fix serial port stall after resume
Message-ID: <20201027090043.GG4085@localhost>
References: <20200929193327.GA13987@ls3530.fritz.box>
 <20201008152103.GK26280@localhost>
 <1aefc37b-8976-efda-f397-2d9492b1260a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aefc37b-8976-efda-f397-2d9492b1260a@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 08:16:02PM +0200, Helge Deller wrote:
> On 10/8/20 5:21 PM, Johan Hovold wrote:
> > On Tue, Sep 29, 2020 at 09:33:27PM +0200, Helge Deller wrote:
> >> With a 4-port serial USB HUB with FT232BM chips the serial ports stop
> >> working after a software suspend/resume cycle.
> >> Rewriting the latency timer during the resume phase fixes it.

> >> +static int ftdi_reset_resume(struct usb_serial *serial)
> >> +{
> >> +	struct usb_serial_port *port = serial->port[0];
> >> +
> >> +	if (tty_port_initialized(&port->port))
> >> +		write_latency_timer(port);
> >
> > Why are you only doing this for open ports?
> 
> I more or less copied it from another driver....
> 
> >> +
> >> +	return usb_serial_generic_resume(serial);
> >> +}
> >
> > And if the device has been reset there may need to reconfigured the
> > termios settings for open ports.
> >
> > Could you expand a bit on what the problem is here?
> 
> My testcase is pretty simple:
> 1. I use e.g. "minicom -D /dev/ttyUSB2". Serial connection works.
> 2. I exit minicom.
> 3. I suspend the workstation: "systemctl suspend"
> 4. I wake up the machine and wait a few seconds.
> 5. I start "minicom -D /dev/ttyUSB2" again. No transfers on the serial port.
> 
> With my patch the minicom serial communications does work.
> Another way to wake up the connection is to rmmod the driver and
> insmod it again.

Weird indeed. If you exit minicom before suspend and no other process is
keeping the port open, then that write_latency_timer() above would never
be executed.

Could you enable some debugging and provide a dmesg log from a test
cycle (open/close minicom, suspend/resume, open minicom)?

	echo file usb-serial.c +p > /sys/kernel/debug/dynamic_debug/control

Johan
