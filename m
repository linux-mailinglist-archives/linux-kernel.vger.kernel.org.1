Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD2C1AAF67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406324AbgDORVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410846AbgDORV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:21:28 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99F442076D;
        Wed, 15 Apr 2020 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971285;
        bh=kmuwBov0NyMyryQo8DekLYoOEO6EGnDk/dsgUWhSDlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pMDIlC+9wOatLQPpY6ylkvnujF2r+7AnWVQmSQn6BLzMiG13qbmFl4MD5jJxQzTIE
         WGqgzDkt09Z506PN5kpEv/sZGhwBRs7AGRQ3SwuvEGTBWMEXceGYoxB6pUSWVkED5K
         xjvjdKoCPFzhvvjfjqSznU0vOyvnmI1ve3XVoWN4=
Date:   Wed, 15 Apr 2020 10:21:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 0/19] Miscellaneous fixes for v5.8
Message-Id: <20200415102123.0f87e15747aac6733233dd52@linux-foundation.org>
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 10:10:17 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> Subject: [PATCH tip/core/rcu 0/19] Miscellaneous fixes for v5.8

I was hoping we could get at least the data_race() implementation
into 5.7-rc1 - I'm sitting on a pile of patches which use it.  Oh well,
next time.
