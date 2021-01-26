Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7453045F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404021AbhAZSFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390980AbhAZJYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:24:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF78AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+OtfEgx/CrQms/KzxhC+8LI0oesZp6YvKvcU/ZJAXaQ=; b=PM/ThATZ3HRwA0ToVGZUIwtiqu
        JpPVhiFCUsfvHKhkqHld9mxA8onxAtSGanyP4POw/e3rhs2HdtfiuFL6vlkQdwT2CIb9aYBO6uFI/
        8Sp2qciNI2sjIbNYtFDfUL7x/ymvJ4KDyzVnC4qNxj9tJIvFXf9ezbPXLH+Ri9SjCb2BOsq03gnUX
        BjL42J/HCYfiYSq5uiGmTJ410/hUbV8qS4XiJ0zCwJmnM3BSTxUWiz1m3065qMlrREwEMW+DoT4IW
        AkH0GBrDBLv+oob5veZ1+sA2vXQT7MaIXrCX6sw4wCxe+YW7vxE8m+wxBy+nNfzCThe1uT9UQFxGc
        oHk2YQyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4KYj-005M7q-Eq; Tue, 26 Jan 2021 09:23:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE52D300DB4;
        Tue, 26 Jan 2021 10:22:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8343420297EDB; Tue, 26 Jan 2021 10:22:48 +0100 (CET)
Date:   Tue, 26 Jan 2021 10:22:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question on migrate_disabe/enable()
Message-ID: <YA/faHXHWw1UfmUB@hirez.programming.kicks-ass.net>
References: <BYAPR11MB2632E0BCC9CE86D7DB6E7CFEFFBC9@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB2632E0BCC9CE86D7DB6E7CFEFFBC9@BYAPR11MB2632.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:12:45AM +0000, Zhang, Qiang wrote:
> Hello Peterz, tglx
> 
> I have some questions about migrate_disabe/enable(),  in the past
> migrate_disabe/enable() is replaced by preempt_disable/enable() in no
> RT system.
> 
> And now migrate_disabe/enable() has its own implementation, I want to
> know in migrate_disabe/enable() critical area is blocking allowed?  

Yes, obviously. Otherwise it would've been preempt_disable().

> If allowed, There's a blockage in migrate_disabe/enable() critical
> area, and this time if CPU going offline，offline time will be longer.
> Is this normal phenomenon？

Ofcourse.
