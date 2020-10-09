Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE77928922E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 21:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbgJITtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 15:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgJITtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 15:49:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95BCC0613D2;
        Fri,  9 Oct 2020 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SgvnNpfrn/MQMIyMBQmEYFVyluHsUQhVV6DoGEDgBqo=; b=O6RjKK0kDe2iMy3GLV3oIIq2oN
        IB15xKddQd7Mfkgxd2Vns4iMhF2EVRKrxIEI4xHFHPwCvP9Z/CpBIndui79fYtk3Jm/y+NtQqxts4
        W/Jk17ahq6iiwfP9stgh1OyZVXDdrsTFdsZNO+qqI7NliDn9dWpUGU1+zrMNc+qjooFwlSrxiE4sU
        dygTP6d08WwvXSR4oo5C/yGWSEM7WF3Hxh3A7n7/qeRjlU/T4QRW7RI7FTCsTHj4fTlMX1OvmD3FB
        wjddfZtq2K72AVAHBlwGOeN3JUQuEpJ90V5wGRYeVgleekZ2TRfv9sj1rEot3KFLxwOvGktOMJBCC
        k1V+9Jsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQyO1-0000y4-Q9; Fri, 09 Oct 2020 19:49:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1F0B30008D;
        Fri,  9 Oct 2020 21:49:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AEDB820AEA646; Fri,  9 Oct 2020 21:49:04 +0200 (CEST)
Date:   Fri, 9 Oct 2020 21:49:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/11] counters: Introduce counter_atomic* counters
Message-ID: <20201009194904.GB1073957@hirez.programming.kicks-ass.net>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
 <baede266cc0c69da61142b467ff386c6b31a70b7.1602209970.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baede266cc0c69da61142b467ff386c6b31a70b7.1602209970.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 09:55:56AM -0600, Shuah Khan wrote:
> Introduce Simple atomic counters.
> 
> There are a number of atomic_t usages in the kernel where atomic_t api
> is used strictly for counting and not for managing object lifetime. In
> some cases, atomic_t might not even be needed.
> 
> The purpose of these counters is to clearly differentiate atomic_t
> counters from atomic_t usages that guard object lifetimes, hence prone
> to overflow and underflow errors. It allows tools that scan for underflow
> and overflow on atomic_t usages to detect overflow and underflows to scan
> just the cases that are prone to errors.

Under- and overflow on atomic_t is perfectly fine. We're not going to
create pointless wrappers for this.

What tools, and how could they not be served by adding annotations to
variable declarations?
