Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A33B29E1E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgJ2CES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:04:18 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:35304 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbgJ1Vkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:40:51 -0400
Received: by mail-ej1-f68.google.com with SMTP id p5so1025855ejj.2;
        Wed, 28 Oct 2020 14:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V9wAxbakPGDl8B/UAvN8WqdKbhC7FBGBLyMgvNzfzck=;
        b=IAFInqvHOk+gNfVIkwPSSdUOAdHENE37ifV1/ByqaHudHVV4RDlRxf67UwSKRSyeXW
         LAabi3PfNPkkq2c0NMS5/lTfybXNuFTIuI6rIjuZrxv3jKSOYllsBgbuarsYM28zCHZ/
         JoOLQDPB04ynXBrGfbcOJUiTjg4kzcdRmNCU3IKV/oD0gG+aY8LZuc6GupBzF1m416ki
         IKdKU6nq+ba4K7QaUSW+DogM1GNP5FLuySTBM9vXaOMZOEPdFWVBdiwn7x1W95RPCHxR
         BZRSi6YOBKNBGdjDlZRI3vQXkJSyNqfDu6dKa9TnyPx3zg6KYI9IJF+X02XH/6NkrYcl
         bcMg==
X-Gm-Message-State: AOAM532y2qyLA6yQHt5mtIdIMo0RqdDjzP248LDffba4YWjHFNqYxMV+
        J/nqZf4cAoRI2mjhpPEagnKetQuub4dbTQ==
X-Google-Smtp-Source: ABdhPJwc4yhmCVmHTTvbxjysd68szL7JtYIFqrQFSTV3F7c0shiKYPHnPjVuElX6eGi6KNeYsEu9fA==
X-Received: by 2002:a19:8353:: with SMTP id f80mr2615326lfd.348.1603897267964;
        Wed, 28 Oct 2020 08:01:07 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x19sm551571lff.189.2020.10.28.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:01:05 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kXmwj-0005BK-Ma; Wed, 28 Oct 2020 16:01:06 +0100
Date:   Wed, 28 Oct 2020 16:01:05 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: Fix serial port stall after resume
Message-ID: <20201028150105.GJ4085@localhost>
References: <20200929193327.GA13987@ls3530.fritz.box>
 <20201008152103.GK26280@localhost>
 <1aefc37b-8976-efda-f397-2d9492b1260a@gmx.de>
 <20201027090043.GG4085@localhost>
 <a2b84135-761b-6e9c-59d5-857bfa6d0281@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b84135-761b-6e9c-59d5-857bfa6d0281@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 03:54:35PM +0100, Helge Deller wrote:
> On 10/27/20 10:00 AM, Johan Hovold wrote:
> > On Thu, Oct 08, 2020 at 08:16:02PM +0200, Helge Deller wrote:

> >> My testcase is pretty simple:
> >> 1. I use e.g. "minicom -D /dev/ttyUSB2". Serial connection works.
> >> 2. I exit minicom.
> >> 3. I suspend the workstation: "systemctl suspend"
> >> 4. I wake up the machine and wait a few seconds.
> >> 5. I start "minicom -D /dev/ttyUSB2" again. No transfers on the serial port.
> >>
> >> With my patch the minicom serial communications does work.
> >> Another way to wake up the connection is to rmmod the driver and
> >> insmod it again.
> >
> > Weird indeed. If you exit minicom before suspend and no other process is
> > keeping the port open, then that write_latency_timer() above would never
> > be executed.
> >
> > Could you enable some debugging and provide a dmesg log from a test
> > cycle (open/close minicom, suspend/resume, open minicom)?
> >
> > 	echo file usb-serial.c +p > /sys/kernel/debug/dynamic_debug/control
> 
> I enabled the debugging and tried a few times, but somehow I can not
> reproduce the issue any longer.
>
> So, please drop my patch for now.

Good to hear the problem's gone. :) Let us know if you run into it
again.

Johan
