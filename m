Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519632B412D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgKPKbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:31:16 -0500
Received: from foss.arm.com ([217.140.110.172]:37356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbgKPKbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:31:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B3AA31B;
        Mon, 16 Nov 2020 02:31:15 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 736E33F718;
        Mon, 16 Nov 2020 02:31:14 -0800 (PST)
References: <a1fd0d9c6c8cd90a74879b61467ae48d@natalenko.name> <jhj3619y63v.mognet@arm.com> <41d6aca71c6a52df8437cdb7b4a1b1c4@natalenko.name>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org
Subject: Re: WARNING at kernel/sched/core.c:2013 migration_cpu_stop+0x2e3/0x330
In-reply-to: <41d6aca71c6a52df8437cdb7b4a1b1c4@natalenko.name>
Date:   Mon, 16 Nov 2020 10:31:12 +0000
Message-ID: <jhjzh3hwq33.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/11/20 10:27, Oleksandr Natalenko wrote:
> Hi.
[...]
> Not sure whether the check is legitimate, but FWIW I've managed to put a 
> test task [1] (it spawns a lot of threads and applies affinity) into a 
> permanent unkillable D state here:
>
> ```
> [<0>] affine_move_task+0x2d3/0x620
> [<0>] __set_cpus_allowed_ptr+0x164/0x210
> [<0>] sched_setaffinity+0x21a/0x300
> [<0>] __x64_sys_sched_setaffinity+0x8c/0xc0
> [<0>] do_syscall_64+0x33/0x40
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> ```
[...]
>
> I'm not positive about this being directly related to the original 
> report, but I think it is still worth mentioning.
>

Aye, thanks, that one should be fixed by:

https://lore.kernel.org/r/20201113112414.2569-1-valentin.schneider@arm.com

> Thanks.
>
> [1] https://gitlab.com/post-factum/burn_scheduler

