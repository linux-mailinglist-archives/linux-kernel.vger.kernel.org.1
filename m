Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94AE269528
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgINSqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:46:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58848 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgINSpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:45:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600109146; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/goy+YMw4BfvVeOPCaLRpE4rv9Sxs8JsO9XnDZB6Q+8=;
 b=I+VOUdCczLuEWf4a/NVckJoi3ehBlZ/vLketgZrIi5wdZcRUN7njsFUjmdZXvFXKcaJaKTlY
 6HgbB3S0cmo/iW86F/Q6QVhYU2wh56YutEoaU8hDTRSa/c2mdmKjk+daL4MbmCIg486WVkPv
 TB8YLNCHLjIn802Wv4P9UwLq8do=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f5fba4854e87432be37bca5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 18:45:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C9B2C43382; Mon, 14 Sep 2020 18:45:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 783AFC433C8;
        Mon, 14 Sep 2020 18:45:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Sep 2020 11:45:26 -0700
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Vinayak Menon <vinmenon@codeaurora.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2] mm: cma: indefinitely retry allocations in cma_alloc
In-Reply-To: <60e99abb-7f69-c585-ff9f-76ebe6a81de6@infradead.org>
References: <1599857630-23714-1-git-send-email-cgoldswo@codeaurora.org>
 <010101747ef2b8fc-a5e44a5a-dcf4-4828-a1d4-a099df63f2df-000000@us-west-2.amazonses.com>
 <410a4e0c-f924-4564-ae1e-cc9f6292c88e@gmail.com>
 <60e99abb-7f69-c585-ff9f-76ebe6a81de6@infradead.org>
Message-ID: <8a736e7e213531c1894e17552152becb@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-11 14:42, Randy Dunlap wrote:
> On 9/11/20 2:37 PM, Florian Fainelli wrote:
>> 
>> I am by no means an authoritative CMA person but this behavior does 
>> not seem acceptable, there is no doubt the existing one is sub-optimal 
>> under specific circumstances, but an indefinite retry, as well as a 
>> 100ms sleep appear to be arbitrary at best. How about you introduce a 
>> parameter that allows the tuning of the number of retries and/or delay 
>> between retries?
> 
> Also:
> 
> You should send your patch to linux-mm@kvack.org -- that's where
> most memory management type patches are reviewed.
> 
> You should also send your patch to someone who could actually merge
> it into the kernel source tree -- assuming that's what you want to 
> happen.
> 
> Try scripts/get_mainttainer.pl on your patch to see what it says.
> 
> And if you are going to use a "cover letter" or "introductory email" 
> before
> the actual patch, the second (patch(es)) should be sent chained to the
> first email.  git send-email should do this for you.

Hi Randy,

git send-email was not using the correct ID to generate a response to 
the cover letter, and I'm not able to fathom why.  This e-mail was 
actually just sent out as a test to LKML as a test so I could figure out 
how to resolve the issue, I wasn't actually expecting anyone to read 
this.  The actual e-mail, with the correct maintainer (Andrew Morton) 
and mailing lists, as well as the summary of the discussion on the 
patches so far, may be found here: https://lkml.org/lkml/2020/8/11/893

Thanks,

Chris.

-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
