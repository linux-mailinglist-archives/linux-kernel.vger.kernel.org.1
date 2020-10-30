Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B042A0961
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgJ3PPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgJ3PPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:15:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2C2C0613CF;
        Fri, 30 Oct 2020 08:15:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x13so5466723pgp.7;
        Fri, 30 Oct 2020 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h7JEhToi6y0r0qaENRYWLa6TItN+W1AAZgf7V2tBFOA=;
        b=LzSDbIkS1r2D7W3mbQD2H2LaM3v85qpLNz/NJh7Eqy5oYH5p3NIq1XNckFQoNKTTxw
         q1Hl0F7kojt8JhRgmsw88WHaBAqe7yo1s6Sjcc+HJgGsWMFoVkod67MFClDIdp4Cdo7V
         3WWDMkxBfemDHIc8bK5Fq4hDdsRqD/WmdG46tJKm3MLO+g4+izGMMzTF0R3KJt0gjo7o
         ooUQxl4AiWVt91W/97aTUwQ0rurFdYFn1gqMbwiF64SuS/LbHZ3FoQTQxv1AOF2RryTJ
         BnqR6eIfZ6DlHk/uv5Ys10fhkDrIEAxlgPXXko5mS5hbiZlLfT3665KLN0uRlx3biGf6
         dwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h7JEhToi6y0r0qaENRYWLa6TItN+W1AAZgf7V2tBFOA=;
        b=WYec23Bz0UmI5RBtUaEE9XMKh5hZMt61wwApsuxPXhBIV8nQqNbT31PTcx6DTxSBql
         IBjp1cF+1/f51laaBUv0Y9Al4rknxEvVvpVQ4COB5TcJudiLt4lJTbXFtvYbLhEgQ34W
         6qS4JZY4j9i/HPHkI+IpCHIpueDNAazExHnF9QwgIqAyQDm8Esci1y8RzeeZzG9QVBdX
         y2qYxl5Soolis+i7q71BIV+IR3AysPGtjhrtdVcehHwaBYHUWGq521pz9QIj7I4sRqt7
         IFvykRiIofoycQDub/uW8Lk0YfBMyUOuP+4UtvgdfUrRoVojmFpWombJDwBdZVB7AN7N
         Dxrw==
X-Gm-Message-State: AOAM531dEwkOlKS894HMn81I4sIkpXpCz+7qhNzTc1BFHE9dDMW3r4aK
        laGNxgB1rMhyu1LdRSmTDPg=
X-Google-Smtp-Source: ABdhPJzI1jaxOjZiRkPwNeMRQ7loDrLDM2QrsvU0jyOLEg/ssM/oIxyj10iYEwUEe8IRyWqahzG6Sw==
X-Received: by 2002:a63:1365:: with SMTP id 37mr2630167pgt.247.1604070944766;
        Fri, 30 Oct 2020 08:15:44 -0700 (PDT)
Received: from localhost (23.83.224.115.16clouds.com. [23.83.224.115])
        by smtp.gmail.com with ESMTPSA id b16sm2745870pju.16.2020.10.30.08.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 08:15:43 -0700 (PDT)
Date:   Fri, 30 Oct 2020 23:15:40 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v3] usb: dwc3: core: fix a issue about clear connect state
Message-ID: <20201030151540.GA37515@nuc8i5>
References: <20201020135806.30268-1-zhengdejin5@gmail.com>
 <875z6wdq62.fsf@kernel.org>
 <20201028125812.GA59692@nuc8i5>
 <87y2jqlahc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2jqlahc.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 03:57:03PM +0200, Felipe Balbi wrote:
Hi Balbi and all:
> 
> Hi,
> 
> Dejin Zheng <zhengdejin5@gmail.com> writes:
> >> Dejin Zheng <zhengdejin5@gmail.com> writes:
> >> > According to Synopsys Programming Guide chapter 2.2 Register Resets,
> >> > it cannot reset the DCTL register by setting DCTL.CSFTRST for core soft
> >> > reset, if DWC3 controller as a slave device and stay connected with a usb
> >> > host, then, while rebooting linux, it will fail to reinitialize dwc3 as a
> >> > slave device when the DWC3 controller did not power off. because the
> >> > connection status is incorrect, so we also need to clear DCTL.RUN_STOP
> >> > bit for disabling connect when doing core soft reset. There will still
> >> > be other stale configuration in DCTL, so reset the other fields of DCTL
> >> > to the default value 0.
> >> 
> >> This commit log is a bit hard to understand. When does this problem
> >> actually happen? It seems like it's in the case of, perhaps, kexecing
> >> into a new kernel, is that right?
> >> 
> > It happens when entering the kernel for the second time after the reboot
> > command.
> >
> >> At the time dwc3_core_soft_reset() is called, the assumption is that
> >> we're starting with a clean core, from power up. If we have stale
> >> configuration from a previous run, we should fix this on the exit
> >> path. Note that if we're reaching probe with pull up connected, we
> >> already have issues elsewhere.
> >> 
> >> I think this is not the right fix for the problem.
> >>
> > I think you are right, Thinh also suggested me fix it on the exit path
> > in the previous patch v2. Do you think I can do these cleanups in the
> > shutdown hook of this driver? Balbi, is there a more suitable place to
> > do this by your rich experience? Thanks!
> 
> I don't think shutdown is called during removal, I'm not sure. I think
> we had some fixes done in shutdown time, though. Test it out, but make
> sure there are no issues with a regular modprobe cycle.
> 
It has some errors in my commit message, I describe the process of linux
restart is wrong. A PC is connected to our arm soc development board
through the usb cable, the adb program runs via usb connection. there is
a very important application in our linux system. when it goes wrong(halt
or kernel panic), we want to restart linux. my wrong description happened
here, when I manually kill this important application for testing, I
thought it was calling the reboot command to restart linux, which is wrong.
our real implementation is through watchdog, when the application no
longer sets the watchdog and the watchdog times out, but watchdog can't 
reset the whole soc. our soc has 3 cpu clusters, one cluster has a arm 
Cortex R5 cpu for boot and security. one cluster has 2 arm Cortex A55 for
linux system. the other cluster for android. when the Cortex R5 detect
the watchdog timeout and want to restart linux system, it will stop Cortex
A55 cpu to run, and load linux image to DDR memory from eMMC flash, then
set Cortex A55 cpu to run new linux system, but it was not reset usb
controller. so the usb controller's status is incorrect for boot new linux
system.

   ------------------------------------------------------------------
   |                                                                |
   |	Boot and Security          Linux             Android        |
   |	----------------     ----------------    ----------------   |
   |	|  1 Cortex R5  |    | 2 Cortex A55 |    | 4 Cortex A72 |   |
   |	|    cluster    |    |    cluster   |    |   cluster    |   |
   |	|---------------|    |--------------|    |--------------|   |
   |                                                                |
   |                           SOC                                  |
   |-----------------------------------------------------------------

Under normal circumstances, run the reboot command and rmmod the
corresponding usb module, it will carry out the corresponding state
processing, all of which can work well.

Balbi, for this case, Currently, the way I can think of is to reset the
DCTL register every initial time. Could you help me and give me some
suggestions? thank you very much!

BR,
Dejin

> -- 
> balbi


