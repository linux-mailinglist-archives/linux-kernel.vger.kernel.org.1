Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9512A8BAC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 01:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbgKFAyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 19:54:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7594 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbgKFAyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 19:54:09 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CS22c5BwxzLt3T;
        Fri,  6 Nov 2020 08:54:00 +0800 (CST)
Received: from [10.174.176.134] (10.174.176.134) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 6 Nov 2020
 08:54:03 +0800
Subject: Re: [PATCH] mfd: htc-i2cpld: Add the missed i2c_put_adapter() in
 htcpld_register_chip_i2c()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Lee Jones <lee.jones@linaro.org>
References: <20201104063158.102048-1-jingxiangfeng@huawei.com>
 <ec8f256f-d796-1311-1faa-443e33631ced@web.de>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5FA49EAB.2020308@huawei.com>
Date:   Fri, 6 Nov 2020 08:54:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <ec8f256f-d796-1311-1faa-443e33631ced@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/4 14:50, Markus Elfring wrote:
>> htcpld_register_chip_i2c() misses to call i2c_put_adapter() in an error
>> path. Add the missed function call to fix it.
> Would you like to add the tag “Fixes”?
OK, I'll send a v2 with it.

  Thanks
>
> Regards,
> Markus
> .
>

