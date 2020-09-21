Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198882730AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgIURN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgIURN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:13:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1305520758;
        Mon, 21 Sep 2020 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600708406;
        bh=nx2TaoLqWNqyr9nmT07RvYE1xPfejV7fHLR9RhvDxrs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1ijNGgPZsuS/MdRNOo+9S8z8K8msXaiAAXasAViW7Pc1fvHVHsRMQmavi1F5KLtPh
         L9Re+/yGF1bX9rpvp3gODn97EevX4KNCT1dvqtucDsCJkeffjsyPXqu17zAkpdyhX1
         W1lNBAILQoN644xeMWEGZaA7OWAQsGtAc0RFYifk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D2C8D352303A; Mon, 21 Sep 2020 10:13:25 -0700 (PDT)
Date:   Mon, 21 Sep 2020 10:13:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     akpm@linux-foundation.org, glider@google.com, hpa@zytor.com,
        andreyknvl@google.com, aryabinin@virtuozzo.com, luto@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, cl@linux.com,
        dave.hansen@linux.intel.com, rientjes@google.com,
        dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        sjpark@amazon.com, tglx@linutronix.de, vbabka@suse.cz,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/10] kfence: add test suite
Message-ID: <20200921171325.GE29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921132611.1700350-1-elver@google.com>
 <20200921132611.1700350-11-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921132611.1700350-11-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 03:26:11PM +0200, Marco Elver wrote:
> Add KFENCE test suite, testing various error detection scenarios. Makes
> use of KUnit for test organization. Since KFENCE's interface to obtain
> error reports is via the console, the test verifies that KFENCE outputs
> expected reports to the console.
> 
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Co-developed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

[ . . . ]

> +/* Test SLAB_TYPESAFE_BY_RCU works. */
> +static void test_memcache_typesafe_by_rcu(struct kunit *test)
> +{
> +	const size_t size = 32;
> +	struct expect_report expect = {
> +		.type = KFENCE_ERROR_UAF,
> +		.fn = test_memcache_typesafe_by_rcu,
> +	};
> +
> +	setup_test_cache(test, size, SLAB_TYPESAFE_BY_RCU, NULL);
> +	KUNIT_EXPECT_TRUE(test, test_cache); /* Want memcache. */
> +
> +	expect.addr = test_alloc(test, size, GFP_KERNEL, ALLOCATE_ANY);
> +	*expect.addr = 42;
> +
> +	rcu_read_lock();
> +	test_free(expect.addr);
> +	KUNIT_EXPECT_EQ(test, *expect.addr, (char)42);
> +	rcu_read_unlock();

It won't happen very often, but memory really could be freed at this point,
especially in CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels ...

> +	/* No reports yet, memory should not have been freed on access. */
> +	KUNIT_EXPECT_FALSE(test, report_available());

... so the above statement needs to go before the rcu_read_unlock().

> +	rcu_barrier(); /* Wait for free to happen. */

But you are quite right that the memory is not -guaranteed- to be freed
until we get here.

							Thanx, Paul
