Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57E428F099
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgJOLCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgJOLCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:02:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C535C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 04:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cZ5KJwl3enbqMiNNlzxPmSSpX4m/HBPTKxa1fJqKL4k=; b=Qc3nYm0tanXxpEeRClitL08Zit
        znc3dHafZITzDaTZt7nsIU+z2YKudRXlemhp4LpzxMKzZdbUeNJMEnBz91SlTWERTkAi5vo80gQcF
        KXg9vFdp7RQ6NzcnLnpKVLcYsyuApicGDyFYlpZM5hPMc67pOpmBkIxPrByu0GsVmF3o/7vyzszZ2
        rw5cN3nbC6vyMJvXc9LunpxkihueyfUtzgkgBlD9nccy1qISdHKbQ+tE0yKE8POWCQLJ5iHN1nF4A
        d9UIyLkmUuF/40unS0M9tLy9yd/G82/cP8cqnZ3Af4yD40pGEyL0Y88F/MxW5dxpd7Ffe7MCQT/zK
        jcDcpgMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT11t-0007WP-5S; Thu, 15 Oct 2020 11:02:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2ABA300446;
        Thu, 15 Oct 2020 13:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4B1D20325ECE; Thu, 15 Oct 2020 13:02:39 +0200 (CEST)
Date:   Thu, 15 Oct 2020 13:02:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     qianjun.kernel@gmail.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 1/1] Sched/fair: Improve the accuracy of sched_stat_wait
 statistics
Message-ID: <20201015110239.GD2611@hirez.programming.kicks-ass.net>
References: <20201015064846.19809-1-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015064846.19809-1-qianjun.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 02:48:46PM +0800, qianjun.kernel@gmail.com wrote:
> From: jun qian <qianjun.kernel@gmail.com>
> 
> When the sched_schedstat changes from 0 to 1, some sched se maybe
> already in the runqueue, the se->statistics.wait_start will be 0.
> So it will let the (rq_of(cfs_rq)) - se->statistics.wait_start)
> wrong. We need to avoid this scenario.
> 
> Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> Reviewed-by: Yafang Shao <laoar.shao@gmail.com>

Thanks!
