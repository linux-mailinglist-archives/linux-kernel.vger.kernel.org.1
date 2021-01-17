Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0762F92F5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 15:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbhAQOdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 09:33:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbhAQOdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 09:33:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0114320791;
        Sun, 17 Jan 2021 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610893939;
        bh=fC0xE+/aPbZTMKCRNvqaATbwzFKoHIbiqX9FSPt4u/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmuP7loAyQwV1D2OBPwxl3wTMhCZPRoYa/4OYT7GQWfDFkWIZdT2fWzqSFLt/chhS
         tjc4+LcY8n3iMen51+6MqG0oHNplwibBiLErIkwCu5Ga2U1FroDqPa0JGPPY68Hj1q
         cw+3v4amhdLZaxDjL6tBXBpqWYTrMlcuz9XfVij4=
Date:   Sun, 17 Jan 2021 15:32:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        tyhicks@linux.microsoft.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Gromm <christian.gromm@microchip.com>
Subject: Re: [PATCH] fTPM: make sure TEE is initialized before fTPM
Message-ID: <YARKcWQSb4TdVM4h@kroah.com>
References: <20210116001301.16861-1-wei.liu@kernel.org>
 <b9d69278-9f69-041f-9cef-58584eac435c@infradead.org>
 <20210116115529.oq2k2qpgyawngcqn@liuwe-devbox-debian-v2>
 <20210116121109.xenpxbobni4glecg@liuwe-devbox-debian-v2>
 <YAP1dvf7ZinwXdV9@kroah.com>
 <20210117142127.vqgrfzld42sfsylb@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117142127.vqgrfzld42sfsylb@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 02:21:27PM +0000, Wei Liu wrote:
> On Sun, Jan 17, 2021 at 09:29:42AM +0100, Greg Kroah-Hartman wrote:
> > On Sat, Jan 16, 2021 at 12:11:09PM +0000, Wei Liu wrote:
> > > On Sat, Jan 16, 2021 at 11:55:29AM +0000, Wei Liu wrote:
> > > > On Fri, Jan 15, 2021 at 04:49:57PM -0800, Randy Dunlap wrote:
> > > > > Hi,
> > > > > 
> > > > > On 1/15/21 4:12 PM, Wei Liu wrote:
> > > > > > For built-in drivers, the order of initialization function invocation is
> > > > > > determined by their link order.
> > > > > > 
> > > > > > The original code linked TPM drivers before TEE driver when they were
> > > > > > both built in. That caused fTPM's initialization to be deferred to a
> > > > > > worker thread instead of running on PID 1.
> > > > > > 
> > > > > > That is problematic because IMA's initialization routine, which runs on
> > > > > > PID 1 as a late initcall, needs to have access to the default TPM
> > > > > > instance. If fTPM's initialization is deferred, IMA will not be able to
> > > > > > get hold of a TPM instance in time.
> > > > > > 
> > > > > > Fix this by modifying Makefile to make sure TEE is initialized before
> > > > > > fTPM when they are both built in.
> > > > > > 
> > > > > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > > > > ---
> > > > > >  drivers/Makefile | 5 +++++
> > > > > >  1 file changed, 5 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/Makefile b/drivers/Makefile
> > > > > > index fd11b9ac4cc3..45ea5ec9d0fd 100644
> > > > > > --- a/drivers/Makefile
> > > > > > +++ b/drivers/Makefile
> > > > > > @@ -180,6 +180,11 @@ obj-$(CONFIG_NVMEM)		+= nvmem/
> > > > > >  obj-$(CONFIG_FPGA)		+= fpga/
> > > > > >  obj-$(CONFIG_FSI)		+= fsi/
> > > > > >  obj-$(CONFIG_TEE)		+= tee/
> > > > > > +
> > > > > > +# TPM drivers must come after TEE, otherwise fTPM initialization will be
> > > > > > +# deferred, which causes IMA to not get a TPM device in time
> > > > > > +obj-$(CONFIG_TCG_TPM)		+= char/tpm/
> > > > > > +
> > > > > >  obj-$(CONFIG_MULTIPLEXER)	+= mux/
> > > > > >  obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
> > > > > >  obj-$(CONFIG_SIOX)		+= siox/
> > > > > > 
> > > > > 
> > > > > As I suspected and then tested, since you did not remove the other build
> > > > > of char/tpm/, this ends up with multiple definition linker errors (below).
> > > > 
> > > > Oops, I didn't commit the hunk that removed the line in char/Makefile.
> > > > 
> > > > But I will hold off sending out v2 until the following discussion is
> > > > settled.
> > > > 
> > > > > 
> > > > > I would think that instead of depending on Makefile order you should use different
> > > > > initcall levels as needed. Depending on Makefile order is what we did 15 years ago.
> > > > > 
> > > > 
> > > > No, not really. The same trick was used in 2014 (1bacc894c227).
> > > > 
> > > > Both TEE and TPM are just drivers. I think they belong to the same level
> > > > (at the moment device_initcall).  Looking at the list of levels, I'm not
> > > > sure how I can move TEE to a different level.
> > > > 
> > > > Out of the seven levels, which one would you suggest I use for which
> > > > driver?
> > > 
> > > A bit more random thought.
> > > 
> > > Moving one driver to a different level is not the solution either. What
> > > if there is a dependency chain in the future in which more than 2
> > > drivers are involved? Do we invent more levels or abuse levels that
> > > aren't supposed to be used by device drivers?
> > > 
> > > The proper solution to me is to somehow sort the initcalls with their
> > > dependencies in mind. The requires quite a bit of engineering
> > > (integrating depmod into kernel build?). Given that there are only a few
> > > cases, I don't think effort would be worth it.
> > 
> > Make it an explicit dependancy in the driver, and then things will be
> > loaded properly.
> 
> I take it you mean using MODULE_SOFTDEP to do that?

That's one way, or just explicitly depend on a symbol in the other
module.

> > You can always defer your probe if you do not have all
> > of the proper resources, which is how these types of things are handled,
> > instead of worrying about creating new init levels.
> 
> 
> fTPM's probe is already deferred in current Linux without this patch.

What patch?

> It
> will eventually show up in Linux but at that point it is too late for
> Linux's Integrity Measurement Architecture to use it.

How can it be "too late"?

> The probe getting deferred is exactly what I tried to avoid here.  :-)

Then don't start up IMA without it?

I really don't know, but this feels like something is broken in your
module...

thanks,

greg k-h
