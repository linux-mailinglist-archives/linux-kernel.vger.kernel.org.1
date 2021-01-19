Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63F02FB231
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbhASGyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:54:01 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:60352 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbhASGxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 01:53:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611039177; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=HIiycmukDlMKWoaXdKMNjEk1LtaU7BFK1V4A0jvRA64=; b=IT8h2J8fkiDP9WYbpj/K98fjld/sCRzgbtkrZVhZnbeHej/hveejeYpcAWwcAgO50VdHYonj
 5QxsLe7Yg0umNXadRso199YGOXye1LegTWfkZXVTPpfPE/dp3N1uztBJnnZ2fgiIzOpQkKLK
 p+IYV4saK1qiUidAKpU1t+DwkJA=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 600681b075e5c01cbae547e1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 Jan 2021 06:52:32
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ED1DAC43462; Tue, 19 Jan 2021 06:52:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.106] (unknown [182.18.191.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C8B0C433CA;
        Tue, 19 Jan 2021 06:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C8B0C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v5 1/2] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
To:     Randy Dunlap <rdunlap@infradead.org>, minchan@kernel.org,
        glider@google.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, broonie@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, ylal@codeaurora.org,
        vinmenon@codeaurora.org, Vineet Gupta <vgupta@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
References: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
 <2f12a84c-132b-7141-a89e-9e19de0e4b90@infradead.org>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <678c5d5f-3cd4-74ad-aebc-51cbc4c9ee4b@codeaurora.org>
Date:   Tue, 19 Jan 2021 12:22:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <2f12a84c-132b-7141-a89e-9e19de0e4b90@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2021 4:23 AM, Randy Dunlap wrote:
> On 1/18/21 1:56 AM, vjitta@codeaurora.org wrote:
>> From: Yogesh Lal <ylal@codeaurora.org>
>>
>> Use CONFIG_STACK_HASH_ORDER to configure STACK_HASH_SIZE.
>>
>> Aim is to have configurable value for  STACK_HASH_SIZE,
>> so depend on use case one can configure it.
>>
>> One example is of Page Owner, default value of
>> STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
>> Making it configurable and use lower value helps to enable features like
>> CONFIG_PAGE_OWNER without any significant overhead.
>>
>> Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
>> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> Hi,
> 
> Did you see
> https://lore.kernel.org/lkml/202101050729.cwTd47Yw-lkp@intel.com/
> 
> It seems that arch/arc/ does not have:
>    arc-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
>    (.text+0x6): undefined reference to `__irqentry_text_start'
>>> arc-elf-ld: (.text+0x6): undefined reference to `__irqentry_text_start'
>>> arc-elf-ld: (.text+0x26): undefined reference to `__irqentry_text_end'
>>> arc-elf-ld: (.text+0x26): undefined reference to `__irqentry_text_end'
>>> arc-elf-ld: (.text+0x34): undefined reference to `__softirqentry_text_start'
>>> arc-elf-ld: (.text+0x34): undefined reference to `__softirqentry_text_start'
>>> arc-elf-ld: (.text+0x3c): undefined reference to `__softirqentry_text_end'
>>> arc-elf-ld: (.text+0x3c): undefined reference to `__softirqentry_text_end'
> 
> 
> 
> 

The above issue seems to be because of a different patch.
This one
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=505a0ef15f96c6c43ec719c9fc1833d98957bb39

I didn't really get why you referred that here.

Thanks,
Vijay
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
