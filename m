Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB77F2A1570
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 12:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgJaLZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 07:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgJaLZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 07:25:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892B3C0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 04:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7NmMeOYUyEgL87woHOXDY5bZ4hpO+mPHcbV5EnX6AxY=; b=cltkblME6Wfa1xTFOONDlgwbHC
        wIZFzyZgCNkXpxmcgiyhN93u+f4CLHCwBl5mWz3MXSZyllwib4kVlfNNgiBsZ8iDkfyr4OjB/2Qc8
        zC6jABn7cBIoipMR8zeCmY/iQIuI7XkzF4TeNEGAsCP8NMPbDDg6ONRLmlYr+rd882Q0CQlLcM20A
        gAkgoUBvDfkQNNp3HfwmlA7zHLloIPrK0VEsqUBp/AOjb3jq61Sgs2ERhbkthLOy6pZZoj9upPCEA
        1oD0Mnqiv0M7fKxD9oM87q5prH96Cq8PowkZ9/94Cj4RweCvyRg+bQ2dkTveXcdCct+sOWrJS1/zW
        6wfiNDqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYp0l-0004JD-5m; Sat, 31 Oct 2020 11:25:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 571EC30377D;
        Sat, 31 Oct 2020 12:25:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3863E2BE225BB; Sat, 31 Oct 2020 12:25:28 +0100 (CET)
Date:   Sat, 31 Oct 2020 12:25:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: ltp::mmap05  -->  BUG: using __this_cpu_read() in preemptible
Message-ID: <20201031112528.GV2594@hirez.programming.kicks-ass.net>
References: <b4d10b7e3af878ec88bbaccc819c8ba3ec9beb34.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d10b7e3af878ec88bbaccc819c8ba3ec9beb34.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mike, good to see you're enjoying retirement ;-)

On Sat, Oct 31, 2020 at 06:52:40AM +0100, Mike Galbraith wrote:
> [  138.620544] BUG: using __this_cpu_read() in preemptible [00000000] code: mmap05/4858
> [  138.620737] caller is lockdep_hardirqs_on_prepare+0x2f/0x1b0

Fix should already be in tip/locking/urgent.
