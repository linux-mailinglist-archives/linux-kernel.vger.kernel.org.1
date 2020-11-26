Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44952C5401
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388143AbgKZMcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:32:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8413 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732982AbgKZMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:32:21 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ChcZl0wzqz71D4;
        Thu, 26 Nov 2020 20:31:59 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 20:32:19 +0800
Subject: Re: [PATCH] printk: finalize records with trailing newlines
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
CC:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Atish Patra <atishp@atishpatra.org>,
        <linux-kernel@vger.kernel.org>
References: <20201126114836.14750-1-john.ogness@linutronix.de>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <53ab7746-5871-992b-7ab8-853b7c08ae13@huawei.com>
Date:   Thu, 26 Nov 2020 20:32:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201126114836.14750-1-john.ogness@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 19:48, John Ogness wrote:
> Any record with a trailing newline (LOG_NEWLINE flag) cannot
> be continued because the newline has been stripped and will
> not be visible if the message is appended. This was already
> handled correctly when committing in log_output() but was
> not handled correctly when committing in log_store().
>
> Fixes: f5f022e53b87 ("printk: reimplement log_cont using record extension")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>   This is an important bugfix for continuous messages and should
>   be part of the 5.10 release.
>
>   If not applied, newlines will vanish when concatenating
>   continuous with trailing newlines.
Thanks for you quick fix.

Reported-and-tested-by:  Kefeng Wang <wangkefeng.wang@huawei.com>

>   kernel/printk/printk.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fe64a49344bf..bc1e3b5a97bd 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -528,8 +528,8 @@ static int log_store(u32 caller_id, int facility, int level,
>   	if (dev_info)
>   		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
>   
> -	/* insert message */
> -	if ((flags & LOG_CONT) || !(flags & LOG_NEWLINE))
> +	/* A message without a trailing newline can be continued. */
> +	if (!(flags & LOG_NEWLINE))
>   		prb_commit(&e);
>   	else
>   		prb_final_commit(&e);
