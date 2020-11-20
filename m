Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1B2BAC21
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgKTOop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgKTOoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:44:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71538C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 06:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=39sogjkecKTSISSPCKzDBWhZg6SnSlPkb8Nh25dt+WE=; b=EMLD5cDpdXZQM63Ga1VtdMu5fM
        qyX0QBkojeeLULC0/ftVOfzy0QPKhwdej7zJUCB4Q7qHRoI2MwGk0U43iYbC3/uKszQIK9qVabNkm
        ntHYc3ezB97PrM2HBETMy5YfnEYeDzaL9FG4SRVDnvUFTDIq1IMQLiFLG1hCftvU/beS3eWpaFPW6
        X+rRBm4U0efPvkoCccCICd4euEsBva4y38GElVWGGo8YbMq12kWr97qeZRtu5Dy6xvjwKd7zHd2eS
        9VNYjn/gJdODGnwE94q+H3QqPd7GXOaBdx5meRA8XMDyazmExapSzbeRCtjeLdcZYmo37wAQFSdZz
        uyxvLjFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg7eQ-0007YO-RN; Fri, 20 Nov 2020 14:44:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 747AD306BCA;
        Fri, 20 Nov 2020 15:44:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67262201B4C4C; Fri, 20 Nov 2020 15:44:38 +0100 (CET)
Date:   Fri, 20 Nov 2020 15:44:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 2/5] locking/rwsem: Prevent potential lock starvation
Message-ID: <20201120144438.GG3040@hirez.programming.kicks-ass.net>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118030429.23017-3-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:04:26PM -0500, Waiman Long wrote:
> +	long rcnt = (count >> RWSEM_READER_SHIFT);	/* Reader count */

I'm thinking you can do without that comment, the variable name is clear
enough.
