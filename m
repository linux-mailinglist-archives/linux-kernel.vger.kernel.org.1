Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900EE2786F5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgIYMU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:20:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:47954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgIYMU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:20:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601036427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UTjLXvwP0cQUzqYMdns20Sc75oW9I9O0WLbhYPi/g6Y=;
        b=D2Ap3uJ0bRyha3Q5Dk9iyHybJ8SxmC2Vt2I7yKsb0rlwZ4sYLYJzPGgNJQKdwpOFzBVwjU
        PTXQicBP3X+v/ig4f+3+gFutR8Th4NAZnB2IF6Vs1nTkdaUSDpcivPS3wbEzg50VXkjTeM
        RT/euPAFWT/ZCUQewn0epAcsk5lW/zA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 576C8AC5F;
        Fri, 25 Sep 2020 12:20:27 +0000 (UTC)
Subject: Re: [PATCH 08/12] soc: mediatek: pm-domains: Add subsystem clocks
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-9-enric.balletbo@collabora.com>
 <1601031353.1346.71.camel@mtksdaap41>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <923ec8f9-32fe-5a1c-e7fe-8dc1c55d664c@suse.com>
Date:   Fri, 25 Sep 2020 14:20:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1601031353.1346.71.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/09/2020 12:55, Weiyi Lu wrote:
> On Thu, 2020-09-10 at 19:28 +0200, Enric Balletbo i Serra wrote:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> For the bus protection operations, some subsystem clocks need to be enabled
>> before releasing the protection. This patch identifies the subsystem clocks
>> by it's name.
>>
>> Suggested-by: Weiyi Lu <weiyi.lu@mediatek.com>
>> [Adapted the patch to the mtk-pm-domains driver]
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>   drivers/soc/mediatek/mtk-pm-domains.c | 82 +++++++++++++++++++++++----
>>   1 file changed, 70 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
>> index 0802eccc3a0b..52a93a87e313 100644
>> --- a/drivers/soc/mediatek/mtk-pm-domains.c
>> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
[...]
>>   
>> -	pd->num_clks = of_clk_get_parent_count(node);
>> -	if (pd->num_clks > 0) {
>> +	num_clks = of_clk_get_parent_count(node);
>> +	if (num_clks > 0) {
>> +		/* Calculate number of subsys_clks */
>> +		of_property_for_each_string(node, "clock-names", prop, clk_name) {
>> +			char *subsys;
>> +
>> +			subsys = strchr(clk_name, '-');
>> +			if (subsys)
>> +				pd->num_subsys_clks++;
>> +			else
>> +				pd->num_clks++;
>> +		}
>> +
> 
> In fact, I don't like the clock naming rules, as Matthias mentioned
> before. So in my work v17[1]
> I put subsystem clocks under each power domain sub-node without giving
> the clock name but put the basic clocks under the power controller node.
> 
> [1] https://patchwork.kernel.org/patch/11703191/

The quick answer, there is no perfect solution to our problem. If we put all 
basic clocks under the parent node, then we will have to have a list of basic 
clocks in the driver data for each SoC. Apart from that the DTS would not 
reflect the exact hardware, as the basic clocks needed for every power domain 
would be hidden in the driver data.

Given this, I think the best way is to distinguish the clocks by it's name, as 
done by you in earlier series of the scpsys. It will give us a cleaner device 
tree and we won't need to add long clock lists in the driver data. If I remember 
correctly Rob acknowledged your binding change for that:
https://patchwork.kernel.org/patch/11562521/

Regards,
Matthias

