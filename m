Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF1261F2C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbgIHUAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:00:09 -0400
Received: from foss.arm.com ([217.140.110.172]:55912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730484AbgIHPfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59AD8169E;
        Tue,  8 Sep 2020 08:17:26 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ED443F73C;
        Tue,  8 Sep 2020 08:17:25 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:17:22 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, vincent.donnefort@arm.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20200908151722.b7ai2bpgvixlimz3@e107158-lin.cambridge.arm.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200907104845.6rust2lf2o3d5gmq@e107158-lin.cambridge.arm.com>
 <20200907111320.GP2674@hirez.programming.kicks-ass.net>
 <20200907145155.fsmeygi4fiypikzk@e107158-lin.cambridge.arm.com>
 <cbad58a5-758b-ded9-ed41-1be74e8663a6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbad58a5-758b-ded9-ed41-1be74e8663a6@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/20 13:17, Dietmar Eggemann wrote:
> On 07/09/2020 16:51, Qais Yousef wrote:
> > On 09/07/20 13:13, peterz@infradead.org wrote:
> >> On Mon, Sep 07, 2020 at 11:48:45AM +0100, Qais Yousef wrote:
> >>> IMHO the above is a hack. Out-of-tree modules should rely on public headers and
> >>> exported functions only. What you propose means that people who want to use
> >>> these tracepoints in meaningful way must have a prebuilt kernel handy. Which is
> >>> maybe true for us who work in the embedded world. But users who run normal
> >>> distro kernels (desktop/servers) will fail to build against
> >>
> >> But this isn't really aimed at regular users. We're aiming this at
> >> developers (IIUC) so I dont really see this as a problem.
> 
> This is what I thought as well. All these helpers can be coded directly
> in these tracepoint-2-traceevent (tp-2-te) converters. As long as they
> are build from within kernel/sched/ there is no issue with the export
> via kernel/sched/sched.h. Otherwise this little trick would be necessary.
> But since it is a tool for developers I guess we can assume that they
> can build it from within kernel/sched/.

I think this will reduce the usefulness of these tracepoints. But if you really
want to remove them, I am certainly not strongly attached to them and they were
meant to be removable anyway. So fine by me :-)

Cheers

--
Qais Yousef
