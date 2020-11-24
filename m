Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA032C341A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 23:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389857AbgKXWiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 17:38:09 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:9200 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389837AbgKXWiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 17:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606257487;
        s=strato-dkim-0002; d=fossekall.de;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=qxl537xXYJE6736NWNsfKVJUQk4AmvYtC+J9SjGR+Lw=;
        b=JSmXXhOrkpP1Ts0ga33gNBJFxAcbwb3NsrOG1biIawBsawe0jpcjmuWb7pMVSzieg9
        OeV0CU1tZJa04Y5a96w7B0HwKtx7CZDmT2M5AAqPzKxo4h5x0hM0pfsbs1cwIhLi9LxC
        q2xHW7IV3LpkJzdz2Gjh+QmGzKHHITUHJJMgN9iZXeeO1RE5UBmtp2MQNBTSPjiLuX9w
        PxZbL3dMCtcfvqhqLmmqV9BoQduNo5B+X93cUW5DNuCZVKeAR1lKc1inFXqNiFOC/dc/
        qFKtjx0tsMPQm+ccdCe2D+I3ZANcgNVAZobLzSLlTlOD8h0/1SE7zeA/sliR1AkVe1C+
        PZ1A==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wAOMW2GNh
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 24 Nov 2020 23:32:02 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <michael@fossekall.de>)
        id 1khgqv-0007xh-1q; Tue, 24 Nov 2020 23:32:01 +0100
Date:   Tue, 24 Nov 2020 23:31:59 +0100
From:   Michael Klein <michael@fossekall.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add
 poweroff node to DT
Message-ID: <20201124223159.GA2865084@a98shuttle.de>
References: <20201124131933.2l2go6z6ltar5fpa@gilmour>
 <20201124133633.672259-1-michael@fossekall.de>
 <20201124142656.wz6ipwa2xayn433x@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201124142656.wz6ipwa2xayn433x@gilmour>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 03:26:56PM +0100, Maxime Ripard wrote:
>On Tue, Nov 24, 2020 at 02:36:33PM +0100, Michael Klein wrote:
>> Add poweroff node to allow the board to power itself off after shutdown
>> by disabling the SYSTEM and CPUX regulators (U5 resp. U6).  The RST
>> button can be used to restart the board.
>>
>> Signed-off-by: Michael Klein <michael@fossekall.de>
>> ---
>>  arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 5 +++++
>>  1 file changed, 5 insertions(+)
>
>You should have a summary of the changes between versions here
>
>> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> index 4c6704e4c57e..ea2fa48a1647 100644
>> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> @@ -46,6 +46,11 @@ sw4 {
>>  		};
>>  	};
>>
>> +	poweroff {
>> +		compatible = "gpio-poweroff";
>> +		gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
>> +	};
>> +
>
>Like I said in the previous version, this should really be modelled as a
>regulator instead of just a GPIO

Please excuse my ignorance, do you mean something like this?

        reg_vdd_sys: vdd-sys {
                compatible = "regulator-fixed";
                regulator-name = "vdd-sys";
                regulator-min-microvolt = <1200000>;
                regulator-max-microvolt = <1200000>;
                regulator-always-on;
                regulator-boot-on;
                enable-active-high;
                gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
                vin-supply = <&reg_vcc5v0>;
         };

With this, the board still draws 60mA (cheap USB ampere meter) after 
shutdown, presumably because of "regulator-always-on".  Without this 
property the board powers off shortly after booting up.

Michael
