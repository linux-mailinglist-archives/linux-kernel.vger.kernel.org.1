Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C572C2870
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbgKXNla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:41:30 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13400 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388508AbgKXNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:41:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbd0d810001>; Tue, 24 Nov 2020 05:41:21 -0800
Received: from [10.26.73.42] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 13:41:18 +0000
Subject: Re: [PATCH v3 1/6] regulator: core: validate selector against
 linear_min_sel
To:     <Claudiu.Beznea@microchip.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>
References: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
 <1605280870-32432-2-git-send-email-claudiu.beznea@microchip.com>
 <cb096dc5-3757-d72f-41a9-c99007c84b40@nvidia.com>
 <f06c90ca-11c8-961d-1461-a9486933a1a3@microchip.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <37ae7275-3c85-e94e-4ed1-95b6b901c2ed@nvidia.com>
Date:   Tue, 24 Nov 2020 13:41:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f06c90ca-11c8-961d-1461-a9486933a1a3@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606225281; bh=uXZ4u1cE3+7+dI2WQLB2qWxO9E29jIy8roMuYHHhNKY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=MkolR3bkIG75EVyAoVjXdjn0EpDyo2s99ddrR/XoyqU+3mKZ8N1DsVGw8iLKEUXiC
         zZSPfKPxChyxw8ySnEpU4MsYoIRqdDkegDsSxi7OcGi53c9Z5/F1kjrPfxoROUoH/H
         VT4ANWLD1I1c7Cl4f+XdsuAVE/dfdXFRcqKAq/lsK3Or5zETPGKVqY4dxRg+p5RAx/
         VNtGP4loTsWzc9CXS5Ku1s3l5DU28JGPZV30Te9t1GRTn6jSSLGwrVHPh9O308C3jl
         WCwbeVRdW5CMoPBgKaan9+nyjjM/6ghFuT4YEYB60JksVLuTF3bAw3EXKXpQqZFXn6
         gmashfOPatcPg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/11/2020 11:14, Claudiu.Beznea@microchip.com wrote:

...

> I would say that a solution would be to have a new helper to retrieve the
> linear_min_sel (e.g. regulator_min_sel()) and use this for all the
> consumers of regulator_list_voltage() and the other APIs that patch
> "regulator: core: validate selector against linear_min_sel" has changed
> (regulator_list_voltage_table(), regulator_set_voltage_time()). With this
> change the loop in find_vdd_map_entry_exact() should be b/w
> regulator_min_sel() and regulator_count_voltages().
> 
> Maybe Mark has a better solution for this.


By the way, I don't think that Tegra is alone here. I see some other
drivers doing some similar things [0][1][2] and so I am wondering if
this is going to be a problem for a few drivers.

Jon

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/core/regulator.c#n61
[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/s3c2416-cpufreq.c#n263
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/leds/leds-regulator.c#n29

-- 
nvpublic
