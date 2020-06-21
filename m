Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4731B202C96
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 22:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgFUUA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 16:00:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61619 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730572AbgFUUAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 16:00:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592769654; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=PcRwyM/q7gRijAGFkGubRrPiplDl/KY95AYs4N79p00=; b=DkLvRchVQWE+Naj/fYZ8ket1S3DcKzo46fi1r2v0we8sUWDCCazsuuEdx86mhY9h6G/TJAhT
 UewmHouRPKzXfSDFwByBhLBM0+7FXaSWXFbEZzvb3aQ/am/feiKPAjo+PgxxnOmmja/J8Cw4
 EvidoyNbwSfvGqlB9F2zdynImm0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5eefbc668fe116ddd99cc01f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 21 Jun 2020 20:00:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61954C433B6; Sun, 21 Jun 2020 20:00:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.0.100] (unknown [124.123.165.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1058CC43395;
        Sun, 21 Jun 2020 20:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1058CC43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu/tree: Force quiescent state on callback overload
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1592764647-2452-1-git-send-email-neeraju@codeaurora.org>
 <20200621195052.GF9247@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <94686c2e-b589-2598-e658-42f13cec1216@codeaurora.org>
Date:   Mon, 22 Jun 2020 01:30:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200621195052.GF9247@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 6/22/2020 1:20 AM, Paul E. McKenney wrote:
> On Mon, Jun 22, 2020 at 12:07:27AM +0530, Neeraj Upadhyay wrote:
>> On callback overload, we want to force quiescent state immediately,
>> for the first and second fqs. Enforce the same, by including
>> RCU_GP_FLAG_OVLD flag, in fqsstart check.
>>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> 
> Good catch!
> 
> But what did you do to verify that this change does the right thing?
> 
> 						Thanx, Paul
> 

I haven't done a runtime verification of this code path; I posted this, 
based on review of this code.


Thanks
Neeraj

>> ---
>>   kernel/rcu/tree.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index d0988a1..6226bfb 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -1865,7 +1865,7 @@ static void rcu_gp_fqs_loop(void)
>>   			break;
>>   		/* If time for quiescent-state forcing, do it. */
>>   		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
>> -		    (gf & RCU_GP_FLAG_FQS)) {
>> +		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
>>   			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>>   					       TPS("fqsstart"));
>>   			rcu_gp_fqs(first_gp_fqs);
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
