Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE362FDFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393340AbhAUCwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:52:54 -0500
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:38589 "EHLO
        15.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731981AbhAUClr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 21:41:47 -0500
X-Greylist: delayed 17094 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jan 2021 21:41:46 EST
Received: from player774.ha.ovh.net (unknown [10.110.115.139])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id BDA99237A32
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:00:56 +0100 (CET)
Received: from milecki.pl (public-gprs350448.centertel.pl [37.47.0.49])
        (Authenticated sender: rafal@milecki.pl)
        by player774.ha.ovh.net (Postfix) with ESMTPSA id 50BBB1A4FA87E;
        Wed, 20 Jan 2021 20:00:51 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R003abf26e96-041b-485e-9666-13944d086f29,
                    C59A7BE3DC72FAF1CD198FBEBAA31FE01A2500F7) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 37.47.0.49
Subject: Re: [PATCH Broadcom/stblinux] soc: brcmstb: add stubs for getting
 platform IDs
To:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210114105318.14970-1-zajec5@gmail.com>
 <20210120194851.2775816-1-f.fainelli@gmail.com>
 <bb5980c6-87ba-ad26-c1fb-353735fd9181@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Message-ID: <17235825-ac17-616f-f2cc-2e373ead5063@milecki.pl>
Date:   Wed, 20 Jan 2021 21:00:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <bb5980c6-87ba-ad26-c1fb-353735fd9181@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10085811369204223511
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddvgddufeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepkeduheejheffudefhffghfegjeejleetkeevueelveegkefhhfffieehleelgfevnecukfhppedtrddtrddtrddtpdefjedrgeejrddtrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.2021 20:58, Florian Fainelli wrote:
> On 1/20/2021 11:48 AM, Florian Fainelli wrote:
>> On Thu, 14 Jan 2021 11:53:18 +0100, Rafał Miłecki <zajec5@gmail.com> wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> Some brcmstb drivers may be shared with other SoC families. E.g. the
>>> same USB PHY block is shared by brcmstb and BCM4908.
>>>
>>> To avoid building brcmstb common code on non-brcmstb platforms we need
>>> stubs for:
>>> 1. brcmstb_get_family_id()
>>> 2. brcmstb_get_product_id()
>>> (to avoid "undefined reference to" errors).
>>>
>>> With this change PHY_BRCM_USB will not have to unconditionally select
>>> SOC_BRCMSTB anymore.
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>
>> Applied to drivers/next, thanks!
> 
> Made some tweaks to the patch:
> 
> - subject is prefixed with: soc: bcm: brcmstb to match previous patches
> - used IS_ENABLED() instead of #ifdef because this may have to be a
> loadable module in the future (because of GKI)
> 
> Thanks!

Thank you!
