Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED248283D28
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgJERPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:15:04 -0400
Received: from foss.arm.com ([217.140.110.172]:53424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgJERPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:15:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 891BB113E;
        Mon,  5 Oct 2020 10:15:03 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFEC23F66B;
        Mon,  5 Oct 2020 10:15:02 -0700 (PDT)
Date:   Mon, 5 Oct 2020 18:15:00 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Yun Hsiang <hsiang023167@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched/uclamp: release per-task uclamp control if
 user set to default value
Message-ID: <20201005171500.eztpptd76fotkwa6@e107158-lin.cambridge.arm.com>
References: <20200928082643.133257-1-hsiang023167@gmail.com>
 <8272de8d-9868-d419-e2bb-d5e2c0614b63@arm.com>
 <20201002053812.GA176142@ubuntu>
 <57e6b3d3-22cd-0533-cfe7-e689c7983fcc@arm.com>
 <87o8lg7gpi.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o8lg7gpi.derkling@matbug.net>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/20 18:58, Patrick Bellasi wrote:

[...]

> >> it can not go back to the initial state to let the module(group) control.
> >
> > In case A changes its values e.g. from 3a to 3b it will go back to be
> > controlled by /TG again (like it was when it had no user defined
> > values).
> 
> True, however it's also true that strictly speaking once a task has
> defined a per-task value, we will always aggregate/clamp that value wrt
> to TG and SystemWide value.
> 
> >> But the other tasks in the group will be affected by the group.
> 
> This is not clear to me.
> 
> All tasks in a group will be treated independently. All the tasks are
> subject to the same _individual_ aggregation/clamping policy.

I think the confusing bit is this check in uclamp_tg_restrict()

1085         uc_max = task_group(p)->uclamp[clamp_id];
1086         if (uc_req.value > uc_max.value || !uc_req.user_defined)
1087                 return uc_max;

If a task is !user_defined then it'll *inherit* the TG value. So you can end
up with 2 different behaviors based on that flag. I.e: if 2 tasks have their
util_min=0, but one is user_defined while the other isn't, the effective
uclamp value will look different for the 2 tasks.

IIUC, Yun wants to be able to reset this user_defined flag to re-enable this
inheritance behavior for a task. Which I agree with you, seems a sensible thing
to allow (via new sched_setattr() flag of course).

Thanks

--
Qais Yousef
