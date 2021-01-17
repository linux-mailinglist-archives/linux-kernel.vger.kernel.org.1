Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4282F9078
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 06:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbhAQE6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 23:58:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11167 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAQE6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 23:58:44 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DJN1M1cKszl4mF;
        Sun, 17 Jan 2021 12:56:39 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sun, 17 Jan 2021 12:57:56 +0800
Subject: Re: [PATCH v3 0/4] initrd: Use unified initrd reserve function in
 ARM/RISCV
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        <palmerdabbelt@google.com>, Atish Patra <atish.patra@wdc.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>, <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <48c006a8-a352-488c-4981-768faffbe343@huawei.com>
Date:   Sun, 17 Jan 2021 12:57:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct Russell's mail address (from linux@armlinux.org.uk to 
rmk+kernel@armlinux.org.uk, should update the MAINTAINERS)

On 2021/1/15 13:46, Kefeng Wang wrote:
> Use the same implementation of initrd reserve to avoid duplication.
>
> v3:
> - split into four patches, suggested-by Palmer Dabbelt
> v2:
> - fix build error found by kernel test robot
>
> Kefeng Wang (4):
>    initrd: Add the preprocessor guard in initrd.h
>    initramfs: Provide a common initrd reserve function
>    ARM: Covert to reserve_initrd_mem()
>    riscv: Covert to reserve_initrd_mem()
>
>   arch/arm/mm/init.c     | 43 +--------------------------------
>   arch/riscv/mm/init.c   | 54 +-----------------------------------------
>   include/linux/initrd.h | 11 +++++++++
>   init/initramfs.c       | 45 +++++++++++++++++++++++++++++++++++
>   4 files changed, 58 insertions(+), 95 deletions(-)
>
