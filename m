Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514A727A57A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 04:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgI1Cl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 22:41:59 -0400
Received: from z5.mailgun.us ([104.130.96.5]:23387 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgI1Cl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 22:41:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601260918; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=FHvOBtS3hiLWcILb3F3d0F/UK1XcfgOMNZG/nkc4vlw=;
 b=kyMMeimHiOBjWfTdUt6j9EWKl+VP9UMMQC9Y1gzWFqpzv7lfsm3na9NjjQD9kO7vkG4r3GrW
 piJwf7L79n4TeOa5759fuwkny0bN1SKfuyw8+/hcpHlQ6ywqnxFHC2bESAXI0IB4WDkE1WQj
 QG5cO8MrEZyHc1IU86+mqAt9xa0=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f714d6ba7eb63c698bd9df6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 02:41:47
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E49E8C433CB; Mon, 28 Sep 2020 02:41:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF197C433C8;
        Mon, 28 Sep 2020 02:41:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 27 Sep 2020 19:41:45 -0700
From:   psodagud@codeaurora.org
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, qais.yousef@arm.com,
        mingo@kernel.org, cai@lca.pw, tyhicks@canonical.com, arnd@arndb.de,
        rameezmustafa@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] measure latency of cpu hotplug path
In-Reply-To: <20200924105823.0e11f2e4@oasis.local.home>
References: <1600904266-102397-1-git-send-email-psodagud@codeaurora.org>
 <20200924083414.GB1362448@hirez.programming.kicks-ass.net>
 <20200924105823.0e11f2e4@oasis.local.home>
Message-ID: <75eca1a41e49a199d7aa72be8c5221b3@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-24 07:58, Steven Rostedt wrote:
> On Thu, 24 Sep 2020 10:34:14 +0200
> peterz@infradead.org wrote:
> 
>> On Wed, Sep 23, 2020 at 04:37:44PM -0700, Prasad Sodagudi wrote:
>> > There are all changes related to cpu hotplug path and would like to seek
>> > upstream review. These are all patches in Qualcomm downstream kernel
>> > for a quite long time. First patch sets the rt prioity to hotplug
>> > task and second patch adds cpuhp trace events.
>> >
>> > 1) cpu-hotplug: Always use real time scheduling when hotplugging a CPU
>> > 2) cpu/hotplug: Add cpuhp_latency trace event
>> 
>> Why? Hotplug is a known super slow path. If you care about hotplug
>> latency you're doing it wrong.
Hi Peter,

[PATCH 1/2] cpu/hotplug: Add cpuhp_latency trace event -
1)	Tracing of the cpuhp operation is important to find whether upstream 
changes or out of tree modules(or firmware changes) caused latency 
regression or not.
2)	Secondary cpus are hotplug out during the device suspend and hotplug 
in during the resume.
3)	firmware(psci calls handling from firmware) changes impact need to be 
tested right?
4)	cpu hotplug framework(CPUHP_AP_ONLINE_DYN) dynamic callbacks may 
impact the hotplug latency.


[PATCH 2/2] cpu-hotplug: Always use real time scheduling when  
hotplugging a CPU –

CPU hotplug operation is stressed and while stress testing with full 
load on the system following problem is observed.
CPU hotplug operations take place in preemptible context. This leaves 
the hotplugging thread at the mercy of overall system load and CPU
availability. If the hotplugging thread does not get an opportunity to 
execute after it has already begun a hotplug operation, CPUs can
end up being stuck in a quasi online state. In the worst case a CPU can 
be stuck in a state where the migration thread is parked while
another task is executing and changing affinity in a loop. This 
combination can result in unbounded execution time for the running
task until the hot plugging thread gets the chance to run to complete 
the hotplug operation.

-Thanks, Prasad

> 
> I'd like to know the answer to Peter's question too. Why?
> 
> -- Steve
