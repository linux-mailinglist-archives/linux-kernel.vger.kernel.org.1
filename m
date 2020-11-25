Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316412C3ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgKYLKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:10:47 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:63725 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgKYLKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:10:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606302646; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=PqJsQPfxrk5KprxWhwtPPwFZQ3ibAZyll4K/xztV6gA=; b=uZS5Vh6VWRcnsNXXtdW9pXy+SBAMC3Kz2tOti3UV5Pk8CArK0ZxDBivYORZuyGR3iMAq3Oih
 8YAU8Ge1AoTWnHNfqFD5r/CIeOr6u6o0XCoKqoS6jh0O/rDg5gBNOtEVxcEejdfl71xKXbvu
 cQHbHspU7w06bBzRhBk07xHbp68=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fbe3bb577b63cdb34ce5a5d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Nov 2020 11:10:45
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B390BC43461; Wed, 25 Nov 2020 11:10:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.154.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 136F8C43460;
        Wed, 25 Nov 2020 11:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 136F8C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm: memory_hotplug: put migration failure information
 under DEBUG_VM
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>
References: <1606140196-6053-1-git-send-email-charante@codeaurora.org>
 <20201123141354.GQ27488@dhcp22.suse.cz>
 <bfa430f6-a6a6-8b08-2776-cb62197619c0@codeaurora.org>
 <775a56a9-b301-31bb-cd6d-8b82b1dd4d65@suse.cz>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <77fcf5d8-7fae-38bb-5bd4-930715163c07@codeaurora.org>
Date:   Wed, 25 Nov 2020 16:40:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <775a56a9-b301-31bb-cd6d-8b82b1dd4d65@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vlastimil!

On 11/24/2020 7:09 PM, Vlastimil Babka wrote:
> On 11/23/20 4:10 PM, Charan Teja Kalla wrote:
>>
>> Thanks Michal!
>> On 11/23/2020 7:43 PM, Michal Hocko wrote:
>>> On Mon 23-11-20 19:33:16, Charan Teja Reddy wrote:
>>>> When the pages are failed to get isolate or migrate, the page owner
>>>> information along with page info is dumped. If there are continuous
>>>> failures in migration(say page is pinned) or isolation, the log buffer
>>>> is simply getting flooded with the page owner information. As most of
>>>> the times page info is sufficient to know the causes for failures of
>>>> migration or isolation, place the page owner information under
>>>> DEBUG_VM.
>>>
>>> I do not see why this path is any different from others that call
>>> dump_page. Page owner can add a very valuable information to debug
>>> the underlying reasons for failures here. It is an opt-in debugging
>>> feature which needs to be enabled explicitly. So I would argue users
>>> are ready to accept a lot of data in the kernel log.
>>
>> Just thinking how frequently failures can happen in those paths. In the
>> memory hotplug path, we can flood the page owner logs just by making one
>> page pinned. Say If it is anonymous page, the page owner information
> 
> So you say it's flooded when page_owner info is included, but not
> flooded when only the rest of __dump_page() is printed? (which is also
> not just one or two lines). That has to be very specific rate of failures.
> Anyway I don't like the solution with arbitrary config option. To
> prevent flooding we generally have ratelimiting, how about that?
> 

I can still say the logs are flooded with just the __dump_page() but
they are lot lesser compare to dump_page_owner.  The lines are something
like below:
page:ffffffff0b070b80 refcount:3 mapcount:1 mapping:ffffff80faf118e9
index:0xc0903
anon flags:
0x800000000008042c(uptodate|dirty|active|owner_priv_1|swapbacked)
raw: 800000000008042c ffffffc047483a58 ffffffc047483a58 ffffff80faf118e9
raw: 00000000000c0903 00000000000985eb 0000000300000000 ffffff800b5f3000
page dumped because: migration failure
page->mem_cgroup:ffffff800b5f3000
page_owner tracks the page as allocated

Rate limiting the logs, both from __dump_page and dump_page_owner,
looking nice. If it is okay for both of you and Michal,  I can raise the
V2 here.

> Also agreed with Michal that page_owner is explicitly enabled debugging
> option and if you use it in production, that's rather surprising to me,
> and possibly more rare than DEBUG_VM, which IIRC Fedora kernels use.

We just enable it on the internal debug systems but never on the
production kernels.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
