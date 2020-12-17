Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931EC2DD352
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgLQOyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:54:09 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2096 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgLQOyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:54:09 -0500
Received: from dggeme720-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CxZj16ztbzVqbX;
        Thu, 17 Dec 2020 22:52:21 +0800 (CST)
Received: from [10.174.177.7] (10.174.177.7) by dggeme720-chm.china.huawei.com
 (10.1.199.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 17
 Dec 2020 22:53:26 +0800
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <hewenliang4@huawei.com>, <hushiyuan@huawei.com>,
        <luolongjun@huawei.com>, <hejingxian@huawei.com>
References: <87eejqu5q5.fsf@nanos.tec.linutronix.de>
 <f2a4d172-fa17-9f98-ad8f-d69f84ad0df5@huawei.com>
 <87v9d2rrdq.fsf@nanos.tec.linutronix.de>
 <06977da1-d148-0079-0e85-32d657d1a1de@huawei.com>
 <87im91sr6e.fsf@nanos.tec.linutronix.de>
From:   "shenkai (D)" <shenkai8@huawei.com>
Message-ID: <1e93651f-7444-2957-1f39-09bca981e57d@huawei.com>
Date:   Thu, 17 Dec 2020 22:53:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87im91sr6e.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.7]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme720-chm.china.huawei.com (10.1.199.116)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/12/16 23:31, Thomas Gleixner 写道:
> OTOH, the advantage of INIT/SIPI is that the AP comes up in a well known
> state.

We can set APs to a known state explicitly like BSP will do in kexec 
case (what we also tried

to do in the patch). Maybe it is not a big problem?

Best regards

Kai

