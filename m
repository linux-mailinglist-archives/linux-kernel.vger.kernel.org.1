Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817E52D9FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440988AbgLNSvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502256AbgLNRhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:37:40 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15898C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/SJj4wER2TKg29NFErPAvXmD6OI8mU1xoUGziD0N4+M=; b=aSgKKimWlCm49rjq8CUtMaJtKD
        2kn1flWujt+zoCH+OzOQPcbrMwQh4gnok7BmSdp984ulqFV9/kDej/RddC5JmmI//GvBCQmcAhxdH
        WZ8wbWq5lbaZBYmYG0IIOy67neuuroEogXPcm1nEOwjYV7O8OJ/G+VsnYy9jcVt5YcRAOq2dixycy
        /zWhsqiv+SDwhxq7d24NjPmQMKMmqczXtybXwwK02DJIbUxs5C5idI9LgRNdlC2r9s2a1zxcbI0yH
        fnO6F5TlbJgxI1C8S/5KQrrsEP+D92A2SAA3ST0JBd9BXHDOEZbgJ8Nkbq4J9w/eoJMaQPMLdln4/
        fvoejJOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kormC-00054Q-Ba; Mon, 14 Dec 2020 17:36:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ADAF43010CF;
        Mon, 14 Dec 2020 18:36:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7411A2C6E01DA; Mon, 14 Dec 2020 18:36:46 +0100 (CET)
Date:   Mon, 14 Dec 2020 18:36:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 00/10] workqueue: break affinity initiatively
Message-ID: <X9eirnnrD/+VqqEo@hirez.programming.kicks-ass.net>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214155457.3430-1-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 11:54:47PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> 06249738a41a ("workqueue: Manually break affinity on hotplug")
> said that scheduler will not force break affinity for us.
> 
> But workqueue highly depends on the old behavior. Many parts of the codes
> relies on it, 06249738a41a ("workqueue: Manually break affinity on hotplug")
> is not enough to change it, and the commit has flaws in itself too.
> 
> We need to thoroughly update the way workqueue handles affinity
> in cpu hot[un]plug, what is this patchset intends to do and
> replace the Valentin Schneider's patch [1].

So the actual problem is with per-cpu kthreads, the new assumption is
that hot-un-plug will make all per-cpu kthreads for the dying CPU go
away.

Workqueues violated that. I fixed the obvious site, and Valentin's patch
avoids workqueues from quickly creating new ones while we're not
looking.

What other problems did you find?
