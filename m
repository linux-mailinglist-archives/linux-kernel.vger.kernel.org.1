Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA6827AA9A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgI1JWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1JWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:22:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A752C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vyVUoH6nO0IVpbXsn2T2AaiGIjQmj8vnetRytde1IBY=; b=Cd2f88d00pAiW209s/WpH/WGDI
        4p3RZL4bD4XX+UAwln7hgeecdmeZc0ieBOLoEfkUdtPbWumKESLOh+fzVVoG+MrUYu0mU9et9PhpO
        GR/9W5+kORFQl/yr2+3qhj4eIm3OVPqeRgBQBl7sLpCgZZu9kyV46GfCQCObpjXPWjViSUjK9OIdj
        7+vzZutW71JTcjSJvMDNLzUIf/7B8E+VOlMqrByNmwCBXWbKS0kDeqqWiYkq9xBqVJajm1Kum9VHP
        S6Eb06R9xv+anb+YZ2jTN6WYUEHBGYLY28NRTyfisJgIYka8b4qJRT1dND/99TNHzYtzHmscZubFo
        B+6DpqQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMpMw-0001Qy-4H; Mon, 28 Sep 2020 09:22:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 801C1302753;
        Mon, 28 Sep 2020 11:22:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 460A0203E73B9; Mon, 28 Sep 2020 11:22:49 +0200 (CEST)
Date:   Mon, 28 Sep 2020 11:22:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     qianjun.kernel@gmail.com
Cc:     tglx@linutronix.de, will@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, laoar.shao@gmail.com,
        qais.yousef@arm.com, urezki@gmail.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing
 loop
Message-ID: <20200928092249.GC2628@hirez.programming.kicks-ass.net>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
 <20200915115609.85106-5-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915115609.85106-5-qianjun.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 07:56:09PM +0800, qianjun.kernel@gmail.com wrote:
> +/*
> + * The pending_next_bit is recorded for the next processing order when
> + * the loop is broken. This per cpu variable is to solve the following
> + * scenarios:

This, that adds all that complexity, and I think it's wrong. The
softirqs are priority ordered. Running then again from 0 up if/when you
break seems 'right'.

