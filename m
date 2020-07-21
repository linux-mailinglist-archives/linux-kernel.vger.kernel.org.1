Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAEE2280A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 15:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgGUNLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 09:11:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727888AbgGUNLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:11:14 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 49D40BF5B11D494BE7B7;
        Tue, 21 Jul 2020 21:11:11 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.103) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Jul 2020
 21:11:01 +0800
Subject: Re: [PATCH] ARM: at91: pm: add missing put_device() call in
 at91_pm_sram_init()
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20200604123301.3905837-1-yukuai3@huawei.com>
 <20200702200915.GC6538@piout.net>
 <01fd6279-524e-3cee-4c16-5b748a49d0f0@huawei.com>
 <20200717225542.GZ3428@piout.net>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <0b50d5fe-44c7-1016-2d79-036001377c4f@huawei.com>
Date:   Tue, 21 Jul 2020 21:11:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200717225542.GZ3428@piout.net>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.103]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/18 6:55, Alexandre Belloni wrote:

> A better fix would have been to also factorize imx_suspend_alloc_ocram,
> imx6q_suspend_init, socfpga_setup_ocram_self_refresh and
> at91_pm_sram_init as they were all copied from pm-imx6.c
> 
imx_suspend_alloc_ocram and imx6q_suspend_init are done areadly,
socfpga_setup_ocram_self_refresh and at91_pm_sram_init still need to
fix. Thanks for pointing out!

Yu Kuai

