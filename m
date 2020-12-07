Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAB42D1162
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLGNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:07:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgLGNHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:07:22 -0500
Date:   Mon, 7 Dec 2020 14:06:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607346402;
        bh=/S4wAAJphnrhh2Uzis7jKmvU2S4fC/taQwaYkyRT5MY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVJ+QEd/YpHRqtQbJ3Y6WBR14e3iG6y2rf3HNSM/zuGGEPdnoWq8v+HflJL1piOQO
         jzLABBTXfiteouQl8DLeiHfPdvf0lvciH/vjCZCYv2bOE+Vd8gi2HHy4jRUq5/oim6
         SNyvBBtrn2Ar44gu9j9jeL3qPt/yhExcc0Gy+NdX++4bDqijLqQ0/lSO66iPOsS+Hj
         mfmhX0PKy80KafSaHsmgZ8efp0cLoj6JYCCiPAhD0JuJ85zU2fUNkw6zs5i1mHd2RS
         ZhpkbzIQyw6vq+EggbGqjMj2uNrkRZGmX7CPBvkDnHMLBHW1iTFjVcrR4CvARaKYNf
         YLHFvN0q5ZQfQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 1/9] softirq: Add RT specific softirq accounting
Message-ID: <20201207130639.GB122233@lothringen>
References: <20201204170151.960336698@linutronix.de>
 <20201204170804.765109984@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204170804.765109984@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:01:52PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> RT requires the softirq processing and local bottomhalf disabled regions to
> be preemptible. Using the normal preempt count based serialization is
> therefore not possible because this implicitely disables preemption.
> 
> RT kernels use a per CPU local lock to serialize bottomhalfs. As
> local_bh_disable() can nest the lock can only be acquired on the outermost
> invocation of local_bh_disable() and released when the nest count becomes
> zero. Tasks which hold the local lock can be preempted so its required to
> keep track of the nest count per task.
> 
> Add a RT only counter to task struct and adjust the relevant macros in
> preempt.h.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
