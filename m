Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394EA276A73
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgIXHQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgIXHQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:16:50 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC72A20936;
        Thu, 24 Sep 2020 07:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600931809;
        bh=oFLY62TJgHh8pZ8uAIN/iFnnuE+w2IUAcEdP3wJ0qP0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=V7HkS4k7c/lJjO1VAeIyqVG8+nofirtVlkifPRFCCJqKcYsqfm1ccPWbUE5RW67Xe
         RMB4OM8jx/oGLmqfpojNnArVIKG6y/fMdECxi31AZFhk/1rUJCfQeNiroyQL6Qb2LS
         Nr3VzxuaV7wb5XA45/btaED4JWJgS3HF8dRjqgnQ=
From:   Felipe Balbi <balbi@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        p.zabel@pengutronix.de, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation
 for Versal DWC3 Controller
In-Reply-To: <20200922195410.GA3122345@bogus>
References: <1599678185-119412-1-git-send-email-manish.narani@xilinx.com>
 <1599678185-119412-2-git-send-email-manish.narani@xilinx.com>
 <20200922195410.GA3122345@bogus>
Date:   Thu, 24 Sep 2020 10:16:41 +0300
Message-ID: <87wo0jejae.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Rob Herring <robh@kernel.org> writes:

> On Thu, Sep 10, 2020 at 12:33:04AM +0530, Manish Narani wrote:
>> Add documentation for Versal DWC3 controller. Add required property
>> 'reg' for the same. Also add optional properties for snps,dwc3.
>>=20
>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>> ---
>>  .../devicetree/bindings/usb/dwc3-xilinx.txt   | 20 +++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt b/Doc=
umentation/devicetree/bindings/usb/dwc3-xilinx.txt
>> index 4aae5b2cef56..219b5780dbee 100644
>> --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
>> +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
>> @@ -1,7 +1,8 @@
>>  Xilinx SuperSpeed DWC3 USB SoC controller
>>=20=20
>>  Required properties:
>> -- compatible:	Should contain "xlnx,zynqmp-dwc3"
>> +- compatible:	May contain "xlnx,zynqmp-dwc3" or "xlnx,versal-dwc3"
>> +- reg:		Base address and length of the register control block
>>  - clocks:	A list of phandles for the clocks listed in clock-names
>>  - clock-names:	Should contain the following:
>>    "bus_clk"	 Master/Core clock, have to be >=3D 125 MHz for SS
>> @@ -13,12 +14,24 @@ Required child node:
>>  A child node must exist to represent the core DWC3 IP block. The name of
>>  the node is not important. The content of the node is defined in dwc3.t=
xt.
>>=20=20
>> +Optional properties for snps,dwc3:
>> +- dma-coherent:	Enable this flag if CCI is enabled in design. Adding th=
is
>> +		flag configures Global SoC bus Configuration Register and
>> +		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
>> +- snps,enable-hibernation: Add this flag to enable hibernation support =
for
>> +		peripheral mode.
>
> This belongs in the DWC3 binding. It also implies that hibernation is=20
> not supported by any other DWC3 based platform. Can't this be implied by=
=20
> the compatible string (in the parent)?

hibernation support is detectable in runtime, and we've been using that.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9sR9kRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYAig/+OhB2zQwnRA05Qkau2CCR0WR5Qjjg/a1P
3vsdNjgxOK55PaZfoIkAtlRXNGmtf9fwlSe37VbLT3FPMV3gs8C7w1Atk8KZhJr9
MuWIxyQV4hsbzB3+zmEn0xNCkTQK0m3h9S2oIVfsLgudon2iX6JYkpWxQrql7to+
yvgUx3fbd/eKqRwvRNHSnT6ZC1fSqsz+xUcbYX4/j9xSTM86D67En2sWzmeuAK+y
BdFvYzsrY/btPQAViC2lcfI6m+he0VoGl3b6lAhU8IOVT9b9/iUtsTt7ZRKDkuFO
woAZxK4E8H4tiayEdvxWqSJr123zdVmvEZr4PUWSYJM0kAgY84fTeTi/xazjba4q
i/wQ/EXtUx8Km0vfrtf5SK+d/PuW38QeTeusd7Sq14f0zmJYB3HWsMpb5it3W4A5
qkED951fHjipBE5S2KuhDyf5wY/fvxXE3NUH0pCIl9kQlzNyF2KkrEQVOC306JLc
MrZXuba9SjMeVgc5IwIpLZNUTFkmeSsgtd3Yywhg3egZoSD4VXIzBhg4X4Sn27UK
IGL1DF2XYdYJwgL+UuQKHtd2Wbu+6hxHc2cJhm1j8P5tXls0xeXz5zr7g40NzmYA
cMw8D5DLY51aLhPfyuweVejQULqEaghkayGoHRoh/v3Vx+3jX2DMnEn8YVEdLtIa
V384q0NUImE=
=/nk5
-----END PGP SIGNATURE-----
--=-=-=--
