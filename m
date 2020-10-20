Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2F3293FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436583AbgJTPjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:39:35 -0400
Received: from foss.arm.com ([217.140.110.172]:53342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731563AbgJTPje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:39:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A3071FB;
        Tue, 20 Oct 2020 08:39:34 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 740073F66B;
        Tue, 20 Oct 2020 08:39:32 -0700 (PDT)
Subject: Re: [PATCH 4/2] sched/cpupri: Add CPUPRI_HIGHER
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200922083934.19275-1-dietmar.eggemann@arm.com>
 <20201014195437.GD2974@worktop.programming.kicks-ass.net>
 <17c8a9b5-b63a-1a1a-f11b-5e00c2a6ad34@arm.com>
 <20201020073710.GZ2611@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <27677325-43c6-2a18-05d5-f9cd137772d5@arm.com>
Date:   Tue, 20 Oct 2020 17:39:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020073710.GZ2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2020 09:37, Peter Zijlstra wrote:
> On Mon, Oct 19, 2020 at 04:15:01PM +0200, Dietmar Eggemann wrote:
>> On 14/10/2020 21:54, Peter Zijlstra wrote:

[...]

> Maybe I've not had enough wake-up juice, but I can't seem to locate
> this.

Sorry, I was commenting on my own debug code ;-)
