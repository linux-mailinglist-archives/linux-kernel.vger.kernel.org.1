Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1B19DC8D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 19:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404220AbgDCRSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 13:18:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgDCRSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dx9pi5qloDON5sT21yKIuo+5buti9mt8VDPr2oqHge0=; b=OO/FqPH7EVVlBiTMJcVr+rZ4K7
        lNSuHxSFpfPkIkLW2/9LL0/FtfFVTMLXaaZVIFwUP9u/fBrMnShHsTG7T2Meuu3eIed0SBH8UNGpS
        XestdDvUTO+vTbWa6eMQGOgNRUvmLqzx0p68U5fA1WjXkHwPgyMHiywNmxKfEvzX/SAVaLJWdmBTz
        oOPgT8yZVIvW1Xp8ktZNym9XV4tYlDNzsXaPw4pyKM6RUwWgpy5vD7vhrJDuAsI9J1FdSvqVi1HeI
        RXkC1Flq5lDkCIj0U/8OU9Q6Tx+7K6h7GwST8E3GGr7yg74igzlElwF5I+OL0VcPKsL+Szcw2Ss1J
        OWVykH0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKPxn-0003Ci-B6; Fri, 03 Apr 2020 17:18:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 284FB3060FD;
        Fri,  3 Apr 2020 19:18:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A1A22B125212; Fri,  3 Apr 2020 19:18:37 +0200 (CEST)
Date:   Fri, 3 Apr 2020 19:18:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH 5/7] x86/speculation: Annotate intra-function calls
Message-ID: <20200403171836.GB20730@hirez.programming.kicks-ass.net>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-6-alexandre.chartre@oracle.com>
 <20200403160538.qwu237amhanr6pyi@treble>
 <20200403161607.jxz6duaz7dud22wf@treble>
 <2c615bae-6002-80b7-493d-b24ec48f69c9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c615bae-6002-80b7-493d-b24ec48f69c9@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 10:14:49AM -0700, Alexandre Chartre wrote:

> So that means that any alternative that does a stack manipulation isn't
> currently supported?

It's fundamentally impossible to correctly unwind through.

Instructions before and after the alternative need to have the same
stack layout irrespective of the alternative chosen.

What we need in this case though is only a different stack layout inside
the alternative, and that is doable.
