Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F592E09B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 12:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgLVL3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 06:29:53 -0500
Received: from mout.gmx.net ([212.227.15.19]:56507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgLVL3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 06:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608636487;
        bh=HwMnnb0SE29Jktf+AvdkyZmGuN2AX0JVfsjEdY2OFUA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=AzEq3CSnXmJvwEflPlv+WS8wAOwdTJWBoDTB96dCRptzG+O0sm3lj/V31aARyY/43
         LDYXup250sTRJCqW9RkawKf7eSLZw53qnLpFhfTV3HOHs1XcNf2qKeFb+hLlmICp45
         pm8RSHu26eR3eiuEoUA95XWexg1Wd17pgLbhIcx8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([62.143.246.89]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBm1e-1kmCjL2Brw-00C7sP; Tue, 22
 Dec 2020 12:28:07 +0100
Subject: Re: [PATCH v4 1/3] dt-bindings: input: adc-keys bindings
 documentation
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
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
 <1b82e9ef-e8af-87e1-ea68-d71d65c2aa8a@gmx.de>
Message-ID: <f8930b5a-e1eb-7c41-19ad-6ba539c59322@gmx.de>
Date:   Tue, 22 Dec 2020 12:28:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1b82e9ef-e8af-87e1-ea68-d71d65c2aa8a@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DON19+nfSZKJuFyoDriwCGYQtZzBfTjsl5F+7q2lOxrQIVkWipS
 h4vp5cLNsyuxUX9bMcnil9EoObsZ8BHOAwOX2jza2skQYQ39rnis58Drc1DnuSia4rYwevF
 CqWghNUdn83moDNEWR1kPhh8VECcoGhLcdcCvMS14NwuzandTP2pJDFp1vHyl4aR3EK/h/L
 QHEK4b6b7sTdydgwKlKgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MK5dUzmLINk=:NC12T9lPXpICd9QBVMlRep
 AannL2Rp1pE1cjkKScjCSc8amhfpUCqwOv23Q406/vIdm3UeebU0C5nJZv8Qm5IpMDFnAFxwm
 +17sEIxtbeKyrt0XKDPkWtyGR5X2A00QlnC23pscouUIkrgMSJ3J18D1922FK9qRpXT/mtYsd
 XZO9VjpvMCcM/l9UR1BVpOBoxm3EXgDQsWHvBRIy4oveIZSn9e7tOpKTyQ6LDpgcZK+HN5zRS
 pZPYidxYj0f+spoKeLnM8jAwz01zjqF7tsfu8pamTLw9t2WnzE2KZV1GQFysQ90OAm27S+yg+
 bXF3Vl8ePhDtTuOpWqn9qVC8MBDtOlqrYCEuptICXP5a/59Tq0EnhB6H52Q6NCyk4u7Wmrt1P
 c6a61luH6CFE4nlKLhps2eDA8mCZ8Uy+hZAANEXCZfRzT4rJ1eTfa07eWfHuQR2PjPpUCY6FT
 aYSv2uJbOVo3YoXgVOErRdNIE+ZSZNBoM720PxrSy9f7F9d2XETy83btc3MQ/PIRUEP9VBX4p
 a49F6T53VK32JFfXFA6pRhnHesrnZGeKLX32hYrADXc7BJmeqZZE7xcTZxEwpL5Qc+cM8pR36
 Ao5yhnFGxw1RdrJoTLk4wLHbhL/ukvyO0MA0MPTyVdrtnqmA1mGOCmQJtwXvs0x/gkTsD0BYY
 xMdKTU8Y2C5pICf4jambpVErcxpJhwSfcVJiq9C3uIx5bVPhbZefdiuaIM8dKd35u26hmDPcB
 Z9FIZVL6zkTyFhr93j2V/In0T85kgYk0d5OfBBgusmEAHF2gF1YYTlc1PesdBWSW1jhk7+IKl
 l8uhfbYLQHFHmsrir3IeDS69+xHgf1vHII16hil4hkVO5L7O+2XlYy1ZJvCi4XyBEVOnq7VPz
 xPB6QjOK9Zgxm09o28Hw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/20 11:12 AM, Heinrich Schuchardt wrote:
> On 12/22/20 9:56 AM, Marek Szyprowski wrote:
>> Dump adc-keys bindings documentation from Linux kernel source tree v5.1=
0.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> =C2=A0 doc/device-tree-bindings/input/adc-keys.txt | 49 +++++++++++++++=
++++++
>> =C2=A0 1 file changed, 49 insertions(+)
>> =C2=A0 create mode 100644 doc/device-tree-bindings/input/adc-keys.txt
>>
>> diff --git a/doc/device-tree-bindings/input/adc-keys.txt
>> b/doc/device-tree-bindings/input/adc-keys.txt
>> new file mode 100644
>> index 0000000000..e551814629
>> --- /dev/null
>> +++ b/doc/device-tree-bindings/input/adc-keys.txt
>> @@ -0,0 +1,49 @@
>> +ADC attached resistor ladder buttons
>> +------------------------------------
>> +
>> +Required properties:
>> + - compatible: "adc-keys"
>> + - io-channels: Phandle to an ADC channel
>> + - io-channel-names =3D "buttons";
>> + - keyup-threshold-microvolt: Voltage at which all the keys are
>> considered up.
>> +
>> +Optional properties:
>> +=C2=A0=C2=A0=C2=A0 - poll-interval: Poll interval time in milliseconds
>> +=C2=A0=C2=A0=C2=A0 - autorepeat: Boolean, Enable auto repeat feature o=
f Linux input
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subsystem.
>> +
>> +Each button (key) is represented as a sub-node of "adc-keys":
>> +
>> +Required subnode-properties:
>> +=C2=A0=C2=A0=C2=A0 - label: Descriptive name of the key.
>> +=C2=A0=C2=A0=C2=A0 - linux,code: Keycode to emit.
>> +=C2=A0=C2=A0=C2=A0 - press-threshold-microvolt: Voltage ADC input when=
 this key is
>> pressed.
>
> https://www.merriam-webster.com/dictionary/threshold
> defines threshold as "a level, point, or value above which something is
> true or will take place and below which it is not or will not"
>
> "when this key is pressed" leaves it completely open if a key is
> considered pressed below or above the threshold. Please, replace the
> word 'when' by either 'above which' or 'below which'.
>
> In the example keyup-threshold-microvolt is larger than
> keyup-threshold-microvolt all values of press-threshold-microvolt. So
> one might assume that 'above' is the intended meaning and the
> interpretation of the example might be:
>
> 2.000.000 <=3D value: no key pressed
> 1.500.000 <=3D value < 2.000.000: KEY_VOLUMEUP pressed
> 1.000.000 <=3D value < 1.500.000: KEY_VOLUMEDOWN pressed
> 500.000 <=3D value < 1.000.000: KEY_ENTER pressed
> value < 500.000: no key pressed
>
> Both directions 'above' and 'below' make sense. So maybe if
> keyup-threshold-microvolt is lower than all press-threshold-microvolt
> you want to invert the logic?
>
> The binding lacks a hysteresis which is needed for a reliable function.
>
> If you look into drivers/input/keyboard/adc-keys.c in the Linux source,
> you can see that it is not using the threshold value as a threshold at
> all. Instead is uses abs(st->map[i].voltage - value) to find the nearest
> "threshold" voltage level.
>
> Could you, please, try to bring this text into a form that cannot be
> misinterpreted and reconcile with upstream. This should include
>
> * a results table for the example
> * a definition if keyup-threshold-microvolt must be higher than all
>  =C2=A0 press-threshold-microvolt or may be lower than all
>  =C2=A0 press-threshold-microvolt
> * a sentence forbidding keyup-threshold-microvolt to be between two
>  =C2=A0 press-threshold-microvolt
> * a definition if or when any of the thresholds is a lower or upper
>  =C2=A0 boundary

Cf. [PATCH 1/1] dt-bindings: adc-keys.txt: clarify description
https://lore.kernel.org/linux-input/20201222110815.24121-1-xypron.glpk@gmx=
.de/T/#u

Best regards

Heinrich

>
> Best regards
>
> Heinrich
>
>> +
>> +Example:
>> +
>> +#include <dt-bindings/input/input.h>
>> +
>> +=C2=A0=C2=A0=C2=A0 adc-keys {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adc-keys";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io-channels =3D <&lradc 0>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io-channel-names =3D "butto=
ns";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 keyup-threshold-microvolt =
=3D <2000000>;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 button-up {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lab=
el =3D "Volume Up";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lin=
ux,code =3D <KEY_VOLUMEUP>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pre=
ss-threshold-microvolt =3D <1500000>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 button-down {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lab=
el =3D "Volume Down";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lin=
ux,code =3D <KEY_VOLUMEDOWN>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pre=
ss-threshold-microvolt =3D <1000000>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 button-enter {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lab=
el =3D "Enter";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lin=
ux,code =3D <KEY_ENTER>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pre=
ss-threshold-microvolt =3D <500000>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +=C2=A0=C2=A0=C2=A0 };
>>
>

