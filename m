Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF0B292915
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgJSOOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:14:36 -0400
Received: from foss.arm.com ([217.140.110.172]:58712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgJSOOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:14:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3128D6E;
        Mon, 19 Oct 2020 07:14:35 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25BAE3F66E;
        Mon, 19 Oct 2020 07:14:33 -0700 (PDT)
Subject: Re: [PATCH 3/2] sched/cpupri: Remap CPUPRI_NORMAL to MAX_RT_PRIO-1
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200922083934.19275-1-dietmar.eggemann@arm.com>
 <20201014194858.GC2974@worktop.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <20388bee-9534-3ca0-4916-0bd0b9852189@arm.com>
Date:   Mon, 19 Oct 2020 16:14:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014194858.GC2974@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 21:48, Peter Zijlstra wrote:

[...]

> +	switch (prio) {
> +	case CPUPRI_INVALID:
> +		cpupri = CPUPRI_INVALID;	/* -1 */
> +		break;
> +
> +	case 0...98:

kernel/sched/cpupri.c:54:7: error: too many decimal points in number
   54 |  case 0...98:
      |       ^~~~~~

There need to be spaces around the ellipses.

Otherwise LGTM.
