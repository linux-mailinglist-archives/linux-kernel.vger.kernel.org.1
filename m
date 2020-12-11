Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A252D75F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 13:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436653AbgLKMqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 07:46:37 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:35458 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436642AbgLKMqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:46:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607690751; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=dZVo64QQUTxl+VP4u66SOpvgukGNks/uvE7Zhi3iIzE=; b=cWp+YPKaL6z3/yVKz0JP2DY/v+gwT80LhdhQ0YwUwtr7EF/0u23SxmrzaZT2nWW69SeNP9iQ
 gLZOHAh9zHb6TU2iyD14aJ5F8/HjxcDBShY4tYDKf9RmRg/ihIE8I2HDvHN28YNilvlhkj1M
 etRnZuTYAWp9Rgdf2k5DlOetXKs=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fd369db53d7c5ba609f55fb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 12:45:15
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1BFFC43462; Fri, 11 Dec 2020 12:45:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.105] (unknown [182.18.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC4C7C433CA;
        Fri, 11 Dec 2020 12:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC4C7C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
To:     Alexander Potapenko <glider@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
 <CAG_fn=VKsrYx+YOGPnZw_Q5t6Fx7B59FSUuphj7Ou+DDFKQ+8Q@mail.gmail.com>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <77e98f0b-c9c3-9380-9a57-ff1cd4022502@codeaurora.org>
Date:   Fri, 11 Dec 2020 18:15:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAG_fn=VKsrYx+YOGPnZw_Q5t6Fx7B59FSUuphj7Ou+DDFKQ+8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2020 2:06 PM, Alexander Potapenko wrote:
> On Thu, Dec 10, 2020 at 6:01 AM <vjitta@codeaurora.org> wrote:
>>
>> From: Yogesh Lal <ylal@codeaurora.org>
>>
>> Add a kernel parameter stack_hash_order to configure STACK_HASH_SIZE.
>>
>> Aim is to have configurable value for STACK_HASH_SIZE, so that one
>> can configure it depending on usecase there by reducing the static
>> memory overhead.
>>
>> One example is of Page Owner, default value of STACK_HASH_SIZE lead
>> stack depot to consume 8MB of static memory. Making it configurable
>> and use lower value helps to enable features like CONFIG_PAGE_OWNER
>> without any significant overhead.
> 
> Can we go with a static CONFIG_ parameter instead?
> Guess most users won't bother changing the default anyway, and for
> CONFIG_PAGE_OWNER users changing the size at boot time is not strictly
> needed.
> 
Thanks for review.

One advantage of having run time parameter is we can simply set it to a
lower value at runtime if page_owner=off thereby reducing the memory
usage or use default value if we want to use page owner so, we have some
some flexibility here. This is not possible with static parameter as we
have to have some predefined value.

>> -static struct stack_record *stack_table[STACK_HASH_SIZE] = {
>> -       [0 ...  STACK_HASH_SIZE - 1] = NULL
>> +static unsigned int stack_hash_order = 20;
> 
> Please initialize with MAX_STACK_HASH_ORDER instead.
> 

Sure, will update this.

>> +static struct stack_record *stack_table_def[MAX_STACK_HASH_SIZE] __initdata = {
>> +       [0 ...  MAX_STACK_HASH_SIZE - 1] = NULL
>>  };
>> +static struct stack_record **stack_table __refdata = stack_table_def;
>> +
>> +static int __init setup_stack_hash_order(char *str)
>> +{
>> +       kstrtouint(str, 0, &stack_hash_order);
>> +       if (stack_hash_order > MAX_STACK_HASH_ORDER)
>> +               stack_hash_order = MAX_STACK_HASH_ORDER;
>> +       return 0;
>> +}
>> +early_param("stack_hash_order", setup_stack_hash_order);
>> +
>> +static int __init init_stackdepot(void)
>> +{
>> +       size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
>> +
>> +       stack_table = vmalloc(size);
>> +       memcpy(stack_table, stack_table_def, size);
> 
> Looks like you are assuming stack_table_def already contains some data
> by this point.
> But if STACK_HASH_SIZE shrinks this memcpy() above will just copy some
> part of the table, whereas the rest will be lost.
> We'll need to:
> - either explicitly decide we can afford losing this data (no idea how
> bad this can potentially be),
> - or disallow storing anything prior to full stackdepot initialization
> (then we don't need stack_table_def),
> - or carefully move all entries to the first part of the table.
> 
> Alex
> 

The hash for stack_table_def is computed using the run time parameter
stack_hash_order, though stack_table_def is a bigger array it will only
use the entries that are with in the run time configured STACK_HASH_SIZE
range. so, there will be no data loss during copy.

Thanks,
Vijay

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
