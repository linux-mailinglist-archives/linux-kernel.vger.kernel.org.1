Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2932D44E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbgLIO5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732445AbgLIO5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:57:43 -0500
Date:   Wed, 9 Dec 2020 06:57:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607525822;
        bh=E/J48ojA1PPkZ9RHRPFpZfdRtd7AUnBjD4AEtMLyiwY=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ily9kgYerc3ISWU6gUuUiVDsh+jBLnWoZZLDajCs6/qkeqZPA1iTpLfH2p76QfzKD
         0XscvMeRgHPl0jlbp4jEDmEqdq+v6PbmpNVSrIsbLWn3Ww44kivcJzIBurOIf5w4MY
         ekJvFJrTNMFtBI5w8D7xvLoP5XQ6oc3lgvyo09RUkEB7Og0wdN4pL3TQsOPGfgrhdg
         X7CrSAA+jB7ZAbg8nSacDNXZyt6dQjTG1ZsINp9XYiO0e37qN2Xmj56stc3nH6VN/u
         XZ2Ywv6qcLhRqk3eZwlv2mGOtOU2N1Dr7unPsfYZ8YP66+goWIFdyr+wmhTRy2Jl1L
         ImZRmV5wRhMLw==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        iamjoonsoo.kim@lge.com, andrii@kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 sl-b 1/5] mm: Add mem_dump_obj() to print source of
 memory block
Message-ID: <20201209145702.GA2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-1-paulmck@kernel.org>
 <20201209081710.GA17642@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209081710.GA17642@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 08:17:10AM +0000, Christoph Hellwig wrote:
> Your two new exports don't actually seem to get used in modular code
> at all in this series.

Indeed, and I either need to remove the exports or make my test code in
kernel/rcu/rcuscale.o suitable for upstreaming.  Or find the appropriate
mm/slab selftest location.

							Thanx, Paul
