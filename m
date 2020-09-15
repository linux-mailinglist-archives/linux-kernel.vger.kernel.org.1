Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A5626B686
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgIPAGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:06:52 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:21867 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgIOO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600180117; x=1631716117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=i/LZXWaJ7nuQEk6+7RdDEQBLAnsXNpBBc/8bshAm45Q=;
  b=Ht2+qVZZIv6P5RxaVJK7MiOPjIuAp/TMXaJ44A4eYJiEhQqg5EE9y3vP
   L5ECbV45okDQMAfzFHxS1ZzcF7EA4hylxxvkzcYR08NIshNYGzdB9vmjP
   HXUoYrwx2eppnudfqbhg1LzaY0PsFeb6gffz+YKVvktMKLQvh/XH1AuR+
   8=;
X-IronPort-AV: E=Sophos;i="5.76,430,1592870400"; 
   d="scan'208";a="54074202"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 15 Sep 2020 14:27:11 +0000
Received: from EX13D31EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id AE2F9A1DEB;
        Tue, 15 Sep 2020 14:26:59 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.35) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 15 Sep 2020 14:26:46 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Marco Elver <elver@google.com>
CC:     SeongJae Park <sjpark@amazon.com>, <mark.rutland@arm.com>,
        <linux-doc@vger.kernel.org>, <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <edumazet@google.com>, <glider@google.com>,
        <hpa@zytor.com>, <cl@linux.com>, <will@kernel.org>,
        <corbet@lwn.net>, <x86@kernel.org>, <kasan-dev@googlegroups.com>,
        <mingo@redhat.com>, <dvyukov@google.com>, <rientjes@google.com>,
        <aryabinin@virtuozzo.com>, <keescook@chromium.org>,
        <paulmck@kernel.org>, <jannh@google.com>, <andreyknvl@google.com>,
        <cai@lca.pw>, <luto@kernel.org>, <tglx@linutronix.de>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <penberg@kernel.org>, <bp@alien8.de>, <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH RFC 01/10] mm: add Kernel Electric-Fence infrastructure
Date:   Tue, 15 Sep 2020 16:26:31 +0200
Message-ID: <20200915142631.31234-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915141449.GA3367763@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.35]
X-ClientProxiedBy: EX13D34UWC003.ant.amazon.com (10.43.162.66) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 16:14:49 +0200 Marco Elver <elver@google.com> wrote:

> On Tue, Sep 15, 2020 at 03:57PM +0200, SeongJae Park wrote:
> [...]
> > 
> > So interesting feature!  I left some tirvial comments below.
> 
> Thank you!
[...]
> > > +
> > > +	/* Only call with a pointer into kfence_metadata. */
> > > +	if (KFENCE_WARN_ON(meta < kfence_metadata ||
> > > +			   meta >= kfence_metadata + ARRAY_SIZE(kfence_metadata)))
> > 
> > Is there a reason to use ARRAY_SIZE(kfence_metadata) instead of
> > CONFIG_KFENCE_NUM_OBJECTS?
> 
> They're equivalent. We can switch it. (Although I don't see one being
> superior to the other.. maybe we save on compile-time?)

I prefer CONFIG_KFENCE_NUM_OBJECTS here just because it's more widely used in
the code.  Also, I personally think it's more easy to read.

[...]
> > > +	pr_info("initialized - using %zu bytes for %d objects", KFENCE_POOL_SIZE,
> > > +		CONFIG_KFENCE_NUM_OBJECTS);
> > > +	if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
> > > +		pr_cont(" at 0x%px-0x%px\n", (void *)__kfence_pool,
> > > +			(void *)(__kfence_pool + KFENCE_POOL_SIZE));
> > 
> > Why don't you use PTR_FMT that defined in 'kfence.h'?
> 
> It's unnecessary, since all this is conditional on
> IS_ENABLED(CONFIG_DEBUG_KERNEL)) and we can just avoid the indirection
> through PTR_FMT.

Ok, agreed.

[...]
> > > +	for (skipnr = 0; skipnr < num_entries; skipnr++) {
> > > +		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
> > > +
> > > +		/* Depending on error type, find different stack entries. */
> > > +		switch (type) {
> > > +		case KFENCE_ERROR_UAF:
> > > +		case KFENCE_ERROR_OOB:
> > > +		case KFENCE_ERROR_INVALID:
> > > +			if (!strncmp(buf, KFENCE_SKIP_ARCH_FAULT_HANDLER, len))
> > 
> > Seems KFENCE_SKIP_ARCH_FAULT_HANDLER not defined yet?
> 
> Correct, it'll be defined in <asm/kfence.h> in the x86 and arm64
> patches. Leaving this is fine, since no architecture has selected
> HAVE_ARCH_KFENCE in this patch yet; as a result, we also can't break the
> build even if this is undefined.

Ah, got it.  Thank you for the kind explanation.


Thanks,
SeongJae Park

> 
> Thanks,
> -- Marco
