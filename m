Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0D429D2DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgJ1VhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:37:19 -0400
Received: from foss.arm.com ([217.140.110.172]:38000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgJ1VhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:37:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69ADA1C0A;
        Wed, 28 Oct 2020 14:28:45 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92AEA3F66E;
        Wed, 28 Oct 2020 14:28:43 -0700 (PDT)
Date:   Wed, 28 Oct 2020 21:28:41 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 10/11] [DEBUG] firmware: arm_scmi: add custom_dummy SCMI
 devname
Message-ID: <20201028212841.GH20482@e120937-lin>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-11-cristian.marussi@arm.com>
 <c0a300b7-7589-bfb1-6731-f07fdd7391fd@linaro.org>
 <20201021113505.GD20482@e120937-lin>
 <7658875c-ea5f-d231-9514-5021e9d62807@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7658875c-ea5f-d231-9514-5021e9d62807@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Oct 26, 2020 at 08:37:46AM -0400, Thara Gopinath wrote:
> 
> 
> On 10/21/20 7:35 AM, Cristian Marussi wrote:
> > On Tue, Oct 20, 2020 at 10:49:23PM -0400, Thara Gopinath wrote:
> > > 
> > > 
> > > On 10/14/20 11:05 AM, Cristian Marussi wrote:
> > > > Add custom_dummy SCMI devname.
> > > > 
> > > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > > ---
> > > >    drivers/firmware/arm_scmi/driver.c | 1 +
> > > >    1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > > > index 55df134c2338..5c39a738866a 100644
> > > > --- a/drivers/firmware/arm_scmi/driver.c
> > > > +++ b/drivers/firmware/arm_scmi/driver.c
> > > > @@ -993,6 +993,7 @@ static struct scmi_prot_devnames devnames[] = {
> > > >    	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
> > > >    	{ SCMI_PROTOCOL_SENSOR, { "hwmon" },},
> > > >    	{ SCMI_PROTOCOL_RESET,  { "reset" },},
> > > > +	{ SCMI_PROTOCOL_CUSTOM_DUMMY,  { "custom_dummy" },},
> > > 
> > > Hi Cristian,
> > > 
> > > Thanks for the sample dummy custom protocol and driver!
> > > The problem with adding scmi devname into the array is that every time a
> > > custom vendor protocol is added, the array has to be extended. Instead since
> > > the scmi spec supports the range 0x80-0xff for custom protocols, why not
> > > check for that range in scmi_create_protocol_devices and go ahead with
> > > registering the creating the protocol device via
> > > scmi_create_protocol_device?
> > > 
> > 
> > Hi,
> > 
> > so this is really a good point, and in fact in some earlier (non-public)
> > iterations I had a mechanism to just get rid of these device tables,
> > thinking that if you want to enable custom protocols loading, it seemed
> > better to let the related devices being created dynamically at will, so
> > that an SCMI driver can just 'declare' its own device name and that will
> > be created if the corresponding protocol is found in the DT and
> > implemented in fw.
> > 
> > Anyway this complicated the code a lot in some dubious ways.
> > 
> > In a built-in scenario you end up with your driver being probe before the
> > platform SCMI driver, so you cannot create the device straight away in
> > your driver (there's not even an SCMI bus still) and you anyway need the
> > platform SCMI driver to be up and running to check the DT and initialize
> > basic transport to talk to the fw and check the protocol is supported by
> > fw before creating the device itself: so I ended up basically having the
> > SCMI driver just 'requesting' some device name to the core and then having
> > the core creating the device later on when the SCMI platform was probed
> > iff the DT and the fw supported that protocol (or immediately if your
> > driver was a module and the SCMI platform was already initialized)
> > 
> > All of the above, even if working, led to a lot of machinery to track all
> > these requested devices properly and properly create/destroy them, and
> > also it does not seem the right thing to do, since it's basically
> > mimicing/duplicating all the usual probe deferring standard mechanism.
> > 
> > Maybe this could have been addressed in different ways but I've not
> > explored further.
> > 
> > So at the end I removed such dynamic device creation support from this
> > series.
> > 
> > Now you proposal would be, if I understood correctly, to just create
> > straight away a custom device whenever its protocol is defined in the DT
> > and supported by fw, so that the custom driver above would not have to
> > declare anything statically, and it will just be associated with some
> > "dev_proto_99" matching just on protocol number.
> > 
> > I'd like this option because it simplifies a lot the above issues, but
> > I don't think it is viable because in this way you are no more able to
> > define 2 distinct SCMI drivers for the same protocol (like you
> > can do now defining multiple names in the match table: as an example you
> > could not create a different "custom_dummy_2" SCMI driver using the
> > custom protocol 0x99, because there;s only one single "dev_proto_99"
> > device created and already probed for "custom_dummy".
> 
> Hi,
> 
> Apologies for the delay in this reply as it took me a while to figure out in
> the code what is happening around this. So if I understand you correctly,
> the table is required to support multiple drivers (which is today 2) for a
> protocol which in turn means creating devices for these drivers. But
> drivers/firmware/arm_scmi/driver.c is the wrong place to define these dev
> names. Like any other device/driver pair in the kernel , why is this info
> not conveyed from DT ?
> 

I suppose the original implememtation did this because the devices have to
be created as child of the SCMI bus if and only if the related protocol
is defined in the DT and the fw is determined to support such protocol
at run-time: for these reasons the device creation is delegated to the
SCMI platform driver which takes care, once is up (matches on arm,scmi),
to parse the DT and after initializing the proper transport (as described
in the DT) to check with the fw if the protocol is support by that SCMI
instance.

So the module device table is a way for the drivers to tell the core SCMI
platform driver that they exist and need a device, but the final decision
as to create them 9and having them probed after attaching to the SCMI
bus) or not is up to the SCMI platform bus driver.

Consider also that you could have multiple instance of SCMI servers and
so multple instances of your driver/devices could be needed: every SCMI
driver instance currenly creates a distinct device for each of these possible
devices (even though not so much tested probably :D)

> It should be fairly straightforward to have scmi_dev_match_id to match the
> device compatible string passed via dt node with a driver  that is attached
> to scmi_bus.
> 

But maybe there's a simple way to do it as you said with the DT, while
keeping the above constraints..I'll look into this for V3 (unless some
more heavy rework would be needed following reviews...)

> Now, the questions is, is there any existing implementation that requires 2
> separate devices with 2 separate drivers for a protocol? I am using 2 here
> because MAX_SCMI_DEV_PER_PROTOCOL is defined as 2 today in the framework. If
> not, I will just drop this and just create a device for every protocol that
> gets conveyed from DT. If yes, I will look at passing that info from DT
> either as a compatible string or as a number so that you can dynamically
> build the name when creating device.

There is for sure a partner that is developing a sensor SCMI driver
which is going to work aside the existing scmi-hwmon...and I think there
should be also other cases, since Sudeep added such possibility of
multiple devices per protocol well before this partner project came
along. I'll check with him.
I'll explore further DT based device generation (and also check with
Sudeep if we want really to add more DT entries...)

One more interesting thing in these regards it's that from the reqs pnt
of view, we should really not care to associate a specific protocol to
an SCMI driver, because even though a specific SCMI driver will
certainly use mainly if not only one protocol (notifications apart), it
is really not bound as of now (nor was before this series) to use a
single protocol, but it could grab multiple operations anyway.

> The problem with this table is every time anyone wants to support a new
> driver, the table has to be updated. Ideally, framework files should not
> require any modification to support an extension protocol.
> 

I agree...as said I had previously a clunky solution which did not seem right
but indeed was successfully generating devices dynamically.

> > 
> > So the problem is again that if you want to support multiple SCMI
> > drivers they have to be able to declare their own devname, against which
> > the platform SCMI driver can match and initialized if needed the
> > underlying device.
> > 
> > In short, I want certainly to explore the dynamic device creation
> > further, but for the moment I put it apart trying to consolidate
> > all the rest.
> > 
> > Maybe I could re-introduce something better later on in future versions
> > of this series, or maybe just address this a distinct series later on.
> > 
> > Sorry for the flood-style email :D
> 
> No issues!
> 
... so I'll keep spamming you :P

Thanks

Cristian

> > 
> > Thanks
> > 
> > Cristian
> > 
> > > 
> > > >    };
> > > >    static inline void
> > > > 
> > > 
> > > -- 
> > > Warm Regards
> > > Thara
> 
> -- 
> Warm Regards
> Thara
