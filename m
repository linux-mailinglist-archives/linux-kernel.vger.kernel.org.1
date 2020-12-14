Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C542D946C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 09:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439362AbgLNIx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 03:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407118AbgLNIw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 03:52:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DB9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0BcvIaTSMQVQ+X7pI76lvRe1/GideMdGKAosLW7Av5U=; b=Ad5eI9dPXK0XxJeSvzy6RpZC0E
        CxxQ9WybsZlDVyS2sG7QBYWusD+iip2QEKS8AWSe1/W5C2o1UZC0I+8FX3hKfNXQbvLyrhQSjkIiB
        wkJ9UAZ1VxRBAxF/8+mYSiLNaDupds9KLo4GEGUajHI/ZMO8WPG6vfHU0obKDHoGZXkSQWnWYZMtl
        BC9DITvD+WdhuxhyfMRHMfQNSnQUXggMX2SasSeE8yI4yNB6rJ+plFkjH2U97EMKhaf1syajIgFNk
        pimDV4TtOdVkWbo+ePOLyYNc5zgZchUCACk1Qmh+he3oCjTeJ2tlNsXn3U/VKgS3LBIf908ceiENJ
        04jCIw6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kojaU-00086n-UQ; Mon, 14 Dec 2020 08:52:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6FF73007CD;
        Mon, 14 Dec 2020 09:52:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A91E8200CFB30; Mon, 14 Dec 2020 09:52:06 +0100 (CET)
Date:   Mon, 14 Dec 2020 09:52:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH] jump_label: Do not profile branch annotations
Message-ID: <20201214085206.GW3040@hirez.programming.kicks-ass.net>
References: <20201211163754.585174b9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211163754.585174b9@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 04:37:54PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> While running my branch profiler that checks for incorrect "likely" and
> "unlikely"s around the kernel, there's a large number of them that are
> incorrect due to being "static_branches".
> 
> As static_branches are rather special, as they are likely or unlikely for
> other reasons than normal annotations are used for, there's no reason to
> have them be profiled.
> 
> Expose the "unlikely_notrace" and "likely_notrace" so that the
> static_branch can use them, and have them be ignored by the branch
> profilers.

The less that abomination does the better ;-), I'll take it through tip
then?
