Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59CB2EAD8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 15:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbhAEOmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 09:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbhAEOmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:42:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80697225AC;
        Tue,  5 Jan 2021 14:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609857700;
        bh=TyokeEosH0d45FqB+2PCodYkHTVf85vLR3ceTzumgtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uowayz7WfayHtQE7j/EtsE4iD2wlU7XENJzmNunudI46bBb9tN+UlsxFRVvrtsoJn
         N/YGLsuSr5qN4Ob0mV+eGLBjcr7Ez10JtnQErRpjXiWXz5xDery5QIJxpI1d8rjkaZ
         l/y+wLEnMwQhYaEAwrwXSKhOXQfcXtvQhPuQYpgJUC929v5U0QV+qT9bFN3Ss9tAcr
         jndjUk3f5/GbPqT59e1o3iSxZrUviZ415CFo8l2wzuC8tDRW0srXy4Y9dyREemRplj
         yB1/PCqy1rU0URyOcchUz7rYJZnWs0EIHtOS4Lck9m9c2koCRlg8xDmqZBOdfnQIFu
         aa70dwioKQgOw==
Date:   Tue, 5 Jan 2021 23:41:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        shuah@kernel.org
Subject: Re: [PATCH] selftests/ftrace: Disable multiple_kprobes test on
 powerpc
Message-Id: <20210105234137.d412b08f1b0bc07600dac978@kernel.org>
In-Reply-To: <1609841373.5sgt2b2ism.naveen@linux.ibm.com>
References: <20210105065730.2634785-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210105190156.ada6ce0d46d7eada18b9ad76@kernel.org>
        <1609841373.5sgt2b2ism.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jan 2021 15:42:44 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > On Tue,  5 Jan 2021 12:27:30 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> >> Not all symbols are blacklisted on powerpc. Disable multiple_kprobes
> >> test until that is sorted, so that rest of ftrace and kprobe selftests
> >> can be run.
> > 
> > This looks good to me, but could you try to find the functions
> > which should be blocked from kprobes?
> > (Usually, the function which are involved in the sw-breakpoint
> >  handling, including locks etc.)
> 
> Yes, we did add several blacklists some time back, but there has been 
> quite a bit of churn in our entry code. I've been meaning to audit it 
> for a while now, but this has been blocking tests. It would be nice to 
> skip this test for now until I am able to spend some time on this.

OK, But for revisiting this testcase in the future, I think it should
return UNTESTED instead of UNSUPPORTED.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
