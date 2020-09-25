Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34A327814C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgIYHMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYHMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:12:09 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB5420759;
        Fri, 25 Sep 2020 07:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601017928;
        bh=Z0ZVvRPpfsaiJcQiqcQFKPgpL3czOfPus0HdKagcgsg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cgadSunQUWPmmnfhpWv0mGqcErTSKCCgjkwwbpgQ16/z0DOQgQ9U0s338Qnt5JSzT
         sDV1wf9ckM8o7ZHPA++463CWn5izWaai34zDwW7ddPeaZzRIrmq6+QiBJ7N9LuKMqn
         /JlhUQ30kKG8sPoR7P1ncKs6FgS4amYLCJvlEbrM=
From:   Felipe Balbi <balbi@kernel.org>
To:     Manish Narani <MNARANI@xilinx.com>, Rob Herring <robh@kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation
 for Versal DWC3 Controller
In-Reply-To: <BYAPR02MB5896E374297AF46A63CDAD30C1360@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1599678185-119412-1-git-send-email-manish.narani@xilinx.com>
 <1599678185-119412-2-git-send-email-manish.narani@xilinx.com>
 <20200922195410.GA3122345@bogus> <87wo0jejae.fsf@kernel.org>
 <BYAPR02MB5896E374297AF46A63CDAD30C1360@BYAPR02MB5896.namprd02.prod.outlook.com>
Date:   Fri, 25 Sep 2020 10:11:59 +0300
Message-ID: <87h7rmcou8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Manish Narani <MNARANI@xilinx.com> writes:
> Hi Rob/Felipe,
>
> Thanks for the review.
>
>> -----Original Message-----
>> From: Felipe Balbi <balbi@kernel.org>
>> Sent: Thursday, September 24, 2020 12:47 PM
>> To: Rob Herring <robh@kernel.org>; Manish Narani <MNARANI@xilinx.com>
>> Cc: gregkh@linuxfoundation.org; Michal Simek <michals@xilinx.com>;
>> p.zabel@pengutronix.de; linux-usb@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; git <git@xilinx.com>
>> Subject: Re: [PATCH v2 1/2] dt-bindings: usb: dwc3-xilinx: Add
>> documentation for Versal DWC3 Controller
>>=20
>> Rob Herring <robh@kernel.org> writes:
>>=20
>> > On Thu, Sep 10, 2020 at 12:33:04AM +0530, Manish Narani wrote:
>> >> Add documentation for Versal DWC3 controller. Add required property
>> >> 'reg' for the same. Also add optional properties for snps,dwc3.
>> >>
>> >> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>> >> ---
>> >>  .../devicetree/bindings/usb/dwc3-xilinx.txt   | 20 +++++++++++++++++=
--
>> >>  1 file changed, 18 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
>> b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
>> >> index 4aae5b2cef56..219b5780dbee 100644
>> >> --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
>> >> +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
>> >> @@ -1,7 +1,8 @@
>> >>  Xilinx SuperSpeed DWC3 USB SoC controller
>> >>
>> >>  Required properties:
>> >> -- compatible:	Should contain "xlnx,zynqmp-dwc3"
>> >> +- compatible:	May contain "xlnx,zynqmp-dwc3" or "xlnx,versal-
>> dwc3"
>> >> +- reg:		Base address and length of the register control block
>> >>  - clocks:	A list of phandles for the clocks listed in clock-names
>> >>  - clock-names:	Should contain the following:
>> >>    "bus_clk"	 Master/Core clock, have to be >=3D 125 MHz for SS
>> >> @@ -13,12 +14,24 @@ Required child node:
>> >>  A child node must exist to represent the core DWC3 IP block. The nam=
e of
>> >>  the node is not important. The content of the node is defined in dwc=
3.txt.
>> >>
>> >> +Optional properties for snps,dwc3:
>> >> +- dma-coherent:	Enable this flag if CCI is enabled in design. Adding=
 this
>> >> +		flag configures Global SoC bus Configuration Register and
>> >> +		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
>> >> +- snps,enable-hibernation: Add this flag to enable hibernation suppo=
rt
>> for
>> >> +		peripheral mode.
>> >
>> > This belongs in the DWC3 binding. It also implies that hibernation is
>> > not supported by any other DWC3 based platform. Can't this be implied =
by
>> > the compatible string (in the parent)?
>
> Rob, We can move this to dwc3 bindings. If Felipe is okay with below resp=
onse.
>
>>=20
>> hibernation support is detectable in runtime, and we've been using that.
>
> Felipe, Yes, this flag is to control the enable/disable hibernation.
> I did not see has_hibernation flag being set anywhere in the driver.
> Can we control the hibernation enable/disable through DT entry? See below:
> -----
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 2eb34c8b4065..1baf44d8d566 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -769,8 +769,15 @@ static void dwc3_core_setup_global_control(struct dw=
c3 *dwc)
>                         reg &=3D ~DWC3_GCTL_DSBLCLKGTNG;
>                 break;
>         case DWC3_GHWPARAMS1_EN_PWROPT_HIB:
> -               /* enable hibernation here */
> -               dwc->nr_scratch =3D DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(hwp=
arams4);
> +               if (!device_property_read_bool(dwc->dev,
> +                                              "snps,enable-hibernation")=
) {
> +                       dev_dbg(dwc->dev, "Hibernation not enabled\n");
> +               } else {
> +                       /* enable hibernation here */
> +                       dwc->nr_scratch =3D
> +                               DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(hwparam=
s4);
> +                       dwc->has_hibernation =3D 1;
> +               }

I left it off because I didn't have HW to validate. Don't add a new
binding for this. Set has_hibernation to true and make sure it
works. Then send me a patch that sets has_hibernation to true whenever
DWC3_GHWPARAMS1_EN_PWROPT_HIB is valid.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9tmD8RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaeuA//chqZBfFbCdNea4PB44iidfAHUN7gLaIF
jd7JF0Hpu21Os4CEOyQLe9PJLLbKmEvwaX5L0cxp3mlhHEWB/TBDZweoYjiKUqC5
ywWFWBqeOzfSegfERqsECnKEvN23c57rkNh2DcGUcwv4dAmtUvp6MtVn2F6lW0i3
k0qOfuml4CTrbVrle9VkFKkHSBbm+l+x3b6x/n3VmyfdxYpupwLTzjsvVimODGQP
rQfSdIObIXVW+EEOJBmiVZGsaUZmZ3gfMNaHXEWGJqciRgjKqEURCRT+6RPt0UuQ
tsBM40736nPsr1bZZjVKEF1RFIXHxxZEQBD2dho58e8/SRYeBLPchOrdK4m0wp2P
ZVUqhpgoP+KdAGPsSE+Y+tdO9urF0/KFdHZyS0vv+1b53czMqsRdDppNFqgXtj3+
wkfLCP0kJB6R5uUUHYprlSi/Kxob7r6jh1KFjxr9EwV8SAIjM2Sb4fvdUPGvKfw1
0FAmla/DWWHwEuLpr/J7mHmjXH7Hq0XfNZTX9c3ESMuPgILNFYdV8xcrXD4T0GCZ
K7wBx69JBPYD45TyP0/fBSXXM3zATByw8xo9tsT64bFCBLxE2ahmGBNBR1g699rf
5Dh/PVVxPgZPxQFboiG8yiol0kWBSnlne8Y5LXkxMOCbhge4z+8384YEPpW65haK
g2F1XB7n7v8=
=/YVc
-----END PGP SIGNATURE-----
--=-=-=--
