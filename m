Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CC72F7284
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733279AbhAOFpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:45:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10970 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbhAOFpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:45:30 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DH98s0gH1zj4lX;
        Fri, 15 Jan 2021 13:43:57 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 13:44:42 +0800
Subject: Re: [PATCH v2] initramfs: Provide a common initrd reserve function
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux@armlinux.org.uk>, Atish Patra <Atish.Patra@wdc.com>,
        <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>
References: <mhng-68a3f8a1-02f5-4487-ae17-fc06c81f072c@penguin>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <6ad30931-85a1-37a1-ce80-9a8752ebb22a@huawei.com>
Date:   Fri, 15 Jan 2021 13:44:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <mhng-68a3f8a1-02f5-4487-ae17-fc06c81f072c@penguin>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/1/15 10:33, Palmer Dabbelt wrote:
> On Wed, 13 Jan 2021 18:33:58 PST (-0800), wangkefeng.wang@huawei.com 
> wrote:
>> The ARM and riscv have same logic to check and reserve
>> the memory of initrd, let's provide a common function to
>> reduce duplicated code.
>>
>> Add __LINUX_INITRD_H define in initrd.h to prevent build error
>> (found by kernel test robot <lkp@intel.com>) from the multiple
>> inclusion of same header file multiple time.
>
> This is doing a bunch of different things:
>
> * Fixing the lack of a preprocessor guard in initrd.h
> * Adding some generic code.
> * Converting two architectures over to that generic code.
>
> It needs to be split into four patches.  I'm happy to take them via 
> the RISC-V tree (with an Ack from for the arch/arm/ stuff), but not 
> all together.
>
> It looks like csky copied this as well, they at least have exactly the 
> same message.

Send v3， according to the suggestion，thanks.

