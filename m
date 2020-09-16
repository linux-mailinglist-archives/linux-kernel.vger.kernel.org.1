Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BB026B983
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIPBv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:51:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbgIPBvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:51:55 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8B4CFF0684C28E4090F6;
        Wed, 16 Sep 2020 09:51:53 +0800 (CST)
Received: from [127.0.0.1] (10.74.185.4) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 09:51:42 +0800
Subject: Re: [PATCH] KVM: arm64: fix doc warnings in mmu code
To:     Marc Zyngier <maz@kernel.org>
References: <1600175890-7435-1-git-send-email-tanxiaofei@huawei.com>
 <7bcb5fd9b6490e98cfa8aa22496a8a71@kernel.org>
CC:     <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <5F616FAE.4030006@huawei.com>
Date:   Wed, 16 Sep 2020 09:51:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <7bcb5fd9b6490e98cfa8aa22496a8a71@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.185.4]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

OK, I will send v2 patch based on kvmarm-next branch. thanks.

On 2020/9/15 21:47, Marc Zyngier wrote:
> Hi Xiaofei,
> 
> On 2020-09-15 14:18, Xiaofei Tan wrote:
>> Fix following warnings caused by mismatch bewteen function parameters
>> and comments.
>> arch/arm64/kvm/mmu.c:119: warning: Function parameter or member
>> 'pudp'not described in 'stage2_dissolve_pud'
>> arch/arm64/kvm/mmu.c:119: warning: Excess function parameter 'pud'
>> description in 'stage2_dissolve_pud'
> 
> [...]
> 
> Most of this code is being deleted. If you want to fix comments,
> please look at what is in -next.
> 
> Thanks,
> 
>         M.

-- 
 thanks
tanxiaofei

