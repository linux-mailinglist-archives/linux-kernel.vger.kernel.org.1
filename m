Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579412764AB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 01:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgIWXiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 19:38:09 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:51996 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgIWXiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 19:38:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600904288; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=gUzIjt7P4SHEi06/OHoGDRBOZQ31S29WQXIO8JR8Ev4=; b=TosuF63mwpG29nYF18830OmlRn2RQFc3hDkbY9DVt4XDV3DRHu49YkIZsLK4OWSIqBGWVjYc
 mxr0l/X6gIZxPW5GaYEfIE9y9TzacaPuIBhOgfqSRvwn8CZlum+pqNf7ZHMq6IxGQE3QKJBI
 ajTO1gc9LUll0Lo+OfaKMF8ylOs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f6bdc56429250c1dda4e95d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Sep 2020 23:37:58
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C7051C433F1; Wed, 23 Sep 2020 23:37:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8777DC433C8;
        Wed, 23 Sep 2020 23:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8777DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     rostedt@goodmis.org, tglx@linutronix.de, qais.yousef@arm.com,
        peterz@infradead.org, mingo@kernel.org, cai@lca.pw,
        tyhicks@canonical.com, arnd@arndb.de
Cc:     rameezmustafa@codeaurora.org, linux-kernel@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH 0/2] measure latency of cpu hotplug path
Date:   Wed, 23 Sep 2020 16:37:44 -0700
Message-Id: <1600904266-102397-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are all changes related to cpu hotplug path and would like to seek
upstream review. These are all patches in Qualcomm downstream kernel
for a quite long time. First patch sets the rt prioity to hotplug
task and second patch adds cpuhp trace events.

1) cpu-hotplug: Always use real time scheduling when hotplugging a CPU
2) cpu/hotplug: Add cpuhp_latency trace event

Example logs:-  
cpu online -
         cpuhp/4-200   [004] ....   223.891886: cpuhp_enter: cpu: 0004 target: 213 step: 212 (sched_cpu_activate)
         cpuhp/4-200   [004] ....   223.891894: cpuhp_exit:  cpu: 0004  state: 212 step: 212 ret: 0
              sh-176   [000] ....   223.891912: cpuhp_exit:  cpu: 0004  state: 213 step:  86 ret: 0
              sh-176   [000] ....   223.891915: cpuhp_latency:  cpu:4 state:online latency:3874 USEC ret: 0

cpu offline - 
              sh-176   [000] ....   265.193490: cpuhp_exit:  cpu: 0004  state:   2 step:   2 ret: 0
              sh-176   [000] ....   265.193494: cpuhp_latency:  cpu:4 state:offline latency:57431 USEC ret: 0


Prasad Sodagudi (1):
  cpu/hotplug: Add cpuhp_latency trace event

Syed Rameez Mustafa (1):
  cpu-hotplug: Always use real time scheduling when hotplugging a CPU

 include/trace/events/cpuhp.h | 29 +++++++++++++++++++++++++
 kernel/cpu.c                 | 50 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

