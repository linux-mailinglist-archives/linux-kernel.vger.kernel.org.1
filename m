Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226212E340C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 05:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgL1Ewi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 23:52:38 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:50202 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgL1Ewi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 23:52:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609131133; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=BO8IW9Q/PT7UqzydT2jMWi2wLodhoA3BrQp/tn36dPI=; b=mxKzoTX68KAtUSKWHJ/uUEc0PJDzDIlj2m/z50+iiY4aFH7aW2CTInWd7I9nXx39hQksfgwW
 9igtpnzVakkVV6JyJx4AxrIFp/jgmuuaB0wIaJh89C9a2HiRtkX9IVck5PdV1TXFMvY60VC2
 hWyXs/EtNxemFTDgUQqCq3vU6Vo=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fe96463cfd94dd3283f000a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Dec 2020 04:51:47
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F3EC2C43466; Mon, 28 Dec 2020 04:51:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.0.106] (unknown [182.18.191.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5DEBC433C6;
        Mon, 28 Dec 2020 04:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5DEBC433C6
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
        ylal@codeaurora.org, vinmenon@codeaurora.org,
        kasan-dev <kasan-dev@googlegroups.com>
References: <CAG_fn=UjJQP_gfDm3eJTPY371QTwyDJKXBCN2gs4DvnLP2pbyQ@mail.gmail.com>
 <7f2e171f-fa44-ef96-6cc6-14e615e3e457@codeaurora.org>
 <CAG_fn=VihkHLx7nHRrzQRuHeL-UYRezcyGLDQMJY+d1O5AkJfA@mail.gmail.com>
 <601d4b1a-8526-f7ad-d0f3-305894682109@codeaurora.org>
 <CAG_fn=V8e8y1fbOaYUD5SfDSQ9+Tc3r7w6ZSoJ-ZNFJvvq-Aeg@mail.gmail.com>
 <9e0d2c07-af1f-a1d3-fb0d-dbf2ae669f96@codeaurora.org>
 <CAG_fn=UXQUGiDqmChqD-xX-yF5Jp+7K+oHwKPrO9DZL-zW_4KQ@mail.gmail.com>
 <48df48fe-dc36-83a4-1c11-e9d0cf230372@codeaurora.org>
 <6110a26b-dc87-b6f9-e679-aa60917403de@codeaurora.org>
 <CAG_fn=VjejHtY8=cuuFkixpXd6A6q1C==6RAaUC3Vb5_4hZkcg@mail.gmail.com>
 <X+EFmQz6JKfpdswG@google.com>
 <d769a7b1-89a2-aabe-f274-db132f7229d1@codeaurora.org>
 <CAG_fn=UUo3tP1XtdOntNG1krvbPV7pmE9XXwMyuhL2gMUoc4Jw@mail.gmail.com>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <dbce90d4-17e5-15a3-4336-9efede16c772@codeaurora.org>
Date:   Mon, 28 Dec 2020 10:21:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=UUo3tP1XtdOntNG1krvbPV7pmE9XXwMyuhL2gMUoc4Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/2020 8:10 PM, Alexander Potapenko wrote:
>>
>> Michan, We would still need config option so that we can reduce the
>> memory consumption on low ram devices using config.
>>
>> Alex, On this,
>> "I also suppose device vendors may prefer setting a fixed (maybe
>> non-default) hash size for low-memory devices rather than letting the
>> admins increase it."
>> I see kernel param swiotlb does similar thing i.e; '0' to disable and
>> set a value to configure size.
>>
>> I am fine with either of the approaches,
>>
>> 1. I can split this patch into two
>>    i)  A bool variable to enable/disable stack depot.
>>    ii) A config for the size.
> 
> I still believe this is a more appropriate solution.
> 
> Thanks in advance!
> 

Thanks, Will work on a patch with above approach.

Thanks,
Vijay
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
