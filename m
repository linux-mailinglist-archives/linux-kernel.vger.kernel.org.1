Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CD825D1B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 08:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgIDGw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 02:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIDGw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:52:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB960C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ud2h15Pl1kXqyet856rspbHUVDmYSIlb8Zch9HhHUBw=; b=i5I2Uji41lU6lUrpDezaYYIoNs
        k0Jn/B3u/dfDrb6VGP4ELueZPSUyYN+WMjY6tSnIsI3OgzHpRjdcRJ1FiFvU30wXLZwiQiIBl7PvC
        b+6+hsG9ahpLxsQqeCGLXnQlQpu84Y9og6Muw+sI/Wso0vLPYRrRoWF3kDUIxxBpxsQ2TSyl39cHN
        qL27R+VeVbT2hJBp9BN5Z9/puz2YaTypH0wn8PAtBD5di+jsRvYQTWXngNsf9Ak4HGcwzVXqskHRE
        xy4Os7KLZK7+MnQl9KynzedmCzoCbuflpCo9SW4Q2zUSHmAGdnzbVJ/sheys7aeY01+HUMzPGud66
        0ZwIk8dQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE5aZ-00043H-KO; Fri, 04 Sep 2020 06:52:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55827300F7A;
        Fri,  4 Sep 2020 08:52:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12E292BBB68A3; Fri,  4 Sep 2020 08:52:45 +0200 (CEST)
Date:   Fri, 4 Sep 2020 08:52:45 +0200
From:   peterz@infradead.org
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] seqlock: Introduce PREEMPT_RT support
Message-ID: <20200904065245.GK2674@hirez.programming.kicks-ass.net>
References: <20200828010710.5407-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828010710.5407-1-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



FWIW, can you please start a new thread with ever posting? I lost this
one because it got stuck onto some ancient thread.
