Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D058269514
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgINSj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:39:59 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:25106 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgINSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:39:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600108787; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=QaXy23BdxFSfWsX1lrU9pZ17VgKF+BFRvgU3A+0s0s4=;
 b=i4eEI6z+cq48HaNf/3psX2s+dM0Ygr0ijvnvWusc1zXdFMJAUaMR7iZ7Fqu/s5rH4DoJKMC3
 Ywln+oTDF7u7/QhtQZkN8rzDCc9WkoVgIfbjaPPyldJpaayyx4ejjpTWEOSMH05xqk2TfKw1
 b5GrWVrQALHeYk/PHAp2mNRksi8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f5fb8f0ba408b30ce9e8a04 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 18:39:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 37E11C433F1; Mon, 14 Sep 2020 18:39:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A0A0C433C8;
        Mon, 14 Sep 2020 18:39:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Sep 2020 11:39:43 -0700
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Vinayak Menon <vinmenon@codeaurora.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2] mm: cma: indefinitely retry allocations in cma_alloc
In-Reply-To: <410a4e0c-f924-4564-ae1e-cc9f6292c88e@gmail.com>
References: <1599857630-23714-1-git-send-email-cgoldswo@codeaurora.org>
 <010101747ef2b8fc-a5e44a5a-dcf4-4828-a1d4-a099df63f2df-000000@us-west-2.amazonses.com>
 <410a4e0c-f924-4564-ae1e-cc9f6292c88e@gmail.com>
Message-ID: <75058e054256df7fddf0bfc251b43aa1@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-11 14:37, Florian Fainelli wrote:
> On 9/11/2020 1:54 PM, Chris Goldsworthy wrote:
>> CMA allocations will fail if 'pinned' pages are in a CMA area, since 
>> we
>> cannot migrate pinned pages. The _refcount of a struct page being 
>> greater
>> than _mapcount for that page can cause pinning for anonymous pages.  
>> This
>> is because try_to_unmap(), which (1) is called in the CMA allocation 
>> path,
>> and (2) decrements both _refcount and _mapcount for a page, will stop
>> unmapping a page from VMAs once the _mapcount for a page reaches 0.  
>> This
>> implies that after try_to_unmap() has finished successfully for a page
>> where _recount > _mapcount, that _refcount will be greater than 0.  
>> Later
>> in the CMA allocation path in migrate_page_move_mapping(), we will 
>> have one
>> more reference count than intended for anonymous pages, meaning the
>> allocation will fail for that page.
>> 
>> One example of where _refcount can be greater than _mapcount for a 
>> page we
>> would not expect to be pinned is inside of copy_one_pte(), which is 
>> called
>> during a fork. For ptes for which pte_present(pte) == true, 
>> copy_one_pte()
>> will increment the _refcount field followed by the  _mapcount field of 
>> a
>> page. If the process doing copy_one_pte() is context switched out 
>> after
>> incrementing _refcount but before incrementing _mapcount, then the 
>> page
>> will be temporarily pinned.
>> 
>> So, inside of cma_alloc(), instead of giving up when 
>> alloc_contig_range()
>> returns -EBUSY after having scanned a whole CMA-region bitmap, perform
>> retries indefinitely, with sleeps, to give the system an opportunity 
>> to
>> unpin any pinned pages.
> 
> I am by no means an authoritative CMA person but this behavior does
> not seem acceptable, there is no doubt the existing one is sub-optimal
> under specific circumstances, but an indefinite retry, as well as a
> 100ms sleep appear to be arbitrary at best. How about you introduce a
> parameter that allows the tuning of the number of retries and/or delay
> between retries?
> 

Apologies Florian, I messed up on the threading and there are 
discussions that aren't reference here.  The original version of this 
patch was doing a finite number of retires.  Also, this e-mail was just 
sent out to LKML so I could debug some issues I was facing with git 
send-email.  The actual thread is now here, which summarizes the 
discussions w.r.t. this patch so far:  
https://lkml.org/lkml/2020/9/14/1097

Thanks,

Chris.

-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
