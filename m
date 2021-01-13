Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC82F4416
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbhAMFsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:48:52 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:15339 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbhAMFsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:48:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610516911; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=wPOaHcYXsBgh6toaW+x3a5mbEPNNqwuR7H+0C33xnJs=; b=hlsYHCrXSzx6KtWZo9a8XYw6mOz7oEI/IEy8xWBKqc2HqDq0XxjuvkU517u0T2m5mVDrrr6e
 o4Z+gMV5fPr2Fd6p9oG1QBSDSGrrizRPbVIZu3I8JklyPywdOGv3ihluIbzW9yVwABu27BGm
 d3VhBoSGxq5KTFtFHKWtRLzhwZE=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ffe8990415a6293c55410f4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Jan 2021 05:48:00
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 32341C43465; Wed, 13 Jan 2021 05:48:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.43.20] (unknown [157.46.227.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2963C433CA;
        Wed, 13 Jan 2021 05:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2963C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH] mm: slub: Convert sys slab alloc_calls, free_calls to bin
 attribute
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1610443287-23933-1-git-send-email-faiyazm@codeaurora.org>
 <20210112122245.GK35215@casper.infradead.org>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <5d0c8891-40ea-2860-555a-570494993397@codeaurora.org>
Date:   Wed, 13 Jan 2021 11:17:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112122245.GK35215@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2021 5:52 PM, Matthew Wilcox wrote:
> On Tue, Jan 12, 2021 at 02:51:27PM +0530, Faiyaz Mohammed wrote:
>> @@ -5180,6 +5187,7 @@ static int any_slab_objects(struct kmem_cache *s)
>>  
>>  struct slab_attribute {
>>  	struct attribute attr;
>> +	struct bin_attribute bin_attr;
>>  	ssize_t (*show)(struct kmem_cache *s, char *buf);
>>  	ssize_t (*store)(struct kmem_cache *s, const char *x, size_t count);
>>  };
> 
> I'd rather you added a struct slab_bin_attribute.  If that's even
> needed ..  I think you could just use the bin_attribute directly instead
> of embedding it in this struct.
> 

Okay, I will use bin_attribute directly, but I added the bin_attribute
inside the slab_attribute to maintain similar code like sysfs attribute
and slab_attribute is embedded with it's all slab attributes.
