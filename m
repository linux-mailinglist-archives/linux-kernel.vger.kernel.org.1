Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866E6251919
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 14:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgHYM53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 08:57:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45028 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbgHYM52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:57:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0DE891BA80540EF3079A;
        Tue, 25 Aug 2020 20:57:25 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.103) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 25 Aug 2020
 20:57:15 +0800
Subject: Re: [PATCH 1/2] ASoC: fsl: imx-es8328: add missing kfree() call in
 imx_es8328_probe()
To:     Mark Brown <broonie@kernel.org>
CC:     <timur@kernel.org>, <nicoleotsuka@gmail.com>,
        <Xiubo.Lee@gmail.com>, <festevam@gmail.com>,
        <shengjiu.wang@gmail.com>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <linux-imx@nxp.com>, <xobs@kosagi.com>,
        <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai@huawei.com>,
        <yi.zhang@huawei.com>
References: <20200825120531.1479304-1-yukuai3@huawei.com>
 <20200825120531.1479304-2-yukuai3@huawei.com>
 <20200825121102.GF5379@sirena.org.uk>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <4b0147df-b773-6c04-ff08-0bbc8b668f5f@huawei.com>
Date:   Tue, 25 Aug 2020 20:57:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200825121102.GF5379@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.103]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/08/25 20:11, Mark Brown wrote:
> On Tue, Aug 25, 2020 at 08:05:30PM +0800, Yu Kuai wrote:
>> If memory allocation for 'data' or 'comp' succeed, imx_es8328_probe()
>> doesn't have corresponding kfree() in exception handling. Thus add
>> kfree() for this function implementation.
> 
>> @@ -151,7 +151,7 @@ static int imx_es8328_probe(struct platform_device *pdev)
>>   	comp = devm_kzalloc(dev, 3 * sizeof(*comp), GFP_KERNEL);
>>   	if (!comp) {
> 
> The allocation is being done using devm_ which means no explicit kfree()
> is needed, the allocation will be automatically unwound when the device
> is unbound.

Hi,

Thanks for pointing it out, I'll remove this patch.

Best regards,
Yu Kuai

