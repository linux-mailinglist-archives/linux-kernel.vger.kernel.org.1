Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F27728ECEC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 08:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgJOGHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 02:07:49 -0400
Received: from z5.mailgun.us ([104.130.96.5]:12678 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgJOGHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 02:07:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602742069; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Date: Message-ID: Subject: From: Cc: To: Sender;
 bh=3YpwQ8vNPH2kYO0S+h4JavGJgn0OjQHCMmUoLuwkYtk=; b=Ycd/WSMEBH0YGp8P09DBjGqoglVb5TqxnvQacEoqpxyjQOeRfXmE1EiRNYnKGYlO4lsPYNKZ
 zmvqnzKM+THBBi43zlh5PsWL5fMA0lYpBFyJHUrPld9d3IAABYcH5ffp50ekma+Ooh2ajhmw
 a2nujSQAexY1z9gFFpw74bf4BeY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f87e710d6d00c7a9edef900 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Oct 2020 06:07:12
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7420CC433CB; Thu, 15 Oct 2020 06:07:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.102] (unknown [49.206.34.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D5D5C433C9;
        Thu, 15 Oct 2020 06:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D5D5C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
To:     james.morse@arm.com
Cc:     linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: Queries on ARM SDEI Linux kernel code
Message-ID: <af00fba0-7d1f-6655-906d-1e6a5ae45ede@codeaurora.org>
Date:   Thu, 15 Oct 2020 11:37:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Have few queries on ARM SDEI Linux code. Queries are listed below; can 
you please help provide your insights on these?

1. Looks like interrupt bind interface (SDEI_1_0_FN_SDEI_INTERRUPT_BIND) 
is not available for clients to use; can you please share information on
why it is not provided?

While trying to dig information on this, I saw  that [1] says:
   Now the hotplug callbacks save  nothing, and restore the OS-view of 
registered/enabled. This makes bound-interrupts harder to work with.

Based on this comment, the changes from v4 [2], which I could understand 
is, cpu down path does not save the current event enable status, and we 
rely on the enable status `event->reenable', which is set, when 
register/unregister, enable/disable calls are made; this enable status 
is used during cpu up path, to decide whether to reenable the interrupt.

Does this make, bound-interrupts harder to work with? how? Can you 
please explain? Or above save/restore is not the reason and you meant 
something else?

Also, does shared bound interrupts also have the same problem, as 
save/restore behavior was only for private events?

2. SDEI_EVENT_SIGNAL api is not provided? What is the reason for it? Its 
handling has the same problems, which are there for bound interrupts?

Also, if it is provided, clients need to register event 0 ? Vendor 
events or other event nums are not supported, as per spec.

3. Can kernel panic() be triggered from sdei event handler? Is it a safe
operation? The spec says, synchronous exceptions should not be 
triggered; I think panic won't do it; but anything which triggers a WARN
or other sync exception in that path can cause undefined behavior. Can 
you share your thoughts on this?

"The handler code should not enable asynchronous exceptions by clearing 
any of the PSTATE.DAIF bits, and should not cause synchronous exceptions 
to the client Exception level."


[1] https://lwn.net/Articles/740817/
[2] https://www.spinics.net/lists/kvm-arm/msg27784.html

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
