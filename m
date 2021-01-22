Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50142FFD6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbhAVHbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:31:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11177 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbhAVHag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:30:36 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DMW851ssTzl83B;
        Fri, 22 Jan 2021 15:28:21 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 22 Jan 2021 15:29:44 +0800
Subject: Re: [PATCH v3 0/4] initrd: Use unified initrd reserve function in
 ARM/RISCV
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmerdabbelt@google.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
 <48c006a8-a352-488c-4981-768faffbe343@huawei.com>
 <20210117100903.GB1551@shell.armlinux.org.uk>
 <cc47f8cf-8778-43ab-77de-9dd220de7c26@huawei.com>
 <20210118091733.GD1551@shell.armlinux.org.uk>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <d911b1e6-ed0d-4a73-aee4-060b957897f8@huawei.com>
Date:   Fri, 22 Jan 2021 15:29:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210118091733.GD1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/1/18 17:17, Russell King - ARM Linux admin wrote:
> On Mon, Jan 18, 2021 at 09:01:40AM +0800, Kefeng Wang wrote:
>> On 2021/1/17 18:09, Russell King - ARM Linux admin wrote:
>>> On Sun, Jan 17, 2021 at 12:57:55PM +0800, Kefeng Wang wrote:
>>>> Correct Russell's mail address (from linux@armlinux.org.uk to
>>>> rmk+kernel@armlinux.org.uk, should update the MAINTAINERS)
>>> No. MAINTAINERS is correct.
>> I got following message,  so I check mail of your recent patches, and send a
>> new one.
>>
>> Please ignore it, there may be some other problems.
>>
>> "*Delivery has failed to these recipients or groups:*
>>
>> linux@armlinux.org.uk <mailto:linux@armlinux.org.uk>
>> A communication failure occurred during the delivery of this message. Please
>> to resend the message later. If the problem continues, contact your
>> helpdesk."
> That is a most unhelpful bounce message - I suppose it's designed for
> non-technical people to ensure that the problem can't be resolved.
>
> >From what I can see from my end, every attempt involving your email
> address last week (wangkefeng.wang@huawei.com) has been successful, so
> I suspect the problem is not at my end.

ok，thank you for letting me know that the email has been received,

any comment about the ARM part in the patchset  ;)

>
> In any case, all @armlinux.org.uk addresses hit the same server, so
> if there's a "communication failure" for the domain, it would affect
> all local-parts equally.
>
