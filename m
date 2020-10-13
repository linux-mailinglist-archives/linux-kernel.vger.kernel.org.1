Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B5F28D54A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 22:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbgJMUWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 16:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgJMUWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:22:36 -0400
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB261C061755;
        Tue, 13 Oct 2020 13:22:35 -0700 (PDT)
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id F08BEA5362F;
        Tue, 13 Oct 2020 22:22:33 +0200 (CEST)
Received: from antares.kleine-koenig.org ([94.130.110.236])
        by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236]) (amavisd-new, port 10024)
        with ESMTP id 4Wxr5H7seblq; Tue, 13 Oct 2020 22:22:33 +0200 (CEST)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5ad:20fc:fd89:49eb:2f37:ceb])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Tue, 13 Oct 2020 22:22:33 +0200 (CEST)
To:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Aditya Prayoga <aditya@kobol.io>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201013161340.720403-1-uwe@kleine-koenig.org>
 <20201013161340.720403-3-uwe@kleine-koenig.org>
 <a3957410-af99-5df4-8953-ffa3e7734aab@gmail.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Autocrypt: addr=uwe@kleine-koenig.org; prefer-encrypt=mutual; keydata=
 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
 6uMoO1VgFtcQHWHTtbSYLQ8YHVFZMQ==
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add basic support for
 Kobol's Helios64
Message-ID: <66aa4ffd-15f8-7c45-282e-e3bddc1af421@kleine-koenig.org>
Date:   Tue, 13 Oct 2020 22:22:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a3957410-af99-5df4-8953-ffa3e7734aab@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="EFmySqGc9wLe4xQFMwVQ4RywEhiWqPCmD"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EFmySqGc9wLe4xQFMwVQ4RywEhiWqPCmD
Content-Type: multipart/mixed; boundary="5GxXSquKfhfE2ENUX41Slk1qArKyPvUxu";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Aditya Prayoga <aditya@kobol.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <66aa4ffd-15f8-7c45-282e-e3bddc1af421@kleine-koenig.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add basic support for
 Kobol's Helios64
References: <20201013161340.720403-1-uwe@kleine-koenig.org>
 <20201013161340.720403-3-uwe@kleine-koenig.org>
 <a3957410-af99-5df4-8953-ffa3e7734aab@gmail.com>
In-Reply-To: <a3957410-af99-5df4-8953-ffa3e7734aab@gmail.com>

--5GxXSquKfhfE2ENUX41Slk1qArKyPvUxu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Johan,

On 10/13/20 7:34 PM, Johan Jonker wrote:
> Part 1 of 2 missing here.

Please complain to gmail then, given that patch 1 can be found on
https://lore.kernel.org/linux-arm-kernel/20201013161340.720403-2-uwe@klei=
ne-koenig.org/.

> Submit all patches to all maintainers and mail lists.
> Don't forget robh+dt !

I'm really surprised you insist here. In my experience Rob (with his
dt-hat on) is not interested in specifics of the machine files and he
already acked patch 1.

> Add a little change log here.

I assume you also didn't get the cover letter?

>> +		fault-led {
> fault_led: led-0 {}
>=20
> My fault.
> Change ones more...
>   # The first form is preferred, but fall back to just 'led' anywhere i=
n the
>   # node name to at least catch some child nodes.
>   "(^led-[0-9a-f]$|led)":

ok, the label isn't necessary, is it?

>> +			label =3D "helios64:green:status";
>> +			gpios =3D <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
>=20
>> +			linux,default-trigger =3D "none";
>=20
> Don't use 'none' for mainline.

Oh, I missed that. Thanks for your persistence.

>> +			default-state =3D "on";
>> +		};
>> +	};
>> +
>> +	vcc1v8_sys_s0: vcc1v8-sys-s0 {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "vcc1v8_sys_s0";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt =3D <1800000>;
>> +		regulator-max-microvolt =3D <1800000>;
>> +		vin-supply =3D <&vcc1v8_sys_s3>;
>> +	};
>> +
>> +	vcc3v0_sd: vcc3v0-sd {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "vcc3v0_sd";
>=20
> Doesn't a sd card need a on/off gpio?
> Could you check the schematics?

Hmm, there is a GPIO. I didn't consider a problem there given that the
machine logs

	[   31.708706] vcc3v0_sd: disabling

when there is no SD-card in the slot. Will investigate further.

>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&pmic_int_l>;
>=20
> sort

I would expect this is an exception from the sorting rule.

$ git grep pinctrl-names linus/master:arch/arm64/boot/dts/ | wc -l
1905

$ git grep -A1 pinctrl-names linus/master:arch/arm64/boot/dts/ | \
  grep pinctrl-0 | wc -l
1412

When grepping over arch/arm64/boot/dts/rockchip the numbers are
453 and 445 respectively.

Will use pinctrl-names above pinctrl-0 consistently.

>> +				regulator-max-microvolt =3D <1350000>;
>> +				regulator-min-microvolt =3D <750000>;
>=20
>=20
> The rest has min above max.
> Exception to the sort rule, not sure what Heiko wants, but keep it ever=
y
> where the same.

OK, most rockchip dts have min before max, will fix up.

>> +	i2c-scl-rising-time-ns =3D <160>;
>> +	i2c-scl-falling-time-ns =3D <30>;
>=20
> sort

I consider it logical to have rise before fall. In 43 of 59 cases in
arch/arm64/boot/dts/rockchip/ it is done this way.

>> +	vqmmc-supply =3D <&vcc1v8_sys_s0>;
>> +	status =3D "okay";
>> +};
>> +
>> +&sdmmc {
>> +	bus-width =3D <4>;
>> +	cap-sd-highspeed;
>=20
>> +	cd-gpios =3D <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
>=20
> see regulator?

GPIO0_A7 is the card detect line. I don't understand your question. Is
it the same as above, i.e. that it should be possible that the SD
regulator can be disabled?

>> +	disable-wp;
>> +	pinctrl-0 =3D <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
>> +	pinctrl-names =3D "default";
>> +	vmmc-supply =3D <&vcc3v0_sd>;
>> +	vqmmc-supply =3D <&vcc_sdio_s0>;
>> +	status =3D "okay";
>> +};

Best regards
Uwe


--5GxXSquKfhfE2ENUX41Slk1qArKyPvUxu--

--EFmySqGc9wLe4xQFMwVQ4RywEhiWqPCmD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+GDIQACgkQwfwUeK3K
7AnHYwf+IsK8rGUcvzG16k9+B0ncB6yvMib1g/TSEEn5iJURroODkYzcqBGmmUR7
pmHFy+DEY60spC5fJ3NUpqwrpNjybf3lh+JkWUkeW4i3w00hyQep86OdibK0K5Iz
RiRjgirpi/gKimfWbUW9zRQ9fwSgT0Wv0R8UQSHsl3xZt5Sg7A13hrgmIK4RHV9R
aS4hPuLcNGt3FWhYuSy1a+dr6Zp2+ued66pdFwCkU8QNIyRlhrfTyLYhVOlv2rjD
4k8otfQ4CVVOMkQBrgUNBSD4ouBI2FekU/2Ikvx5sXzeToVPc0zac1pVgFmF0l8H
pOA/RyMuSGY0sFyP2s4QojwKndoInQ==
=FcLl
-----END PGP SIGNATURE-----

--EFmySqGc9wLe4xQFMwVQ4RywEhiWqPCmD--
