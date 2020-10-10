Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD411289F77
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgJJJFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 05:05:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728466AbgJJI7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 04:59:07 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5ADD2E292EE0F96B498;
        Sat, 10 Oct 2020 16:41:16 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Sat, 10 Oct 2020 16:41:10 +0800
Subject: Re: Patch "spi: Fix controller unregister order" has been added to
 the 4.4-stable tree
To:     <linux-kernel@vger.kernel.org>, <lukas@wunner.de>,
        <sashal@kernel.org>, <chenwenyong2@huawei.com>
CC:     <stable-commits@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20200616015646.AC54E2074D@mail.kernel.org>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <8c7683cc-ca73-6883-8e45-613de68fa665@huawei.com>
Date:   Sat, 10 Oct 2020 16:41:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200616015646.AC54E2074D@mail.kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/6/16 9:56, Sasha Levin Ð´µÀ:
> This is a note to let you know that I've just added the patch titled
> 
>      spi: Fix controller unregister order
> 
> to the 4.4-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       spi-fix-controller-unregister-order.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit af9adff04d45f726c49bc1be4a401877e627adf3
> Author: Lukas Wunner <lukas@wunner.de>
> Date:   Fri May 15 17:58:01 2020 +0200
> 
>      spi: Fix controller unregister order
>      
>      [ Upstream commit 84855678add8aba927faf76bc2f130a40f94b6f7 ]
>      
>      When an SPI controller unregisters, it unbinds all its slave devices.
>      For this, their drivers may need to access the SPI bus, e.g. to quiesce
>      interrupts.
>      
>      However since commit ffbbdd21329f ("spi: create a message queueing
>      infrastructure"), spi_destroy_queue() is executed before unbinding the
>      slaves.  It sets ctlr->running = false, thereby preventing SPI bus
>      access and causing unbinding of slave devices to fail.
>      
>      Fix by unbinding slaves before calling spi_destroy_queue().
>      
>      Fixes: ffbbdd21329f ("spi: create a message queueing infrastructure")
>      Signed-off-by: Lukas Wunner <lukas@wunner.de>
>      Cc: stable@vger.kernel.org # v3.4+
>      Cc: Linus Walleij <linus.walleij@linaro.org>
>      Link: https://lore.kernel.org/r/8aaf9d44c153fe233b17bc2dec4eb679898d7e7b.1589557526.git.lukas@wunner.de
>      Signed-off-by: Mark Brown <broonie@kernel.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index e5460d84ed08..57001f8f727a 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1922,11 +1922,12 @@ void spi_unregister_master(struct spi_master *master)
>   			dev_err(&master->dev, "queue remove failed\n");
>   	}
>   
> +	device_for_each_child(&master->dev, NULL, __unregister);
> +

Hi,

This is a wrong patch. We should move this line before
spi_destroy_queue, but we didn't. 4.9 stable exists this
problem too.

Thanks,
Kun.



>   	mutex_lock(&board_lock);
>   	list_del(&master->list);
>   	mutex_unlock(&board_lock);
>   
> -	device_for_each_child(&master->dev, NULL, __unregister);
>   	device_unregister(&master->dev);
>   }
>   EXPORT_SYMBOL_GPL(spi_unregister_master);
> 
> .
> 
