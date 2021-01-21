Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F6C2FED0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbhAUOhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:37:41 -0500
Received: from foss.arm.com ([217.140.110.172]:38310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731525AbhAUOh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:37:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C46614FF;
        Thu, 21 Jan 2021 06:36:42 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E3BC3F68F;
        Thu, 21 Jan 2021 06:36:40 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        cai@redhat.com, vincent.donnefort@arm.com, decui@microsoft.com,
        paulmck@kernel.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, tj@kernel.org, peterz@infradead.org
Subject: Re: [PATCH -v3 0/9] sched: Fix hot-unplug regression
In-Reply-To: <20210121101702.402798862@infradead.org>
References: <20210121101702.402798862@infradead.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Jan 2021 14:36:38 +0000
Message-ID: <jhj5z3qmk5l.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/21 11:17, Peter Zijlstra wrote:
> Hi,
>
> Some cautious optimism lets me post v3 of these patches. They (knock on wood)
> fix the regression introduced by commit:
>
>   1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")
>
> These patches survived overnight runs for both me and Valentin, but I'll let it
> run for at least another 12 hours before committing these patches.
>
> New in this version is patch #7.
>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

And, providing the tests keep sailing smoothly:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

> Much thanks to Valentin for his continued support and debugging efforts.

Happy to ~get headaches~ help!
