Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660761F7888
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgFLNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgFLNJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:09:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5BEC03E96F;
        Fri, 12 Jun 2020 06:09:54 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jjjRQ-0003yU-4A; Fri, 12 Jun 2020 15:09:52 +0200
Date:   Fri, 12 Jun 2020 15:09:52 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zanussi@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH RT 3/4] tasklet: Fix UP case for tasklet CHAINED state
Message-ID: <20200612130952.wzyzebdc2wxahxkh@linutronix.de>
References: <cover.1591898986.git.zanussi@kernel.org>
 <2262ed0571ef9c2f24752189b55c965ce9c16d2f.1591898986.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2262ed0571ef9c2f24752189b55c965ce9c16d2f.1591898986.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-11 13:10:16 [-0500], zanussi@kernel.org wrote:
> commit 62d0a2a30cd0 (tasklet: Address a race resulting in
> double-enqueue) addresses a problem that can result in a tasklet being
> enqueued on two cpus at the same time by combining the RUN flag with a
> new CHAINED flag, and relies on the combination to be present in order
> to zero it out, which can never happen on (!SMP and !PREEMPT_RT_FULL)
> because the RUN flag is SMP/PREEMPT_RT_FULL-only.
> 
> So make sure the above commit is only applied for the SMP ||
> PREEMPT_RT_FULL case.
> 
> Fixes: 62d0a2a30cd0 ("tasklet: Address a race resulting in double-enqueue")
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> Reported-by: Ramon Fried <rfried.dev@gmail.com>
> Tested-By: Ramon Fried <rfried.dev@gmail.com>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
