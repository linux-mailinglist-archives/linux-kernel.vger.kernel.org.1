Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D071EF3B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgFEJIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 05:08:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgFEJIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:08:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E38BE8A2349040B75B79;
        Fri,  5 Jun 2020 17:08:48 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.204) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 5 Jun 2020
 17:08:38 +0800
Subject: Re: [PATCH] ARM: imx6: add missing put_device() call in
 imx6q_suspend_init()
To:     Markus Elfring <Markus.Elfring@web.de>, <kernel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-imx@nxp.com>
CC:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Yi Zhang <yi.zhang@huawei.com>,
        <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cf810c93-297c-c02c-9bba-8c3d097b8e31@web.de>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <2ab2cc9f-c720-75ca-e20c-0e4236ff45fd@huawei.com>
Date:   Fri, 5 Jun 2020 17:08:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cf810c93-297c-c02c-9bba-8c3d097b8e31@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.204]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/5 3:07, Markus Elfring wrote:
>> if of_find_device_by_node() succeed, imx6q_suspend_init() doesn't have a
>> corresponding put_device(). Thus add a jump target to fix the exception
>> handling for this function implementation.
> 
> Do you find a previous update suggestion useful?
> 
> ARM: imx6: Add missing put_device() call in imx6q_suspend_init()
> https://lore.kernel.org/linux-arm-kernel/5acd7308-f6e1-4b1e-c744-bb2e5fdca1be@web.de/
> https://lore.kernel.org/patchwork/patch/1151158/
> https://lkml.org/lkml/2019/11/9/125

Hi, Markus

It is useful indeed. Although I didn't run cocci script, since it can 
produce too many false result which is hard to filter out.

BTW, I see you haver done the work already, I guess I won't send any 
patches related to 'missing put_device after of_find_device_by_node()'. 
Any idea why these pathes didn't get applied ?

Best regards,
Yu Kuai




