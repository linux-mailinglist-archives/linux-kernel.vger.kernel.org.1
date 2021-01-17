Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93262F9309
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 15:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbhAQOty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 09:49:54 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:34100 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbhAQOtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 09:49:50 -0500
Received: by mail-wm1-f49.google.com with SMTP id o10so4609221wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 06:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XHHf+iue2BxLM/WGqtMEK5pmx9VJuHdNkcQprQEA1vw=;
        b=RmwDMzTzaKNjSu/QvzIT/9tGnSrHfJoJJlhVpbx7XPNHME78m1McJZ/yaOzalxz2rr
         cHw9AuF+gZyBRsHehCU6gCSs3+ozQSCwM7RmwSM14zBVrfxl/Okibm26M93V8WMBqlW8
         FJJl1PGt0+s74K/qTOy0vwimotCe4UyND+bYUX2oWXztwtz9D2cYFSKn3iPegnUsIytI
         h6litJLL6rMc5G/Ib1xlPF8wBxvxjOqNVOVcsnKVJrQBOmXJ8tzGgjNZ/8Kf3wTEzAbL
         YNdeh7ZOLeGWJfkgB3xDHGBIJObPkuMkaxJeKGQZZG0++dLtaMkdyd3r002TfOMaH3wj
         3vBA==
X-Gm-Message-State: AOAM531X7PN90Z5fQp/N7g+r9wPDs2FOKE7+DkQ9GVYIzetqChUuO85h
        AhYkjwl0ost5+OMoeosDH3U=
X-Google-Smtp-Source: ABdhPJyzs3GBXz5bcEpE7CByhSceIjtMqwf4rqfZzePRWfcK4t4daXbBxWdFOKQbwjhNxxcomLNPHg==
X-Received: by 2002:a05:600c:22c6:: with SMTP id 6mr16862688wmg.33.1610894946971;
        Sun, 17 Jan 2021 06:49:06 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z15sm24309400wrv.67.2021.01.17.06.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 06:49:06 -0800 (PST)
Date:   Sun, 17 Jan 2021 14:49:05 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        tyhicks@linux.microsoft.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Gromm <christian.gromm@microchip.com>
Subject: Re: [PATCH] fTPM: make sure TEE is initialized before fTPM
Message-ID: <20210117144905.sii73h6oqovcpmc6@liuwe-devbox-debian-v2>
References: <20210116001301.16861-1-wei.liu@kernel.org>
 <b9d69278-9f69-041f-9cef-58584eac435c@infradead.org>
 <20210116115529.oq2k2qpgyawngcqn@liuwe-devbox-debian-v2>
 <20210116121109.xenpxbobni4glecg@liuwe-devbox-debian-v2>
 <YAP1dvf7ZinwXdV9@kroah.com>
 <20210117142127.vqgrfzld42sfsylb@liuwe-devbox-debian-v2>
 <YARKcWQSb4TdVM4h@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YARKcWQSb4TdVM4h@kroah.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 03:32:17PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Jan 17, 2021 at 02:21:27PM +0000, Wei Liu wrote:
> > On Sun, Jan 17, 2021 at 09:29:42AM +0100, Greg Kroah-Hartman wrote:
> > > On Sat, Jan 16, 2021 at 12:11:09PM +0000, Wei Liu wrote:
> > > > On Sat, Jan 16, 2021 at 11:55:29AM +0000, Wei Liu wrote:
> > > > > On Fri, Jan 15, 2021 at 04:49:57PM -0800, Randy Dunlap wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On 1/15/21 4:12 PM, Wei Liu wrote:
> > > > > > > For built-in drivers, the order of initialization function invocation is
> > > > > > > determined by their link order.
> > > > > > > 
> > > > > > > The original code linked TPM drivers before TEE driver when they were
> > > > > > > both built in. That caused fTPM's initialization to be deferred to a
> > > > > > > worker thread instead of running on PID 1.
> > > > > > > 
> > > > > > > That is problematic because IMA's initialization routine, which runs on
> > > > > > > PID 1 as a late initcall, needs to have access to the default TPM
> > > > > > > instance. If fTPM's initialization is deferred, IMA will not be able to
> > > > > > > get hold of a TPM instance in time.
> > > > > > > 
> > > > > > > Fix this by modifying Makefile to make sure TEE is initialized before
> > > > > > > fTPM when they are both built in.
> > > > > > > 
> > > > > > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > > > > > ---
> > > > > > >  drivers/Makefile | 5 +++++
> > > > > > >  1 file changed, 5 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/Makefile b/drivers/Makefile
> > > > > > > index fd11b9ac4cc3..45ea5ec9d0fd 100644
> > > > > > > --- a/drivers/Makefile
> > > > > > > +++ b/drivers/Makefile
> > > > > > > @@ -180,6 +180,11 @@ obj-$(CONFIG_NVMEM)		+= nvmem/
> > > > > > >  obj-$(CONFIG_FPGA)		+= fpga/
> > > > > > >  obj-$(CONFIG_FSI)		+= fsi/
> > > > > > >  obj-$(CONFIG_TEE)		+= tee/
> > > > > > > +
> > > > > > > +# TPM drivers must come after TEE, otherwise fTPM initialization will be
> > > > > > > +# deferred, which causes IMA to not get a TPM device in time
> > > > > > > +obj-$(CONFIG_TCG_TPM)		+= char/tpm/
> > > > > > > +
> > > > > > >  obj-$(CONFIG_MULTIPLEXER)	+= mux/
> > > > > > >  obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
> > > > > > >  obj-$(CONFIG_SIOX)		+= siox/
> > > > > > > 
> > > > > > 
> > > > > > As I suspected and then tested, since you did not remove the other build
> > > > > > of char/tpm/, this ends up with multiple definition linker errors (below).
> > > > > 
> > > > > Oops, I didn't commit the hunk that removed the line in char/Makefile.
> > > > > 
> > > > > But I will hold off sending out v2 until the following discussion is
> > > > > settled.
> > > > > 
> > > > > > 
> > > > > > I would think that instead of depending on Makefile order you should use different
> > > > > > initcall levels as needed. Depending on Makefile order is what we did 15 years ago.
> > > > > > 
> > > > > 
> > > > > No, not really. The same trick was used in 2014 (1bacc894c227).
> > > > > 
> > > > > Both TEE and TPM are just drivers. I think they belong to the same level
> > > > > (at the moment device_initcall).  Looking at the list of levels, I'm not
> > > > > sure how I can move TEE to a different level.
> > > > > 
> > > > > Out of the seven levels, which one would you suggest I use for which
> > > > > driver?
> > > > 
> > > > A bit more random thought.
> > > > 
> > > > Moving one driver to a different level is not the solution either. What
> > > > if there is a dependency chain in the future in which more than 2
> > > > drivers are involved? Do we invent more levels or abuse levels that
> > > > aren't supposed to be used by device drivers?
> > > > 
> > > > The proper solution to me is to somehow sort the initcalls with their
> > > > dependencies in mind. The requires quite a bit of engineering
> > > > (integrating depmod into kernel build?). Given that there are only a few
> > > > cases, I don't think effort would be worth it.
> > > 
> > > Make it an explicit dependancy in the driver, and then things will be
> > > loaded properly.
> > 
> > I take it you mean using MODULE_SOFTDEP to do that?
> 
> That's one way, or just explicitly depend on a symbol in the other
> module.
> 
> > > You can always defer your probe if you do not have all
> > > of the proper resources, which is how these types of things are handled,
> > > instead of worrying about creating new init levels.
> > 
> > 
> > fTPM's probe is already deferred in current Linux without this patch.
> 
> What patch?

The one you're replying to right now.

> 
> > It
> > will eventually show up in Linux but at that point it is too late for
> > Linux's Integrity Measurement Architecture to use it.
> 
> How can it be "too late"?

See security/integrity/ima/ima_init.c.

int __init ima_init(void)
{
        int rc;

        ima_tpm_chip = tpm_default_chip();
        if (!ima_tpm_chip)
                pr_info("No TPM chip found, activating TPM-bypass!\n");
...
}

ima_init is called by init_ima which is a late initcall.

> 
> > The probe getting deferred is exactly what I tried to avoid here.  :-)
> 
> Then don't start up IMA without it?

IMA can't be built as a module, so it seems to me you're suggesting
adding synchronization between IMA and TPM drivers.

I'm not sure IMA initialization can or should be deferred though. As the
whole point is to measure the system.

> 
> I really don't know, but this feels like something is broken in your
> module...
> 

I don't disagree. I think having some sort of synchronization between
IMA and TPM drivers may work too. But that's outside of my expertise
and I will leave that to IMA and TPM maintainers.

Wei.

> thanks,
> 
> greg k-h
