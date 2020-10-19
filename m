Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46541292155
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 05:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgJSDCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 23:02:46 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:17173 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbgJSDCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 23:02:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603076564; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=88Ss3P2QgWnP90/eGtlLeQElpBWcpaopaAFpncLldrQ=;
 b=LSVWnmH4REAfbJG0mUCMNfPnBXQDIyHmGBgoJjaB9pB1h384GIYDZa9OW3MHmjTxJDDVriF1
 QxX2ncD3k6zqnW1N3FkMjKoMXQ3+NVnMm4lxnEEM9mp27jKX3xKcWe69rlyGabq8PAtBQIXq
 K/jIwLs3XKAlIXgWpeYl1UyD1B0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f8d01cc3711fec7b1d83eb6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 19 Oct 2020 03:02:36
 GMT
Sender: pintu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 47CB4C433FF; Mon, 19 Oct 2020 03:02:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pintu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47B40C433CB;
        Mon, 19 Oct 2020 03:02:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Oct 2020 08:32:34 +0530
From:   pintu@codeaurora.org
To:     Michal Hocko <mhocko@suse.com>, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, pintu.ping@gmail.com
Subject: Re: [PATCH] mm/util.c: Add error logs for commitment overflow
In-Reply-To: <20201005072011.GP4555@dhcp22.suse.cz>
References: <1601639861-32171-1-git-send-email-pintu@codeaurora.org>
 <20201002121726.GF4555@dhcp22.suse.cz>
 <adaf346febe6bb6fbdcedb8709e35bcb@codeaurora.org>
 <20201005072011.GP4555@dhcp22.suse.cz>
Message-ID: <0e9255fcac61ae6ce90bbdde6421b148@codeaurora.org>
X-Sender: pintu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-05 12:50, Michal Hocko wrote:
> On Fri 02-10-20 21:53:37, pintu@codeaurora.org wrote:
>> On 2020-10-02 17:47, Michal Hocko wrote:
>> 
>> > > __vm_enough_memory: commitment overflow: ppid:150, pid:164,
>> > > pages:62451
>> > > fork failed[count:0]: Cannot allocate memory
>> >
>> > While I understand that fork failing due to overrcomit heuristic is non
>> > intuitive and I have seen people scratching heads due to this in the
>> > past I am not convinced this is a right approach to tackle the problem.
>> 
>> Dear Michal,
>> First, thank you so much for your review and comments.
>> I totally agree with you.
>> 
>> > First off, referencing pids is not really going to help much if process
>> > is short lived.
>> 
>> Yes, I agree with you.
>> But I think this is most important mainly for short lived processes 
>> itself.
>> Because, when this situation occurs, no one knows who could be the 
>> culprit.
> 
> Pid will not tell you much for those processes, right?
> 
>> However, user keeps dumping "ps" or "top" in background to reproduce 
>> once
>> again.
> 
> I do not think this would be an effective way to catch the problem.
> Especially with _once reporting. My experience with these reports is
> that a reporter notices a malfunctioning (usually more complex)
> workload. In some cases ENOMEM from fork is reported into the log by 
> the
> userspace.
> 
> For others it is strace -f that tells us that fork is failing and a
> test with OVERCOMMIT_ALWAYS usually confirms the theory that this is
> the culprit. But a rule of thumb is that it is almost always overcommit
> to blame. Why? An undocumented secret is that ENOMEM resulting from an
> actual memory allocation in the fork/clone path is close to impossible
> because kernel does all it can to satisfy them (an even invokes OOM
> killer). There are exceptions (e.g. like high order allocation) but
> those should be very rare in that path.
> 
>> At this time, we can easily match the pid, process-name (at least in 
>> most
>> cases).
> 
> Maybe our definitions of short lived processes differ but in my book
> those are pretty hard to catch in flight.
> 
>> > Secondly, __vm_enough_memory is about any address space
>> > allocation. Why would you be interested in parent when doing mmap?
>> >
>> 
>> Yes agree, we can remove ppid from here.
>> I thought it might be useful at least in case of fork (or short lived
>> process).
> 
> I suspect you have missed my point here. Let me clarify a bit more.
> __vm_enough_memory is called from much more places than fork.
> Essentially any mmap, brk etc are going though this. This is where
> parent pid certainly doesn't make any sense. In fork this is a 
> different
> case because your forked process pid on its own doesn't make much sense
> as it is going to die very quickly anyway. This is when parent is 
> likely
> a more important information.
> 
> That being said the content really depends on the specific path and 
> that
> suggestes that you are trying to log at a wrong layer.
> 
> Another question is whether we really need a logging done by the 
> kernel.
> Ratelimiting would be tricky to get right and we do not want to allow 
> an
> easy way to swamp logs either.
> As already mentioned ENOMEM usually means overcommit failure. Maybe we
> want to be more explicit this in the man page?


Thank you so much for your feedback.
First of all I am sorry for my delayed response.

As I understand, the conclusion here is that:
a) The pr_err_once is not helpful and neither pr_err_ratelimited ?
Even with this below logs:
+ pr_err_ratelimited("vm memory overflow: pid:%d, name: %s, 
pages:%ld\n",
+     current->pid, current->comm, pages);

b) This can be invoked from many places so we are adding the logging at 
wrong layer?
If so, any other better places which can be explored?

c) Adding logging at kernel layer is not the right approach to tackle 
this problem ?

d) Another thing we can do is, update the man page with more detailed 
information about this commitment overflow ?

e) May be returning ENOMEM (Cannot allocate memory) from VM path is 
slightly misleading for user space folks even though there are enough 
memory?
=> Either we can introduce ENOVMEM (Cannot create virtual memory 
mapping)
=> Or, update the documentation with approach to further debug this 
issue?

If there are any more suggestions to easily catch this issue please let 
us know, we can explore further.


Thanks,
Pintu
