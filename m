Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449CB28B5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388835AbgJLNRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:17:52 -0400
Received: from foss.arm.com ([217.140.110.172]:45322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387906AbgJLNRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:17:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28B05D6E;
        Mon, 12 Oct 2020 06:17:51 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DB4E3F66B;
        Mon, 12 Oct 2020 06:17:50 -0700 (PDT)
References: <20200424135657.32519-1-valentin.schneider@arm.com> <20200603170511.GA23722@bogus> <jhjimg8hwvf.mognet@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] firmware/psci: PSCI checker cleanup
In-reply-to: <jhjimg8hwvf.mognet@arm.com>
Date:   Mon, 12 Oct 2020 14:17:44 +0100
Message-ID: <jhj7drveg7b.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 03/06/20 18:39, Valentin Schneider wrote:
> On 03/06/20 18:05, Sudeep Holla wrote:
>> On Fri, Apr 24, 2020 at 02:56:55PM +0100, Valentin Schneider wrote:
>>> Hi folks,
>>>
>>> This is a small cleanup of the PSCI checker following Peter's objections
>>> to its homegrown do_idle() implementation. It is based on his
>>> sched_setscheduler() unexport series at [1].
>>>
>>> I've never really used the thing before, but it still seems to behave
>>> correctly on my Juno r0 & HiKey960.
>>>
>>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Thanks!
>
> AIUI the plan is to have the base in for the following version, so we
> can wait until then - or I can rebase this on top of mainline, and
> whoever will be on the receiving end of the merge conflict will be
> slightly annoyed :-)
>
> I'm in no particular rush, and this isn't very hot code, so up to you.
>

The sched_setscheduler() series is in 5.9. Patches apply cleanly atop 5.9,
and I double-checked on my Juno that they still actually work :-)

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
