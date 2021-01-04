Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1DE2E9677
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbhADN5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADN5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:57:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03DDC061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 05:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BgK+tHIAID6FnwyvohuHOU0I3PpkqQNmrVg98TE0ETQ=; b=dWBxmjF9jwT4GAQBFonWa1cSRV
        0OYJ3p4ypkH7Lpc/QzdG3Yh3orumStDYkiqkr+HlIk0/1dFjY3r+9gy9sKUw1xH/5j5iGNb130Oy6
        jyd7dyi2BMh/3XEUW7G6F2iL/Z6Mfbz36hTqGn351U5f/OfX/wJYkPzzKZgmBqusGZ/rYC0MzFu5c
        ttsrZCxUcug8wvVDMtvXOoV9k227T/YJqKyxsV7gWdoGg8zkpheQctc3yAhoVn+AP5UOUIzNxZEKM
        HP8h9rO/J3pmkcBoqy4WxIpmu0bjHFGFsMKOuu6gCzfrKaIZsh1nSbo/Pz5zjKv3bEKS030/VmYT4
        V9ecTZJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwQLs-000732-FW; Mon, 04 Jan 2021 13:56:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3601C300446;
        Mon,  4 Jan 2021 14:56:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F388920248726; Mon,  4 Jan 2021 14:56:49 +0100 (CET)
Date:   Mon, 4 Jan 2021 14:56:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -tip V3 3/8] workqueue: introduce wq_online_cpumask
Message-ID: <20210104135649.GO3021@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <20201226025117.2770-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226025117.2770-4-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 10:51:11AM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> wq_online_cpumask is the cached result of cpu_online_mask with the
> going-down cpu cleared.

You can't use cpu_active_mask ?
