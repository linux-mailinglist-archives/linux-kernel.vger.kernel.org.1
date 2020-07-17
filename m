Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7E12238D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 12:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgGQJ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 05:59:58 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:21577 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594979996; x=1626515996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=9vaHmuMsNN0kIp0YqM12N3y5Zy+mAtWNYvcQ8zisUCM=;
  b=vBH9iXY1ugHiuN2VMVXO4uF7xlqNvWERnBrc9eWc9g5udeDFHnhT9aON
   dfGZPwNbYFS5c3Ml9+4aLWJT8HTJ4Y2b6rrw7+dn1wz6hOy4ZPgTwuDSu
   sTBFDc+x7Hk9U4btwG9CnESa1oZqh8Cul2NaIUbJBKDI5u+Yt+EOV+qsc
   E=;
IronPort-SDR: 6PDhm+xE4JDdLX39G/DZKH1Kn+CU+lfhtanLL/IjlririC28jO/snZL2Q7aMTFPxbVd11ZQ3CH
 iRLZFTHsFQXA==
X-IronPort-AV: E=Sophos;i="5.75,362,1589241600"; 
   d="scan'208";a="42377858"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 17 Jul 2020 09:59:55 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 52A8CA11D6;
        Fri, 17 Jul 2020 09:59:45 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Jul 2020 09:59:44 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Jul 2020 09:59:26 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     Mike Rapoport <rppt@kernel.org>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: Re: [PATCH v18 01/14] mm/page_ext: Export lookup_page_ext() to GPL modules
Date:   Fri, 17 Jul 2020 11:59:10 +0200
Message-ID: <20200717095910.23550-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713173805.31923-1-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D14UWC003.ant.amazon.com (10.43.162.19) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 19:38:05 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> On Mon, 13 Jul 2020 20:19:09 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > On Mon, Jul 13, 2020 at 02:21:43PM +0200, SeongJae Park wrote:
> > > On Mon, 13 Jul 2020 15:08:42 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> > > 
> > > > Hi,
> > > > 
> > > > On Mon, Jul 13, 2020 at 10:41:31AM +0200, SeongJae Park wrote:
> > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > > 
> > > > > This commit exports 'lookup_page_ext()' to GPL modules.  It will be used
> > > > > by DAMON in following commit for the implementation of the region based
> > > > > sampling.
> > > > 
> > > > Maybe I'm missing something, but why is DAMON a module?
> > > 
> > > I made it loadable just for easier adoption from downstream kernels.  I could
> > > drop the module build support if asked.
> >  
> > Well, exporting core mm symbols to modules should be considred very
> > carefully. 
> 
> Agreed.  I will drop the module support from the next spin.
> 
> > 
> > Why lookup_page_ext() is required for DAMON? It is not used anywhere in
> > this patchset.
> 
> It's indirectly used.  In the 6th patch, DAMON uses 'set_page_young()' to not
> interfere with other PTE Accessed bit users.  And, 'set_page_young()' uses
> 'lookup_page_ext()' if !CONFIG_64BIT.  That's why I exported it.

This also means that it would make no sense if !64BIT && !PAGE_EXTENSION.  In
the next spin, I will update the DAMON Kconfig to select PAGE_EXTENSION if
!64BIT, as same to that of IDLE_PAGE_TRACKING.


Thanks,
SeongJae Park
