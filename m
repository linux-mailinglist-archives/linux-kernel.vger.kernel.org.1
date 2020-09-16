Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8126C952
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgIPTHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:07:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9115 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgIPTHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:07:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f62624c0000>; Wed, 16 Sep 2020 12:06:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 12:07:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Sep 2020 12:07:04 -0700
Received: from [10.26.74.242] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 19:06:49 +0000
Subject: Re: [PATCH v3 08/16] irqchip/gic: Configure SGIs as standard
 interrupts
To:     Marc Zyngier <maz@kernel.org>
CC:     Sumit Garg <sumit.garg@linaro.org>, <linus.walleij@linaro.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Saravana Kannan <saravanak@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Will Deacon <will@kernel.org>,
        "'Linux Samsung SOC'" <linux-samsung-soc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <kernel-team@android.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20200901144324.1071694-1-maz@kernel.org>
 <20200901144324.1071694-9-maz@kernel.org>
 <CGME20200914130601eucas1p23ce276d168dee37909b22c75499e68da@eucas1p2.samsung.com>
 <a917082d-4bfd-a6fd-db88-36e75f5f5921@samsung.com>
 <933bc43e-3cd7-10ec-b9ec-58afaa619fb7@nvidia.com>
 <3378cd07b92e87a24f1db75f708424ee@kernel.org>
 <dcf812d9-2409-bcae-1925-e21740c2932e@nvidia.com>
 <a6c7bbc91c5b23baa44f3abe35eb61c9@kernel.org>
 <d6dddab0-47aa-ddf2-959b-85493b8da52d@nvidia.com>
 <13c096832bd923f956ddd7db7e337857@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <02bb9262-221a-b2cf-4471-dd3a46b442e7@nvidia.com>
Date:   Wed, 16 Sep 2020 20:06:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <13c096832bd923f956ddd7db7e337857@kernel.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600283212; bh=Caato9smcLm1RjP8f1EkYqHn2EML7zAazOyN82aeyKU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mXVN3L0neXkUd+lGW7ezlyKHpowJAI74TvpC2l3ZTO6w2Je01YIQ5eO0/J3v+RxKa
         Cx9pBSbaDrboIDCzoHY8GPnyNhDqasbr/ritsdvqutkseJ3FcBbW3Zk/LlJh/buO/7
         zemxuSq+f0kmKJrUdAn0CyMsddsykrxUjd5DMQnS6L8GrkooAeBb3Nb1UdzZN5Szs8
         6OwE4EU5aacFGPvRZniE29VuYCZ3O7DtRjKCfw9gtQMUt/U4PHxz1g2DayxzyaSViu
         R6cY+0MsDjHqABditTJDFCZeidlWki7qmMvZNa4TA1fV5IPEQKBcFBWJSU9AsprjQr
         9yaBscXkOc3yA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2020 17:22, Marc Zyngier wrote:
> Do you boot form EL2? 

Not that I am aware of. There is no hypervisor that we are using.

Jon

-- 
nvpublic
