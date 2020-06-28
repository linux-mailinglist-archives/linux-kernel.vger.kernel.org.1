Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7702920C823
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgF1M7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgF1M7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 08:59:32 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F49C061794
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rrwfl0iTqVy+GBEOBXXSk8AEg1CD80HI2UW6MMNNX8I=; b=XgwxCP8qWDCMmIcBPUnvErQP91
        2nziAxk/ZxHdFpgJdvtHj4XagRIAhLv27Qv1q+ax5PdP17cP6KfTZcAjn93b5mgVP8tHzROXQZzXC
        c7z9PhRmf3Cxh3ChKCprG0si9Icp6/0r5C6uDNWB/Eve0yTdirw2qCcpcZJshEgk7Ki4rFciSj87U
        V7OuFAXKtc7KMN4SmMo8H/evQKO5gchbxidNFzfv6HwsNEohbc4jE2mmmW+AfjKyaUaxilXwSdamv
        LraUcouO8DbPQxzcZaZMBz8XFitWQ6tM5IrIIHkCC1p83DLbTJS/ZeU1tbL5EcTvOy8qX1hvYkP51
        mbA9AYog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpWtW-0006yN-VM; Sun, 28 Jun 2020 12:58:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 226E4302753;
        Sun, 28 Jun 2020 14:58:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 006A3233E0188; Sun, 28 Jun 2020 14:58:44 +0200 (CEST)
Date:   Sun, 28 Jun 2020 14:58:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: fix build with GCC_PLUGIN_RANDSTRUCT
Message-ID: <20200628125844.GL4817@hirez.programming.kicks-ass.net>
References: <20200628072702.1249815-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628072702.1249815-1-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There's patches in tip/sched/urgent for this...
