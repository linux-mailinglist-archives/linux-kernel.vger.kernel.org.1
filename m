Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D238C284830
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgJFIOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:14:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35330 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgJFIOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:14:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0968E6mu093407;
        Tue, 6 Oct 2020 03:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601972046;
        bh=R+hYz0n1bmLNJQrANIRZOfjNkI2Oo7acRkOE16iJCMg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WoTEI/RBcFFGd7bW+IIZstsZfzN0qZSoWPIP/solb6kWdPY9BN3diCKvnAwWNpW/K
         EiQ1r4ldeQbP85R3TaSa6pTmQUoNaN8i0d3EPWio7fWCMo6FvmMHhDIVRJUzJhgHrV
         BDalHpVl1Ka03TdHDXao4D4kK2pUXYp0WDhBy6Es=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0968E6Nh016473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Oct 2020 03:14:06 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 6 Oct
 2020 03:14:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 6 Oct 2020 03:14:05 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0968E2pN018962;
        Tue, 6 Oct 2020 03:14:03 -0500
Subject: Re: [PATCH 0/2] Enable GPIO and I2C configs for TI's J721e platform
To:     Nishanth Menon <nm@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <t-kristo@ti.com>
References: <20201002164535.9920-1-faiz_abbas@ti.com>
 <20201002170211.ghzbjqt6nti6mssh@attakatha>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <7c45f8e1-afc7-b386-fddb-29d44326067c@ti.com>
Date:   Tue, 6 Oct 2020 13:44:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002170211.ghzbjqt6nti6mssh@attakatha>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth,

On 02/10/20 10:32 pm, Nishanth Menon wrote:
> On 22:15-20201002, Faiz Abbas wrote:
>> The following patches enable configs in the arm64 defconfig to support
>> GPIO and I2C support on TI's J721e platform.
>>
>> Faiz Abbas (2):
>>   arm64: defconfig: Enable OMAP I2C driver
>>   arm64: defconfig: Enable DAVINCI_GPIO driver
>>
>>  arch/arm64/configs/defconfig | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> 
> Could we do an audit and make sure nothing else is missing - Say ALSA /
> DRM or something else?

I'm not aware of anything that might be missing. That said, I am not
aware of every single config in every subsystem. IMO the various driver
owners should be responsible for adding their configs to defconfig.
 
> 
> And I don't really see the need to split these into individual patches,
> maybe, take a hint from [1]
> 
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200630171500.11438-1-geert+renesas@glider.be/
> 

Sounds good. I'll squash into a single patch and repost.

Thanks,
Faiz
