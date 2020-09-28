Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E69327AB56
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgI1JzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgI1JzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:55:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B038C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PM46qSr+CLum3oDKTc1ULm4mOWg7/XgMpKPnYlsacb4=; b=H6/bdWtE/U3hERkCao635LUQr9
        e5d9MUbk3dL83/J41RBnMmXgYmGuOtsabpq9fY1SVC3jTAeAgmyzdXwlYRKe1mqdHurJK4o1VkjAU
        phqk1g/LG0gLDKvRR2wsHD6JEQG8CqwXYZLU4QCqfNbuGzeyo1Z54LHz1YjUqZ/qxWxtNvC5pXNCt
        lvG5mC/9s3EQ+oKJPb0e6zcF+x/SeACE7Ua5zK6sTOi1xUV5Rd7IwHD/+VAPuJnVKoM0uoC5M1cDv
        EN7wnjp08OX/wRROeZ49KRi8V6cO/Hq7QSIeHTypDdXG0h9ADNH2QmkqVA/bMug6SigSta0QJxCs/
        k4IyJMQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMps8-0002cZ-Ua; Mon, 28 Sep 2020 09:55:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDB7B305C16;
        Mon, 28 Sep 2020 11:55:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2F202B85DB06; Mon, 28 Sep 2020 11:55:01 +0200 (CEST)
Date:   Mon, 28 Sep 2020 11:55:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Qian Cai <cai@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] lockdep: Optimize the memory usage of circular queue
Message-ID: <20200928095501.GE2628@hirez.programming.kicks-ass.net>
References: <20200917080210.108095-1-boqun.feng@gmail.com>
 <20200928085104.GE2611@hirez.programming.kicks-ass.net>
 <20200928094738.GB17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928094738.GB17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:47:38PM +0800, Boqun Feng wrote:
> I think your version is better and should be functionally identical to
> mine, also FWIW, I tested with a lockdep boot selftests, everything
> worked fine.

Excellent, thanks! I'll go feed it to the robots.
