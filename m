Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8DB294BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 13:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442026AbgJULfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 07:35:10 -0400
Received: from foss.arm.com ([217.140.110.172]:34006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410786AbgJULfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:35:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 193021FB;
        Wed, 21 Oct 2020 04:35:09 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99F013F66E;
        Wed, 21 Oct 2020 04:35:07 -0700 (PDT)
Date:   Wed, 21 Oct 2020 12:35:05 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 10/11] [DEBUG] firmware: arm_scmi: add custom_dummy SCMI
 devname
Message-ID: <20201021113505.GD20482@e120937-lin>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-11-cristian.marussi@arm.com>
 <c0a300b7-7589-bfb1-6731-f07fdd7391fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0a300b7-7589-bfb1-6731-f07fdd7391fd@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:49:23PM -0400, Thara Gopinath wrote:
> 
> 
> On 10/14/20 11:05 AM, Cristian Marussi wrote:
> > Add custom_dummy SCMI devname.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >   drivers/firmware/arm_scmi/driver.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 55df134c2338..5c39a738866a 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -993,6 +993,7 @@ static struct scmi_prot_devnames devnames[] = {
> >   	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
> >   	{ SCMI_PROTOCOL_SENSOR, { "hwmon" },},
> >   	{ SCMI_PROTOCOL_RESET,  { "reset" },},
> > +	{ SCMI_PROTOCOL_CUSTOM_DUMMY,  { "custom_dummy" },},
> 
> Hi Cristian,
> 
> Thanks for the sample dummy custom protocol and driver!
> The problem with adding scmi devname into the array is that every time a
> custom vendor protocol is added, the array has to be extended. Instead since
> the scmi spec supports the range 0x80-0xff for custom protocols, why not
> check for that range in scmi_create_protocol_devices and go ahead with
> registering the creating the protocol device via
> scmi_create_protocol_device?
> 

Hi,

so this is really a good point, and in fact in some earlier (non-public)
iterations I had a mechanism to just get rid of these device tables,
thinking that if you want to enable custom protocols loading, it seemed
better to let the related devices being created dynamically at will, so
that an SCMI driver can just 'declare' its own device name and that will
be created if the corresponding protocol is found in the DT and
implemented in fw.

Anyway this complicated the code a lot in some dubious ways.

In a built-in scenario you end up with your driver being probe before the
platform SCMI driver, so you cannot create the device straight away in
your driver (there's not even an SCMI bus still) and you anyway need the
platform SCMI driver to be up and running to check the DT and initialize
basic transport to talk to the fw and check the protocol is supported by
fw before creating the device itself: so I ended up basically having the
SCMI driver just 'requesting' some device name to the core and then having
the core creating the device later on when the SCMI platform was probed
iff the DT and the fw supported that protocol (or immediately if your
driver was a module and the SCMI platform was already initialized)

All of the above, even if working, led to a lot of machinery to track all
these requested devices properly and properly create/destroy them, and
also it does not seem the right thing to do, since it's basically
mimicing/duplicating all the usual probe deferring standard mechanism.

Maybe this could have been addressed in different ways but I've not
explored further.

So at the end I removed such dynamic device creation support from this
series.

Now you proposal would be, if I understood correctly, to just create
straight away a custom device whenever its protocol is defined in the DT
and supported by fw, so that the custom driver above would not have to
declare anything statically, and it will just be associated with some
"dev_proto_99" matching just on protocol number.

I'd like this option because it simplifies a lot the above issues, but
I don't think it is viable because in this way you are no more able to
define 2 distinct SCMI drivers for the same protocol (like you
can do now defining multiple names in the match table: as an example you
could not create a different "custom_dummy_2" SCMI driver using the
custom protocol 0x99, because there;s only one single "dev_proto_99"
device created and already probed for "custom_dummy".

So the problem is again that if you want to support multiple SCMI
drivers they have to be able to declare their own devname, against which
the platform SCMI driver can match and initialized if needed the
underlying device.

In short, I want certainly to explore the dynamic device creation
further, but for the moment I put it apart trying to consolidate
all the rest.

Maybe I could re-introduce something better later on in future versions
of this series, or maybe just address this a distinct series later on.

Sorry for the flood-style email :D

Thanks

Cristian

> 
> >   };
> >   static inline void
> > 
> 
> -- 
> Warm Regards
> Thara
