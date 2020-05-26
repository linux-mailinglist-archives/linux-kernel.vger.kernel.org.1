Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7221E26DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbgEZQY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 12:24:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35176 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbgEZQYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=r5qzmgEBDPX/2DFy1eU97NU+3vwe8Kx4TqYAkIqdmjI=; b=EGQ0VqdotNdmrFlIyv23OFuXn6
        KEoqktPOc03CBN7qrJBZD/XA9CNZ2UkebSMhDzi1Jfl+zvSYBYz8yLG8X7inA4Y4aFOsPpatQrDRC
        T2LRFzUZDfiKleUo6j8wkdG/hqzZwM1PkNOKwB/oNhrxMn/QYrbt/4o+Kgy6BwHViV7xK4QtVD5cY
        CKBFZy8zsJfCABix1VK/iUraI4FabhM5v9UoxHqdGzjawlNWqNlyZHjGUnK+OpHrxd4xwcI2xC7PC
        hPr+oWxRQlpZ513iYYoJmepdkholPJVb6qLNca7XC7eX+JOcEan0W6JYTOhTZDkMOoXS5fkkj3q/t
        cCJ0iz/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdcIv-0005Tc-8T; Tue, 26 May 2020 16:19:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60B3B306099;
        Tue, 26 May 2020 18:19:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4127E20FF792B; Tue, 26 May 2020 18:19:41 +0200 (CEST)
Message-ID: <20200526161057.531933155@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 May 2020 18:10:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, peterz@infradead.org
Subject: [RFC][PATCH 0/7] Fix the scheduler-IPI mess.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

So commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()") is pretty buggered, and
I'm afraid this is the 'prettiest' pile of puke I could come up with.

It boots and builds a kernel, but it already did that for me.

I do think there's definite room for further integration of smp_function_call
and irq_work, but figured this was quite enough for now.

Please look hard, there be dragons here, I'm sure.

