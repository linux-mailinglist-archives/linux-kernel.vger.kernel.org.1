Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB290295FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899488AbgJVNTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:19:18 -0400
Received: from mail.efficios.com ([167.114.26.124]:45586 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899481AbgJVNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3CBE72ED158;
        Thu, 22 Oct 2020 09:19:16 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nPK9ouAC5Vv1; Thu, 22 Oct 2020 09:19:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 356302ED157;
        Thu, 22 Oct 2020 09:19:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 356302ED157
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603372755;
        bh=ntLZuZMR4Ga7jdWMbrW5i0nvpfLlBNhKnyFUAwGwNgI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=XHTQ/X9myePO5fxW8IBnQ0BA9dfiBrDpnN7bZmVTLkMx1VKwlNtr4mNeJ38XHFsrD
         U/BB2bkSCqHlr3HhhpFF3bXh+HJL4TXVxgUVvYHdviIt3IIQO6BsDB6gV2484lv3r3
         nJnVNrLpYFettkMfR8GbtPbGgpSDBVnQUSeifwxOHSFcik2T+rUz615bFIU2i/Rbvl
         ECSosYhTwBLopd06ZMT3Ev520Ab6h0kJQEdfrIo9Vn9m9Ck+46HDISMHtvcgY1ocLL
         GY7bkXtLX9ler93GWPcCOjbyz2m307WF3BtnjKivrnHrGKkCS3llHgazsDxMrIna/i
         KKQR+b8lnPMrQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vEllpX-CDr10; Thu, 22 Oct 2020 09:19:15 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 20AFD2ECFD2;
        Thu, 22 Oct 2020 09:19:15 -0400 (EDT)
Date:   Thu, 22 Oct 2020 09:19:15 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Anton Blanchard <anton@au.ibm.com>, anton@ozlabs.org
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>, lkp <lkp@lists.01.org>,
        zhengjun xing <zhengjun.xing@intel.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
Message-ID: <1597497813.35294.1603372755111.JavaMail.zimbra@efficios.com>
In-Reply-To: <e2eb8ed0-1075-3c5d-207e-d218a59c2a9f@linux.intel.com>
References: <20201002083311.GK393@shao2-debian> <1183082664.11002.1602082242482.JavaMail.zimbra@efficios.com> <7131f8f9-68d1-0277-c770-c10f98a062ec@linux.intel.com> <510309749.29852.1603199662203.JavaMail.zimbra@efficios.com> <e2eb8ed0-1075-3c5d-207e-d218a59c2a9f@linux.intel.com>
Subject: Re: [LKP] Re: [sched] bdfcae1140: will-it-scale.per_thread_ops
 -37.0% regression
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: bdfcae1140: will-it-scale.per_thread_ops -37.0% regression
Thread-Index: YJbUcUrA024P7c/g6sWwOrLYCUpVqg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 21, 2020, at 9:54 PM, Xing Zhengjun zhengjun.xing@linux.intel.com wrote:
[...]
> In fact, 0-day just copy the will-it-scale benchmark from the GitHub, if
> you think the will-it-scale benchmark has some issues, you can
> contribute your idea and help to improve it, later we will update the
> will-it-scale benchmark to the new version.

This is why I CC'd the maintainer of the will-it-scale github project, Anton Blanchard.
My main intent is to report this issue to him, but I have not heard back from him yet.
Is this project maintained ? Let me try to add his ozlabs.org address in CC.

> For this test case, if we bind the workload to a specific CPU, then it
> will hide the scheduler balance issue. In the real world, we seldom bind
> the CPU...

When you say that you bind the workload to a specific CPU, is that done
outside of the will-it-scale testsuite, thus limiting the entire testsuite
to a single CPU, or you expect that internally the will-it-scale context-switch1
test gets affined to a single specific CPU/core/hardware thread through use of
hwloc ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
