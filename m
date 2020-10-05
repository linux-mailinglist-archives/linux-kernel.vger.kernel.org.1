Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01C283E3E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgJESXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:23:48 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16297 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJESXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:23:48 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b64a60000>; Mon, 05 Oct 2020 11:23:34 -0700
Received: from [10.26.45.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 18:23:43 +0000
Subject: Re: [PATCH 0/3] soc/tegra: Prevent the PMC driver from corrupting
 interrupt routing
To:     Thierry Reding <thierry.reding@gmail.com>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>, <kernel-team@android.com>
References: <20201005111443.1390096-1-maz@kernel.org>
 <20201005112217.GR425362@ulmo> <da38356394b63e2210f0e52d2e9bdc60@kernel.org>
 <20201005154529.GB628746@ulmo>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <dbe75937-dd24-6d2a-e3ea-265b8fa70def@nvidia.com>
Date:   Mon, 5 Oct 2020 19:23:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005154529.GB628746@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601922215; bh=43qLkfMkgiR0apRtpQZNUfVg1Tg+QRHwig6v00fr+Zw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=PRHpOuQw16ofs6Vhug06TKk2WA6/b0+5NfJ3aRwxtidCCURFCS7e0rmDgs0lOhu02
         2jYUfg/3ehTT7GOgjWjadCrsKn2xyCaZ5CLES6UGo34fivCwLjGYELfa1onBL1Ik2E
         V8Or3xumIMNkTHTMhKTIDoc63l3XQumSfxnMpNUXRnsZR2ts5sHbQlLQIDnbk79Pcx
         rV6n0js5IccOhY6Ke+ixhJJM1C1ALOAYsFnFk1NWDeJRYxsmlVBb3qNbYFD/8UxFBG
         FterQJ1Sshmdp0R5Vesu+Ju66qqVVcJFnuZCKjpF0G+is3RL0el+i2eBeX+EXBFPZT
         KJhAT7/s9v0VQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/10/2020 16:45, Thierry Reding wrote:

...

>>> Let Jon and myself do a bit of testing with this to verify that the wake
>>> up paths are still working.
>>
>> Sure. Let me know what you find.
> 
> The results are in and it's a bit of a mixed bag. I was able to confirm
> that Tegra194 also boots again after this series and I'm also able to
> resume from sleep using either rtcwake or the power-key as wakeup
> source, so the wake-events mechanism is still functional after the
> series. I do see a bit of breakage on resume, but none of that seems
> related to your patches and is likely something that crept in while we
> were looking into the current issue.
> 
> Jon had started a job in our test farm in parallel and that came back
> with a failing suspend/resume test on Tegra186 (Jetson TX2), but that
> seems to have been a pre-existing issue. This was already in linux-next
> around next-20200910 and Jon had been investigating it when the boot
> failures due to the IPI changes started happening. So I then hooked up
> my Jetson TX2 and verified locally that I can properly suspend/resume
> using either rtcwake or the power-key as wakeup source, just like I
> previously did on Tegra194 (Jetson AGX Xavier). Tegra186 seems to be a
> little more unstable because it didn't boot every time for me, but that
> is probably not related to this.

Yes my feeling is that those are other issues too that we need to look
at next.

> So, I'm tempted to say:
> 
> Tested-by: Thierry Reding <treding@nvidia.com>

Yes and you can have my ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks again Marc for tracking this down!

Cheers
Jon

-- 
nvpublic
