Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEBD2B1A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgKMMD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:03:26 -0500
Received: from foss.arm.com ([217.140.110.172]:36800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgKMLpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:45:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4E961042;
        Fri, 13 Nov 2020 03:45:32 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 485733F6CF;
        Fri, 13 Nov 2020 03:45:31 -0800 (PST)
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag
 to reset uclamp
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yun Hsiang <hsiang023167@gmail.com>,
        linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        kernel test robot <lkp@intel.com>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <20201110122108.GG2594@hirez.programming.kicks-ass.net>
 <f3b59aad-3d5d-039b-205d-024308b609a1@arm.com>
 <20201112144131.7gqglj435bs6otwm@e107158-lin.cambridge.arm.com>
 <dd1e4632-5f1f-e493-8dcf-2de7468fb53f@arm.com>
Message-ID: <131cb7b5-e400-11e1-8fc1-b6e8183f1a8d@arm.com>
Date:   Fri, 13 Nov 2020 12:45:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dd1e4632-5f1f-e493-8dcf-2de7468fb53f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2020 17:01, Dietmar Eggemann wrote:
> On 12/11/2020 15:41, Qais Yousef wrote:
>> On 11/11/20 18:41, Dietmar Eggemann wrote:
>>> On 10/11/2020 13:21, Peter Zijlstra wrote:
>>>> On Tue, Nov 03, 2020 at 10:37:56AM +0800, Yun Hsiang wrote:

[...]

>> If you or Yun would still like to send the patch to protect
>> SCHED_FLAG_UTIL_CLAMP and SCHED_FLAG_ALL with __kernel__ that'd be great.
> 
> Ah yes! Can add an extra patch for this when sending out the next version.

On second thought, why should we risk a change in UAPI? Since we're now
not introducing a new flag the meaning of SCHED_FLAG_ALL or
SCHED_FLAG_UTIL_CLAMP won't change.
