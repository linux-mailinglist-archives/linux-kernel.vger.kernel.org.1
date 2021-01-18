Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E5B2FAB56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436972AbhARUXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394321AbhARUVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:21:05 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181D2C061573;
        Mon, 18 Jan 2021 12:20:25 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AA9712AE;
        Mon, 18 Jan 2021 20:20:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AA9712AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611001224; bh=QQ1I+dUwBoMKKtyX600ONRgIk/CHORbEYNoI6BaZqeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S3S6lJy+jvQOhGN8z1OlHItVAlKp5QI2q9Gnlr3xhzDHMc8UPNTGoZ9quWwYJDxjR
         6qKWTGLlnSPWxu89zDlo5O7ceJMRtz1WrJLo+Ce51zgwIG+1ri9K+u/AhrpZe7S+7Z
         x0emCPPQS6kBVeA1D6wtqUospSd782we4C0Mhf1c13NfPUsdOoxtVbwydFO9q1Ff33
         hZCR1Jc0dDxI0yNPjYAoY4vl3KxqU+CVDxC/Fsj3U+CyS1IY9r5yqk4IPp6W7y0ps2
         Ckh9gAzOUdtPeC82Byj/GczdX1MxW862ldEVR2z2Re9Q+VZg62jwd2m9mCjZiKpxXa
         obkMfc8ybbeKA==
Date:   Mon, 18 Jan 2021 13:20:23 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Michael Witten <mfwitten@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: driver-model: bus.rst: Clean up the
 formatting, expound, modernize
Message-ID: <20210118132023.20dfd07d@lwn.net>
In-Reply-To: <bca1170d131b4b46905f030232da3339@gmail.com>
References: <3dc7d8abd06941fca5071b0ede9b6088@gmail.com>
        <20210111133158.34923b4c@lwn.net>
        <bca1170d131b4b46905f030232da3339@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 05:35:00 -0000
Michael Witten <mfwitten@gmail.com> wrote:

We're getting closer...

> Thanks for your guidance.
> 
>   * Save this patch to:
> 
>       /path/to/email
> 
>     Then apply it with:
> 
>       git am --scissors /path/to/email

Folks in the kernel community don't need to be taught how to apply patches,
please leave this stuff out in the future.

As for this text:

>   * Here are the changes from the last patch:
> 
>        Definition
>        ~~~~~~~~~~
>       -* ``struct bus_type``;
>       -* ``int bus_register(struct bus_type *bus);``
>       +
>       +::
>       +
>       +	struct bus_type;
>       +	int bus_register(struct bus_type *bus);
> 
> 
>        Declaration
>        ~~~~~~~~~~~
> 
>        For each bus type (PCI, USB, etc), there should be code that defines
>       -one object of type ``struct bus_type``:
>       +one object of type struct bus_type:
> 
>        1. The definition should declare a file-scope identifier that has
>           external linkage.
>       @@ -53,7 +56,7 @@ The relevant API header should include the following declaration::
>        Registration
>        ~~~~~~~~~~~~
> 
>       -During initialization of a bus driver, ``bus_register()`` is called; this
>       +During initialization of a bus driver, bus_register() is called; this
>        initializes the rest of the fields in the bus type object and inserts it
>        into a global list of bus types. Once the bus type object is registered,
>        the fields in it are usable by the bus driver.
>       @@ -77,8 +80,8 @@ particular device, without sacrificing bus-specific functionality or
>        type-safety.
> 
>        When a driver is registered with the bus, the bus's list of devices is
>       -iterated over, and the match callback is called for each device that
>       -does not have a driver associated with it.
>       +iterated over, and the ``match`` callback is called for each device that
>       +does not already have a driver associated with it.
> 
> 
> 
>       @@ -87,8 +90,8 @@ Device and Driver Lists
> 
>        There are generic facilities for keeping lists of devices and drivers:
> 
>       -* There is a list of ``struct device`` objects.
>       -* There is a list of ``struct device_driver`` objects.
>       +* There is a list of struct device objects.
>       +* There is a list of struct device_driver objects.
> 
>        Bus drivers are free to use the lists as they please, but conversion
>        to a bus-specific type may be necessary.
>       @@ -156,12 +159,21 @@ Exporting Attributes
>        		ssize_t (*store)(struct bus_type *, const char *buf, size_t count);
>        	};
> 
>       -Bus drivers can export attributes using the ``BUS_ATTR_RW()`` macro that works
>       -similarly to the ``DEVICE_ATTR_RW()`` macro for devices. For example, the
>       +Bus drivers can export attributes using the BUS_ATTR_RW() macro that works
>       +similarly to the DEVICE_ATTR_RW() macro for devices. For example, the
>        following are equivalent:
> 
>       -* ``static BUS_ATTR_RW(debug);``
>       -* ``static bus_attribute bus_attr_debug;``
>       +* ::
>       +
>       +	static BUS_ATTR_RW(something);
>       +
>       +* ::
>       +
>       +	static struct bus_attribute bus_attr_something = {
>       +		.attr  = { .name = "something", .mode = 0644 },
>       +		.show  = something_show,   // These functions must be
>       +		.store = something_store   // defined or declared already.
>       +	};
> 
>        This can then be used to add or remove the attribute from the bus's
>        sysfs directory using::

...please:

 - Describe your changes *concisely*, at a higher level.  Don't make
   maintainers try to figure out what you did from a patch-to-a-patch like
   this.

- Put this information after the "---" line at the end of the changelog.

> * The reStructuredText had some indentation issues (I only fixed the
>   areas I touched).

This is good, but why not complete the job while you're in the area?

> * The HTML output was not properly formatted in places.
> 
> * Some of the details were lacking or needed clarification (especially
>   with regard to how a `struct bus_type` object should be defined).

Each patch should do one thing; here you're mixing formatting cleanups with
actual text changes.  Those should be split ingo separate patches, please.

> * The sysfs example hierarchy appeared outdated; I've updated it with
>   output based on what my own system currently displays.
> 
> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> ---
>  Documentation/driver-api/driver-model/bus.rst | 120 ++++++++++++------
>  1 file changed, 78 insertions(+), 42 deletions(-)
> 
> diff --git a/Documentation/driver-api/driver-model/bus.rst b/Documentation/driver-api/driver-model/bus.rst
> index 016b15a6e8ea..9a4cf15df8b9 100644
> --- a/Documentation/driver-api/driver-model/bus.rst
> +++ b/Documentation/driver-api/driver-model/bus.rst
> @@ -4,34 +4,61 @@ Bus Types
>  
>  Definition
>  ~~~~~~~~~~
> -See the kerneldoc for the struct bus_type.
>  
> -int bus_register(struct bus_type * bus);
> +::
> +
> +	struct bus_type;
> +	int bus_register(struct bus_type *bus);

This seems not entirely helpful, somehow.  If you're really just going to
list these, consider pulling in the relevant kerneldoc comments instead.

>  Declaration
>  ~~~~~~~~~~~
>  
> -Each bus type in the kernel (PCI, USB, etc) should declare one static
> -object of this type. They must initialize the name field, and may
> -optionally initialize the match callback::
> +For each bus type (PCI, USB, etc), there should be code that defines
> +one object of type struct bus_type:
> +
> +1. The definition should declare a file-scope identifier that has
> +   external linkage.
> +
> +   * There should be a header that provides a declaration of this
> +     identifier.
> +
> +   * The identifier should be explicitly exported.

I'm honestly not sure why this change was made or what you are trying to
say here.

> +2. The definition should initialize the ``name`` member. Other
> +   members may also be initialized (such as the ``match`` callback
> +   member).
>  
> -   struct bus_type pci_bus_type = {
> -          .name	= "pci",
> -          .match	= pci_bus_match,
> -   };
> +For instance, here is the definition for the PCI bus type::
>  
> -The structure should be exported to drivers in a header file:
> +	struct bus_type pci_bus_type = {
> +		.name          = "pci",               // REQUIRED
> +		.match         = pci_bus_match,
> +		.uevent        = pci_uevent,
> +		.probe         = pci_device_probe,
> +		.remove        = pci_device_remove,
> +		.shutdown      = pci_device_shutdown,
> +		.dev_groups    = pci_dev_groups,
> +		.bus_groups    = pci_bus_groups,
> +		.drv_groups    = pci_drv_groups,
> +		.pm            = PCI_PM_OPS_PTR,
> +		.num_vf        = pci_bus_num_vf,
> +		.dma_configure = pci_dma_configure,
> +	};
>  
> -extern struct bus_type pci_bus_type;
> +	EXPORT_SYMBOL(pci_bus_type);
> +
> +The relevant API header should include the following declaration::
> +
> +	extern struct bus_type pci_bus_type;
>  
>  
>  Registration
>  ~~~~~~~~~~~~
>  
> -When a bus driver is initialized, it calls bus_register. This
> -initializes the rest of the fields in the bus object and inserts it
> -into a global list of bus types. Once the bus object is registered,
> +During initialization of a bus driver, bus_register() is called; this

Why the switch to passive voice here?

> +initializes the rest of the fields in the bus type object and inserts it
> +into a global list of bus types. Once the bus type object is registered,
>  the fields in it are usable by the bus driver.
>  
>  
> @@ -53,30 +80,33 @@ particular device, without sacrificing bus-specific functionality or
>  type-safety.
>  
>  When a driver is registered with the bus, the bus's list of devices is
> -iterated over, and the match callback is called for each device that
> -does not have a driver associated with it.
> +iterated over, and the ``match`` callback is called for each device that
> +does not already have a driver associated with it.
>  
>  
>  
>  Device and Driver Lists
>  ~~~~~~~~~~~~~~~~~~~~~~~
>  
> -The lists of devices and drivers are intended to replace the local
> -lists that many buses keep. They are lists of struct devices and
> -struct device_drivers, respectively. Bus drivers are free to use the
> -lists as they please, but conversion to the bus-specific type may be
> -necessary.
> +There are generic facilities for keeping lists of devices and drivers:
> +
> +* There is a list of struct device objects.
> +* There is a list of struct device_driver objects.
> +
> +Bus drivers are free to use the lists as they please, but conversion
> +to a bus-specific type may be necessary.

I'm not convinced this change is really helpful either.

Finally, changes like this should also be copied to the people who maintain
the bus code; that would be Greg KH if nobody else.

Thanks,

jon
