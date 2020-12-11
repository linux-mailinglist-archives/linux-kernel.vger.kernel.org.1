Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C742D81B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406708AbgLKWMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:12:41 -0500
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:56189 "EHLO
        10.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394262AbgLKWMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:12:00 -0500
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Dec 2020 17:11:59 EST
Received: from player793.ha.ovh.net (unknown [10.108.54.34])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id EA75FA4D98
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 23:03:00 +0100 (CET)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player793.ha.ovh.net (Postfix) with ESMTPSA id A147F191BB613;
        Fri, 11 Dec 2020 22:02:50 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-102R004bc04e80a-875d-46c3-9921-bab13f78b28e,
                    DDBB76C1C8392C31EFBEE9FEDF413D15A2A340D3) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Subject: Re: [PATCH 2/2] soc: bcm: add PM driver for Broadcom's PMB
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org
References: <20201211215942.5726-1-zajec5@gmail.com>
 <20201211215942.5726-3-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Message-ID: <ab3e8ce4-81bb-9905-8ab9-49b1e1923e8e@milecki.pl>
Date:   Fri, 11 Dec 2020 23:02:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201211215942.5726-3-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17047250490626838039
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudekvddgudehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeekudehjeehffdufefhgffhgeejjeelteekveeuleevgeekhffhffeiheellefgveenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.2020 22:59, Rafał Miłecki wrote:
> @@ -13,6 +13,14 @@ config BCM2835_POWER
>   	  firmware means that Linux usage of the same power domain
>   	  must be accessed using the RASPBERRYPI_POWER driver
>   
> +config BCM_PMB
> +	bool "Broadcom PMB (Power Management Bus) driver"
> +	depends on ARCH_BCM4908 || (COMPILE_TEST && OF)
> +	default ARCH_BCM4908
> +	select PM_GENERIC_DOMAINS if PM
> +	help
> +	  Foo

I'll improve description a bit in V2 ;)
