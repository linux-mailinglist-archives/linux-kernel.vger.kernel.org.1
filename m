Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670E72A3B03
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgKCDY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:24:27 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2489 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKCDY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:24:27 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CQFWM3XtlzQn3q;
        Tue,  3 Nov 2020 11:24:15 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 3 Nov 2020 11:24:16 +0800
Subject: Re: Using fixed LPI number for some Device ID
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
References: <0baed5b0-6cbe-6492-b4af-fe758f461602@huawei.com>
 <04e31996-6eb8-3bb9-e333-bc46eebe3d7a@huawei.com>
 <87eelfksm1.fsf@nanos.tec.linutronix.de>
 <7205d3e0-a03a-a06c-f3f4-9a28e58931e0@huawei.com>
 <87d00yemz4.wl-maz@kernel.org>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <b26b16f3-777e-3f0d-8eac-5739764b387b@huawei.com>
Date:   Tue, 3 Nov 2020 11:24:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87d00yemz4.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/31 17:58, Marc Zyngier wrote:
> On Sat, 31 Oct 2020 03:10:24 +0000,
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> 
> [...]
> 
>>   Sorry for the noise, Because Marc rarely uses the ARM email address,
>>   so I replace to use Marc's kernel.org address instead of ARM email address.
> Rarely is quite the understatement. I left ARM over a year ago, so the
> likelihood of me answering at this address in vanishingly small.

 Thanks for the clarification.

> 
> Maybe in a parallel universe? ;-)
> 
> 	M.
> 
> -- Without deviation from the norm, progress is not possible. .
