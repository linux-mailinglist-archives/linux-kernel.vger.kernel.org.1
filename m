Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144D630443A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbhAZHKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 02:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbhAYPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:42:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE158C061793
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RTkQl6hmwOsxn9sYIT/QLpWjLP3ySo8g8LfWk2qaDGE=; b=EZFgWhtNxSv/TytG6mDfB3CdRj
        Bqf7omXxVqT0TtLlM3mU6PjoicSXDmh7eGs0001o3zIJkXzrHen3D4nTWHjUpX9cQ016kqNO+pUd/
        qUIVZWcn+UX7Z/gyhBmv0yeSqyhdaIGSHpXz75aEqviFuTQAxQDpxYe3cLMkNFOW920YK+kcrNL3p
        t3PWMMMn5VwuJYejc8I2gPdD0Jp7AOCIDc5um3wa6ZQX3V54kPAuF5SQsPSwIJb1k5v8i3l+HyHK+
        OZR/XXlwfypUfYgMYbzz4QrQzy+2eJKQWuNn0EfyZFyXBO5ui8iyR35Lt40xzGtAT6G3oGyYf5AxL
        /fUGaF9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l43Zr-0000CQ-00; Mon, 25 Jan 2021 15:14:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 720BF3056DE;
        Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5F3862B6D76C3; Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Message-ID: <20210125150953.679129361@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 25 Jan 2021 16:09:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [PATCH v2 0/7] Generic RB-tree helpers
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hai all,

I found myself needing to write yet another rbtree and remembered I had these
patches gathering dust. I've had them in a git tree pretty much ever since I
posted them last and the robot is telling me they build/work/dance/sing fine.

I'm proposing to stick them in tip and get on with life. What say you?


