Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A303E26EA78
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgIRB3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:29:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13247 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbgIRB3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:29:30 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 91D75909FAFC2E4055A2;
        Fri, 18 Sep 2020 09:29:28 +0800 (CST)
Received: from [10.174.179.91] (10.174.179.91) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 09:29:25 +0800
Subject: Re: [PATCH -next] crypto: caam: Convert to DEFINE_SHOW_ATTRIBUTE
To:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200716090403.13507-1-miaoqinglang@huawei.com>
 <00ab6498-a1cb-afb2-b1e4-75389bfbbd4c@nxp.com>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <10ed0a23-a4bb-5c30-fa7e-ca9f2a20c596@huawei.com>
Date:   Fri, 18 Sep 2020 09:29:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <00ab6498-a1cb-afb2-b1e4-75389bfbbd4c@nxp.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/7/20 20:01, Horia Geantă 写道:
> On 7/16/2020 12:00 PM, Qinglang Miao wrote:
>> From: Liu Shixin <liushixin2@huawei.com>
>>
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
> 
> This patch depends on linux-next
> commit 4d4901c6d748 ("seq_file: switch over direct seq_read method calls to seq_read_iter")
Hi Horia,

I noticed that 4d4901c6d748 in linux-next has been reverted, so I resent 
a new patch against linux-next(20200917), and it can be applied to 
mainline cleanly now.

Thanks.
> 
> Horia
> 
