Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6321B46CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 16:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgDVOG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 10:06:58 -0400
Received: from foss.arm.com ([217.140.110.172]:50436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVOG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:06:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EB9D30E;
        Wed, 22 Apr 2020 07:06:58 -0700 (PDT)
Received: from bogus (unknown [10.37.12.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F2583F68F;
        Wed, 22 Apr 2020 07:06:56 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:06:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, daniel.lezcano@linaro.org
Subject: Re: [PATCH 06/23] sched,psci: Convert to sched_set_fifo*()
Message-ID: <20200422140653.GG24150@bogus>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.574539982@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422112831.574539982@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:27:25PM +0200, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> Effectively changes prio from 99 to 50.
> 
> XXX this thing is horrific, it basically open-codes a stop-machine and
> idle.
> 
> Cc: daniel.lezcano@linaro.org
> Cc: sudeep.holla@arm.com

Tested the PSCI checker pulling the entire series. Continues to work :)

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
