Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FF72C026A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgKWJnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:43:17 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:30350 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgKWJnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606124591;
        s=strato-dkim-0002; d=fossekall.de;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=X00269bVq/tKBXSY9ndHMPgqQzKkKX6R0AKx7WaQNw4=;
        b=lQ3z59+YaUNGqpDO3J+9s7vPhUyyeR6ObiCTHtZTi7F1HqN4m1kVkp1lfea/o9riTh
        FzhZCpZis6gnFa5PQGU1Cokbbt+lFV3ffrDJLktgiFnKHe0U607oHpl5V3IoQ1Y0epN+
        hSFwE10eSzZ1IQegGEDckgmRwPf9X5j4DHTJMg8PaE8or3rKv0hDV4DcIA4quw6SC4wl
        yeYGcWCxz+r4TuZlSquT/pYEf+h/q3/1/QwZQHcwES3G6Pj22YARx53CgXnQSmnKTqbz
        L3pUXVzTNaMhOIc/4D+LtFKKzJuPbYWqxLlia0kC8fiCyc0aN4pydUgGmkgEhd/aN00y
        7y4w==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wAN9h242r
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 23 Nov 2020 10:43:02 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <michael@fossekall.de>)
        id 1kh8NB-0006ro-Np; Mon, 23 Nov 2020 10:43:01 +0100
Date:   Mon, 23 Nov 2020 10:43:00 +0100
From:   Michael Klein <michael@fossekall.de>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add
 gpio-line-names
Message-ID: <20201123094300.GA3699@a98shuttle.de>
References: <20201115222425.2885427-1-michael@fossekall.de>
 <20201120155252.kfkavrn4wpqzmbyc@gilmour>
 <20201120182739.GA3734181@a98shuttle.de>
 <CAGb2v645Hq_C6fntM8CFnBiHBTFM-6zyZUXLKWPccmb3eOZBKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGb2v645Hq_C6fntM8CFnBiHBTFM-6zyZUXLKWPccmb3eOZBKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 12:39:07PM +0800, Chen-Yu Tsai wrote:
>On Sat, Nov 21, 2020 at 2:28 AM Michael Klein <michael@fossekall.de> wrote:
>>
>> Thank you for having a look at the patch!
>>
>> On Fri, Nov 20, 2020 at 04:52:52PM +0100, Maxime Ripard wrote:
>> >On Sun, Nov 15, 2020 at 11:24:25PM +0100, Michael Klein wrote:
>> >> Add gpio-line-names as documented in the Banana Pi wiki [1] and in the
>> >> schematics [2].
>> >>
>> >> [1]: http://wiki.banana-pi.org/Banana_Pi_BPI-M2_ZERO#GPIO_PIN_define
>> >> [2]: https://drive.google.com/file/d/0B4PAo2nW2KfnMW5sVkxWSW9qa28/view
>> >>
>> >> Signed-off-by: Michael Klein <michael@fossekall.de>
>> >> ---
>> >>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 64 +++++++++++++++++++
>> >>  1 file changed, 64 insertions(+)
>> >>
>> >> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> >> index 4c6704e4c57e..b4ddfaf01b45 100644
>> >> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> >> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> >> @@ -136,6 +136,70 @@ bluetooth {
>> >>
>> >>  };
>> >>
>> >> +&pio {
>> >> +    gpio-line-names =
>> >> +            /* PA */
>> >> +            "UART2-TX", "UART2-RX", "UART2-RTS", "UART2-CTS",
>> >> +                    "UART0-TXD", "UART0-RXD", "PWM1", "PA7-EINT7",
>> >> +            "PA8-EINT8", "PA9-EINT9", "PA10-EINT10", "TWI0-SCK",
>> >> +                    "TWI0-SDA", "UART3-TX", "UART3-RX", "UART3-RTS",
>> >> +            "UART3-CTS", "PA17-EINT17", "TWI1-SCK", "TWI1-SDA",
>> >> +                    "PA20-EINT20", "PA21-EINT21", "", "",
>> >> +            "", "", "", "", "", "", "", "",
>> >
>> >IIRC, the point is to have the pin names that the vendor publishes.
>> >
>> >Looking at Documentation/devicetree/bindings/gpio/gpio.txt, it says:
>> >
>> >"""
>> >Optionally, a GPIO controller may have a "gpio-line-names" property. This is
>> >an array of strings defining the names of the GPIO lines going out of the
>> >GPIO controller. This name should be the most meaningful producer name
>> >for the system, such as a rail name indicating the usage. Package names
>> >such as pin name are discouraged: such lines have opaque names (since they
>> >are by definition generic purpose) and such names are usually not very
>> >helpful.
>> >"""
>> >
>> >In this case, from the link you gave above, I think having the CON*-P*
>> >names make more sense.
>>
>> Hm, but these are the pin names (of the connector) and should thus not
>> be used, right?
>>
>> For e.g. the PA0 pin, the wiki link gives three candidates:
>>
>> - CON2-P13 (GPIO Pin Name -> pin 13 of the 40 pin GPIO header)
>> - UART2-TX (Default Function)
>> - PA0-EINT0 (Function2 : GPIO)
>>
>> IMHO, the CON*-P* name is the least helpful of the above, as it tells
>> nothing about the usage. I'm not sure about the other two names, though.
>
>I believe the function names are pretty useless in this case, as you
>cannot use the GPIO subsystem to mux functions. That is what pinctrl
>does. And in our case, the pinctrl drivers already know all the
>available functions each pin has.
>
>Using the pin count and connector name provides the user direct mapping
>of the software representation of the pin against the actual pin on the
>hardware. The user can then proceed to request and use that pin.

Thank you for the explanation, that makes sense. I'll update the patch 
then.

Michael
