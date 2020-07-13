Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB09E219F4A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGILtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 07:49:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbgGILtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:49:42 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5895B6936C31BE6C6F6A;
        Thu,  9 Jul 2020 19:49:40 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 9 Jul 2020 19:49:33 +0800
Subject: Re: [REPORT] possible circular locking dependency when booting a VM
 on arm64 host
To:     Salil Mehta <salil.mehta@huawei.com>
CC:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>
References: <7225eba7-6e5e-ec7e-953b-d1fef0b1775b@huawei.com>
 <134ee452eda74f0cbdc10354fe66c48e@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7c1bb3c1-3f64-8c24-ed59-eb3da7bf6643@huawei.com>
Date:   Thu, 9 Jul 2020 19:49:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <134ee452eda74f0cbdc10354fe66c48e@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/9 18:54, Salil Mehta wrote:
> Hi Yuzenghui,
> I will try to reproduce it today at our platform. Just one question is it easily
> reproducible or is a rare occurrence?

Salil, it's 100% reproducible once you start a guest. You don't even
need to assign hostdev to the VM.


Thanks,
Zenghui
