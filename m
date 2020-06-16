Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5BC1FBE15
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 20:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgFPSdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 14:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgFPSdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:33:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6432098B;
        Tue, 16 Jun 2020 18:33:30 +0000 (UTC)
Date:   Tue, 16 Jun 2020 14:33:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lichao Liu <liulichao@loongson.cn>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Don't active rt throtting when no running cfs
 task
Message-ID: <20200616143329.064f99e2@oasis.local.home>
In-Reply-To: <20200616170711.GZ2531@hirez.programming.kicks-ass.net>
References: <20200616123729.153430-1-liulichao@loongson.cn>
        <20200616095027.1a2048d0@oasis.local.home>
        <20200616140158.GY2531@hirez.programming.kicks-ass.net>
        <20200616105900.5cb0671d@oasis.local.home>
        <20200616170711.GZ2531@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 19:07:11 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > But we've been saying that for years now.  
> 
> Hey, I even coded most of it, but clearly nobody cares about this enough
> to finish it ... 

Or nobody who knows enough (and has enough time) to do so cares ;-)

-- Steve
