Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CB02D9D52
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408404AbgLNRMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:12:20 -0500
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:40022 "EHLO
        14.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408360AbgLNRMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:12:03 -0500
X-Greylist: delayed 24225 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2020 12:12:02 EST
Received: from player746.ha.ovh.net (unknown [10.108.35.74])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 58CDE25C592
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 13:24:45 +0100 (CET)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player746.ha.ovh.net (Postfix) with ESMTPSA id 7AC26193795B4;
        Mon, 14 Dec 2020 12:24:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-98R0024d04bba9-bba4-4092-81a2-66b9f363d4d7,
                    9D4513A06938E8562C9FC8D5040FBB067C1A90C8) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Subject: Re: [PATCH 2/2] soc: bcm: add PM driver for Broadcom's PMB
To:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org
References: <20201211215942.5726-1-zajec5@gmail.com>
 <20201211215942.5726-3-zajec5@gmail.com>
 <3bc097fa-3bef-396f-a4fd-fa8acbc1b71d@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Message-ID: <18ebb7ab-2a45-f9fb-a094-0e63d44eadad@milecki.pl>
Date:   Mon, 14 Dec 2020 13:24:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <3bc097fa-3bef-396f-a4fd-fa8acbc1b71d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6452813843937398321
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepkeduheejheffudefhffghfegjeejleetkeevueelveegkefhhfffieehleelgfevnecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejgeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.2020 23:08, Florian Fainelli wrote:
> On 12/11/20 1:59 PM, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> PMB can be found on BCM4908 and many other chipsets (e.g. BCM63138).
>> It's needed to power on and off SoC blocks like PCIe, SATA, USB.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> I will do a more thorough review tonight, however do you mind moving the
> driver under drives/soc/bcm/bcm63xx? The first SoC that had PMB was
> 63138 and that one is DSL.

I now realized that bcm63xx's:
* Kconfig is wrapper in: if SOC_BCM63XX
* Makefile is conditional: obj-$(CONFIG_SOC_BCM63XX)

So it means I've to either:
1. Refactor bcm63xx structure
2. Make SOC_BCM63XX selectable on ARCH_BCM4908 and select it

I'm not sure if any of above is a really good idea. Any further thought, ideas?
