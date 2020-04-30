Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F2C1BEF53
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 06:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgD3EhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 00:37:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbgD3EhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:37:19 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E51716A03AB502A31410;
        Thu, 30 Apr 2020 12:37:16 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.100) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Apr 2020
 12:37:08 +0800
Subject: Re: [PATCH] sound:hdmi:fix without unlocked before return
To:     Takashi Iwai <tiwai@suse.de>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <libin.yang@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <nmahale@nvidia.com>,
        <aplattner@nvidia.com>, <pierre-louis.bossart@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <1587907042-694161-1-git-send-email-wubo40@huawei.com>
 <s5hees6lpja.wl-tiwai@suse.de>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <42f1f263-6f96-e1f2-6ecc-5a16ca6c828b@huawei.com>
Date:   Thu, 30 Apr 2020 12:37:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <s5hees6lpja.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.100]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/29 15:27, Takashi Iwai wrote:
> On Sun, 26 Apr 2020 15:17:22 +0200,
> Wu Bo wrote:
>>
>> Fix the following coccicheck warning:
>> sound/pci/hda/patch_hdmi.c:1852:2-8: preceding lock on line 1846
>>
>> After add sanity check to pass klockwork check,
>> The spdif_mutex should be unlock before return true
>> in check_non_pcm_per_cvt().
>>
>> Signed-off-by: Wu Bo <wubo40@huawei.com>
> 
> Applied now with the correction of subject and Fixes tag as well as
> Cc-to-stable tag.
> 
> 
> thanks,
> 
> Takashi
> 
> .
> 

Thank you, I am sorry to forget to modify the V2 Patch version in time.

thanks,
Wu Bo




