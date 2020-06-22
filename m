Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176942033E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 11:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFVJqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 05:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgFVJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:46:51 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F861C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8QLfGcfgf224/SAWVviGZuCV5R+FCKNfSyMs1yzt3Bo=; b=PDeFFkPjD59YCcKzyokULGKVFl
        xzI8NNFNi9Ho//zqbifbrqPd2GRdZkCaRAhGKFxTqQIi0Qql8D/oh7+sQfL67OF2EfvEvgnZpKhAK
        XxQKE0kz0vQio7UylckhSrYUbBa2ePan/QaRGDVbgeYmncS27nSENpvErjrZKgDMGdg8WZGO9jWyR
        cLLp1r8oOm6MAmOn+ZWRIt6RjK1/QxWpxCOB/MPfO1bY/dCvLUr1/BB6JfdO/m8coBj5VaL4s049J
        mZMPv8WSxnRT468a4DQIeX2c1fJbp/9UHEkI8ic/QNK4lD8yI4/14J214NxAVTk55keABjUyoxtWD
        bd0JMH3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnJ1t-0007mw-Rt; Mon, 22 Jun 2020 09:46:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44F5A30018A;
        Mon, 22 Jun 2020 11:46:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F4F829C119A5; Mon, 22 Jun 2020 11:46:16 +0200 (CEST)
Date:   Mon, 22 Jun 2020 11:46:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boris Petkov <bp@alien8.de>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Bo YU <tsu.yubo@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, luto@kernel.org, jannh@google.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arch/x86: Return value from notify_die should to
 be checked.
Message-ID: <20200622094616.GO576888@hirez.programming.kicks-ass.net>
References: <20200621102634.n43ozcsiravdi2ie@debian.debian-2>
 <4d1ef78e-f001-a685-9a69-afa68454fdc7@oracle.com>
 <6CFD253C-824B-4F95-BBB0-F53123DBC323@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6CFD253C-824B-4F95-BBB0-F53123DBC323@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:17:51AM +0200, Boris Petkov wrote:
> On June 22, 2020 10:52:23 AM GMT+02:00, Alexandre Chartre <alexandre.chartre@oracle.com> wrote:
> > So the appropriate change to make Coverity happy 
> 
> Or we can stop "fixing" the kernel in order to shut up tools and not do anything.

Agreed, no change required here.
