Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA06D2E089F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 11:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgLVKOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 05:14:03 -0500
Received: from mout.gmx.net ([212.227.15.18]:56449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgLVKOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 05:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608631937;
        bh=5yAOvpKQGHkVAoOr1Q9MhXkVP3oveSCb+VpdI7hq/R8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Yt9BmO9q9y+OEmZ7dnad/hiy6t6NAZUXyAy8CZad1du57w1Ufmwzd+VAVHyXaW+LV
         ridL7TEhOZy5ZOOBguvDEbLsN+3rzPZJyiEognU3G35eh2u2RWIxfR+U40z+9u0j1h
         6u8rC81UkZzSN0XvWna7BPz8Ya6hRonGOkd7vjFk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([62.143.246.89]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1kdq6325ss-00LaCx; Tue, 22
 Dec 2020 11:12:17 +0100
Subject: Re: [PATCH v4 1/3] dt-bindings: input: adc-keys bindings
 documentation
To:     Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de,
        u-boot-amlogic@groups.io
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Lukasz Majewski <lukma@denx.de>,
        Philippe Reynes <philippe.reynes@softathome.com>,
        Simon Glass <sjg@chromium.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Herring <robh@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <20201222085633.10194-1-m.szyprowski@samsung.com>
 <CGME20201222085638eucas1p14d9d9da136593a12fea0140c403095c4@eucas1p1.samsung.com>
 <20201222085633.10194-2-m.szyprowski@samsung.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <1b82e9ef-e8af-87e1-ea68-d71d65c2aa8a@gmx.de>
Date:   Tue, 22 Dec 2020 11:12:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201222085633.10194-2-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pENYS1USxVivt6cwQ7fToy/bbzpQaFssDVZ0txiDykCGVPY+Hdy
 sShoose3eBL0au6G+4FDBR6LB1LAt+UNXZ9CNr211cIRWGoy85Q9yD+6bBvOnReHpJ+PVUb
 1QnJ9Qi8gECaomkTgbwf/bh7ZVchu6MMk5n9xvyC4i+X/P0ERf9c4g6zjpQYbEmYvzEp2v0
 SCe0fDkxeW5IAvnZmJsQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:R5wJkoHWMPM=:2XC79C1l4NHGVz9qDllXYV
 2IENQ3mxZSTuD1ussYRu15NpuqCV7V/5BDUlPyr2MDb2EG+c5rm53j5H8ftCA2GvuZEaM4Jo5
 RDyPrktSn64j8XCfoQXN8rgA0cL9Fl/VlbSd19Kh0Lol+X+nOsndoyh6T2YukEB49EP9E6ddr
 PWJsHEitODyYcz901y6k0wa5fSFldEDhRIC8/ufwver7RdLxmeliTafSr8IHjwt8CeSOqjrYB
 6Nu/q57J0/GWKYSis9+hMZ6TBkuMsEXW9W9YgMYZeRJgV3Ck1HX9+Ee6hQxZzJxqxl+Kzsu7y
 H3xuY55fxoKmffCoOwr0JgECttOFTKV2A8lokIztCccNHy9yOzBiH9IDAtt5FL+lL4HmEzTHe
 yiZhJ0uZnVkqLvt6MCUwBsqpT7pnOTt2TA79NUaeyObCkNrUwH0oNDbIn/k7Yazn+Ftw71Rf2
 ZhGBIUEFzjcUY40TFj2XScYzf8xobpSXINVBjabKPIf5QLNsvc2lNBTvSDv5j7tRoyn+yrlh0
 XiVRYx2ylJvRBOY1kwa8KMbYXtKwI/nOCjllFSQ9kJmYsQ80QDDXqjkBoWa9P/QdqNDBnHWob
 oehmXVylaCpHHI65q7xISq6Nv/kM4FeYsSEX/OKk9g8sf+OcSfWp73LhoNFVExxNxW2tr6NpR
 pTuR29TsL4r42D71YfzwSRGbKNM1AnVO4uY+BfDG3uL4PL3HykjUacz2B89dzJonahfezohau
 oAe8212L/evOLf14g8vkCXvzzj30wYrGrYFUjxh6XRFcPrFe3Mew67ruf5adIAU4BJo23hzVP
 3lcncZB1XlbK8qr8dR4Lttvg3Kmx5jbrfs5boSrBh88FAfp7hCNSr32zMCXfBaiX+GEoB2pWt
 4gAE4dXSCyHlPW3BwQ4w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/20 9:56 AM, Marek Szyprowski wrote:
> Dump adc-keys bindings documentation from Linux kernel source tree v5.10=
.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   doc/device-tree-bindings/input/adc-keys.txt | 49 +++++++++++++++++++++
>   1 file changed, 49 insertions(+)
>   create mode 100644 doc/device-tree-bindings/input/adc-keys.txt
>
> diff --git a/doc/device-tree-bindings/input/adc-keys.txt b/doc/device-tr=
ee-bindings/input/adc-keys.txt
> new file mode 100644
> index 0000000000..e551814629
> --- /dev/null
> +++ b/doc/device-tree-bindings/input/adc-keys.txt
> @@ -0,0 +1,49 @@
> +ADC attached resistor ladder buttons
> +------------------------------------
> +
> +Required properties:
> + - compatible: "adc-keys"
> + - io-channels: Phandle to an ADC channel
> + - io-channel-names =3D "buttons";
> + - keyup-threshold-microvolt: Voltage at which all the keys are conside=
red up.
> +
> +Optional properties:
> +	- poll-interval: Poll interval time in milliseconds
> +	- autorepeat: Boolean, Enable auto repeat feature of Linux input
> +	  subsystem.
> +
> +Each button (key) is represented as a sub-node of "adc-keys":
> +
> +Required subnode-properties:
> +	- label: Descriptive name of the key.
> +	- linux,code: Keycode to emit.
> +	- press-threshold-microvolt: Voltage ADC input when this key is presse=
d.

https://www.merriam-webster.com/dictionary/threshold
defines threshold as "a level, point, or value above which something is
true or will take place and below which it is not or will not"

"when this key is pressed" leaves it completely open if a key is
considered pressed below or above the threshold. Please, replace the
word 'when' by either 'above which' or 'below which'.

In the example keyup-threshold-microvolt is larger than
keyup-threshold-microvolt all values of press-threshold-microvolt. So
one might assume that 'above' is the intended meaning and the
interpretation of the example might be:

2.000.000 <=3D value: no key pressed
1.500.000 <=3D value < 2.000.000: KEY_VOLUMEUP pressed
1.000.000 <=3D value < 1.500.000: KEY_VOLUMEDOWN pressed
500.000 <=3D value < 1.000.000: KEY_ENTER pressed
value < 500.000: no key pressed

Both directions 'above' and 'below' make sense. So maybe if
keyup-threshold-microvolt is lower than all press-threshold-microvolt
you want to invert the logic?

The binding lacks a hysteresis which is needed for a reliable function.

If you look into drivers/input/keyboard/adc-keys.c in the Linux source,
you can see that it is not using the threshold value as a threshold at
all. Instead is uses abs(st->map[i].voltage - value) to find the nearest
"threshold" voltage level.

Could you, please, try to bring this text into a form that cannot be
misinterpreted and reconcile with upstream. This should include

* a results table for the example
* a definition if keyup-threshold-microvolt must be higher than all
   press-threshold-microvolt or may be lower than all
   press-threshold-microvolt
* a sentence forbidding keyup-threshold-microvolt to be between two
   press-threshold-microvolt
* a definition if or when any of the thresholds is a lower or upper
   boundary

Best regards

Heinrich

> +
> +Example:
> +
> +#include <dt-bindings/input/input.h>
> +
> +	adc-keys {
> +		compatible =3D "adc-keys";
> +		io-channels =3D <&lradc 0>;
> +		io-channel-names =3D "buttons";
> +		keyup-threshold-microvolt =3D <2000000>;
> +
> +		button-up {
> +			label =3D "Volume Up";
> +			linux,code =3D <KEY_VOLUMEUP>;
> +			press-threshold-microvolt =3D <1500000>;
> +		};
> +
> +		button-down {
> +			label =3D "Volume Down";
> +			linux,code =3D <KEY_VOLUMEDOWN>;
> +			press-threshold-microvolt =3D <1000000>;
> +		};
> +
> +		button-enter {
> +			label =3D "Enter";
> +			linux,code =3D <KEY_ENTER>;
> +			press-threshold-microvolt =3D <500000>;
> +		};
> +	};
>

