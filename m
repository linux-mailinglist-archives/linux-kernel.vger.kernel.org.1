Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D772FFB76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 05:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbhAVEB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 23:01:29 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:17072 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbhAVEB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 23:01:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611288062; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=k8p/9iah5u3Ps8oDNRx/PB8he4pehkzYRrW2ZakZsiA=; b=l6BMv81HNtLzaHow8DMjzWBYcuEOXNi/AKhKEQmMbvLK4WIjatqlC+q+sOC+O3J8cx563KF3
 +PRTzE9EYw81QBDLlt5qQcLSxkHOSmwcgsMoqYCY9SMde1KU4B5R3YNjHspzLCu1FG67c5Rm
 W19sY910k4O5yYgJswwj7IUbA9w=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 600a4dce5677aca7bde9fe0d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 Jan 2021 04:00:14
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 03EDEC43463; Fri, 22 Jan 2021 04:00:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.106] (unknown [182.18.191.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3654C433C6;
        Fri, 22 Jan 2021 04:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3654C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v5 1/2] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
To:     Minchan Kim <minchan@kernel.org>
Cc:     glider@google.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, broonie@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, ylal@codeaurora.org,
        vinmenon@codeaurora.org
References: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
 <YAoaCqvRHILKp3w6@google.com>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <b89b802b-1826-0776-6d3a-2f89f85ea2f3@codeaurora.org>
Date:   Fri, 22 Jan 2021 09:30:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAoaCqvRHILKp3w6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/2021 5:49 AM, Minchan Kim wrote:
> On Mon, Jan 18, 2021 at 03:26:41PM +0530, vjitta@codeaurora.org wrote:
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
> 
> The description could be improved to prevent confusing.
> CONFIG_PAGE_OWNER works only if page_owner=on via kernel parameter
> on CONFIG_PAGE_OWNER configured system.
> Thus, unless admin enable it via command line option, the stackdepot
> will just waste 8M memory without any customer.
> 

Sure, will update the commit text as suggested.

Thanks,
Vijay
>>
>> Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
>> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> Reviewed-by: Minchan Kim <minchan@kernel.org>
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
