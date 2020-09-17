Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B00F26DC25
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgIQM4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:56:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727115AbgIQMy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:54:29 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EB91654FF72C6B2D205D;
        Thu, 17 Sep 2020 20:54:13 +0800 (CST)
Received: from [10.174.179.91] (10.174.179.91) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 20:54:11 +0800
Subject: Re: [PATCH -next] x86/xen: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
References: <20200716090641.14184-1-miaoqinglang@huawei.com>
 <a75ff99a-bb2e-6470-6c47-e7089c0fc8b4@oracle.com>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <506f6380-1e3e-dc22-bf9a-a6d81bb0eeec@huawei.com>
Date:   Thu, 17 Sep 2020 20:54:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a75ff99a-bb2e-6470-6c47-e7089c0fc8b4@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/7/19 9:59, Boris Ostrovsky 写道:
> On 7/16/20 5:06 AM, Qinglang Miao wrote:
>> From: Chen Huang <chenhuang5@huawei.com>
>>
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Chen Huang <chenhuang5@huawei.com>
> 
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> 
Hi Boris,

I noticed that this patch has been rebiewed but there's small conflict 
if you apply it against latest linux-next. So I resend a v2 patch 
against linux-next(20200917), and it can be applied to mainline cleanly 
now.

Thanks.
