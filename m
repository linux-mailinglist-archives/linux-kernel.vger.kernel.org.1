Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267B52D977F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407856AbgLNLiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:38:05 -0500
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:53649 "EHLO
        10.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407299AbgLNLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:38:00 -0500
X-Greylist: delayed 12991 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2020 06:37:59 EST
Received: from player789.ha.ovh.net (unknown [10.109.143.201])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 22C1C2A4364
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:00:39 +0100 (CET)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player789.ha.ovh.net (Postfix) with ESMTPSA id 14F541927E5EF;
        Mon, 14 Dec 2020 08:00:27 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G0040c338a84-40d3-4bcf-9a09-0dcf186e6146,
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
 <4d0bea20-1a3b-24d1-2d27-96f2f4fd48b9@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Message-ID: <d3461875-cdbc-9fde-3ef3-7a7ba478d88a@milecki.pl>
Date:   Mon, 14 Dec 2020 09:00:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <4d0bea20-1a3b-24d1-2d27-96f2f4fd48b9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1992279886806289969
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudekjedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepkeekgeefieeuhfdujeefgeektddujeekledvheehfeelfffhfeekjefhfeehuefhnecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.2020 04:26, Florian Fainelli wrote:
>> +
>> +static const struct bcm_pmb_pd_data bcm_pmb_bcm4908_data[] = {
>> +	{ .name = "pcie2", .id = BCM_PMB_PCIE2, .bus = 0, .device = 2, },
>> +	{ .name = "pcie0", .id = BCM_PMB_PCIE0, .bus = 1, .device = 14, },
>> +	{ .name = "pcie1", .id = BCM_PMB_PCIE1, .bus = 1, .device = 15, },
>> +	{ .name = "usb", .id = BCM_PMB_HOST_USB, .bus = 1, .device = 17, },
> 
> Do you have to be more specific and spell out whether this is the host
> controller (xhci) or device (bdc)? If not, then this looks good to me.

I believe I have to and I believe I already do. I used BCM_PMB_HOST_USB
which clearly (I believe) points to the HOST controller.

In 6838 part of pmc_drv.h from Broadcom's SDK I found:

enum {
     USB30_2X_Zone_Common,
     USB30_2X_Zone_USB_Host,
     USB30_2X_Zone_USB_Device,
};

and that's what makes me believe we need to specify HOST explicitly.
