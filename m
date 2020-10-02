Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5B2817CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbgJBQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:23:43 -0400
Received: from z5.mailgun.us ([104.130.96.5]:20885 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgJBQXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:23:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601655821; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uEPu1FRcUu9u8HJMWtnVjI5EIS8OxL5zgVv90u9nEAI=;
 b=bfiFHhWHOYjQ+eVmwNfZsCpsITgESC220OqiOtZ13ai9f8k0q1i69Tyb5Xd95kUEpA4I4mKg
 yqm4HuzXoL+v6gMMbdRSNjV9cS1x6FnKMFqUODOY/vpDeOLqy4VAw+ApHl6g2FI1oMiKX+Bi
 8sNZXHJW3u82DoSO90iRHLJ+UMM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f77540a42f9861fb1d39017 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Oct 2020 16:23:38
 GMT
Sender: pintu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 02FB0C433FF; Fri,  2 Oct 2020 16:23:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pintu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8E1FC433FE;
        Fri,  2 Oct 2020 16:23:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 02 Oct 2020 21:53:37 +0530
From:   pintu@codeaurora.org
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, pintu.ping@gmail.com
Subject: Re: [PATCH] mm/util.c: Add error logs for commitment overflow
In-Reply-To: <20201002121726.GF4555@dhcp22.suse.cz>
References: <1601639861-32171-1-git-send-email-pintu@codeaurora.org>
 <20201002121726.GF4555@dhcp22.suse.cz>
Message-ID: <adaf346febe6bb6fbdcedb8709e35bcb@codeaurora.org>
X-Sender: pintu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-02 17:47, Michal Hocko wrote:

>> __vm_enough_memory: commitment overflow: ppid:150, pid:164, 
>> pages:62451
>> fork failed[count:0]: Cannot allocate memory
> 
> While I understand that fork failing due to overrcomit heuristic is non
> intuitive and I have seen people scratching heads due to this in the
> past I am not convinced this is a right approach to tackle the problem.

Dear Michal,
First, thank you so much for your review and comments.
I totally agree with you.

> First off, referencing pids is not really going to help much if process
> is short lived.

Yes, I agree with you.
But I think this is most important mainly for short lived processes 
itself.
Because, when this situation occurs, no one knows who could be the 
culprit.
However, user keeps dumping "ps" or "top" in background to reproduce 
once again.
At this time, we can easily match the pid, process-name (at least in 
most cases).

> Secondly, __vm_enough_memory is about any address space
> allocation. Why would you be interested in parent when doing mmap?
> 

Yes agree, we can remove ppid from here.
I thought it might be useful at least in case of fork (or short lived 
process).

> Last but not least _once is questionable as well. The first instance
> might happen early during the system lifetime and you will not learn
> about future failures so the overall point of debuggability is 
> seriously
> inhibited.
> 
> Maybe what you want is to report higher up the call chain (fork?) and
> have it ratelimited rather than _once? Or maybe just try to live with
> the confusing situation?
> 

Okay agree. I can change to pr_err_ratelimited.
In-fact, initially I thought to use ratelimited itself but then I 
thought
just once also should be fine at least.


Thanks,
Pintu
