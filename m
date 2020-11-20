Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CDE2BAF59
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgKTPxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:53:54 -0500
Received: from foss.arm.com ([217.140.110.172]:51500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbgKTPxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:53:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07B6111D4;
        Fri, 20 Nov 2020 07:53:53 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3BA93F70D;
        Fri, 20 Nov 2020 07:53:51 -0800 (PST)
References: <20201118180030.22764-1-valentin.schneider@arm.com> <20201118180030.22764-2-valentin.schneider@arm.com> <613d0854-597e-6ed7-05ca-70310c7b887d@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2] x86/intel_rdt: Check monitor group vs control group membership earlier
In-reply-to: <613d0854-597e-6ed7-05ca-70310c7b887d@arm.com>
Date:   Fri, 20 Nov 2020 15:53:49 +0000
Message-ID: <jhjv9e0uir6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

On 20/11/20 14:53, James Morse wrote:
> Hi Valentin,
>
> On 18/11/2020 18:00, Valentin Schneider wrote:
>> A task can only be moved between monitor groups if both groups belong to
>> the same control group. This is checked fairly late however: by that time
>> we already have appended a task_work() callback.
>
> (is that a problem? It's needed to do the kfree())
>
>
>> Check the validity of the move before getting anywhere near task_work
>> callbacks.
>
> This saves the kzalloc()/task_work_add() if it wasn't going to be necessary.
>

Right, to hopefully better point it out:

In such cases (invalid move), __rdtgroup_move_task() would trigger a
move_myself() task_work callback without updating {closid, rmid}.
Given nothing changed (barring concurrent updates), move_myself() won't do
any useful work.

The task_work_add() and associated alloc could thus be entirely avoided.

> Reviewed-by: James Morse <james.morse@arm.com>
>

Thanks!

>
> Thanks,
>
> James

