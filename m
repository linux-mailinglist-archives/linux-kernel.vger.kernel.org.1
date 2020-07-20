Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C42255E4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 04:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgGTC1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 22:27:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8329 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbgGTC1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:27:22 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0AC2B61B87CB122F880B;
        Mon, 20 Jul 2020 10:27:20 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Jul 2020 10:27:10 +0800
Subject: Re: [PATCH] irqchip/gic-v4.1: Ensure accessing the correct RD when
 writing INVALLR
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>
References: <20200709134959.1039-1-yuzenghui@huawei.com>
 <87h7u6xuur.wl-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4d79c6f0-cb38-70fc-93e7-0172417ecbfd@huawei.com>
Date:   Mon, 20 Jul 2020 10:27:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87h7u6xuur.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/7/17 19:07, Marc Zyngier wrote:
> On Thu, 09 Jul 2020 14:49:59 +0100,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> The GICv4.1 spec tells us that it's CONSTRAINED UNPREDICTABLE to issue a
>> register-based invalidation operation for a vPEID not mapped to that RD,
>> or another RD within the same CommonLPIAff group.
>>
>> To follow this rule, commit f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual
>> exclusion between vPE affinity change and RD access") tried to address the
>> race between the RD accesses and the vPE affinity change, but somehow
>> forgot to take GICR_INVALLR into account. Let's take the vpe_lock before
>> evaluating vpe->col_idx to fix it.
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> 
> Shouldn't this deserve a Fixes: tag?

Yes, I think a

Fixes: f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual exclusion between 
vPE affinity change and RD access")

should be enough. Should I resend a version with the tag added?


Thanks,
Zenghui
