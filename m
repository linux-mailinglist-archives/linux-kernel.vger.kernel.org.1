Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591F62DE6C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 16:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgLRPiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 10:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgLRPiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 10:38:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398EAC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 07:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=svTqbWnS5fZJM2rW9XEt3HASXaCS/mQylN9RZkeHFio=; b=er5rpXekphZJhF3hrgBsNoRdfv
        Wr29+SAWAFg24xJlRskVR+s+/sDHpT6xSo1lXTevtkCoWjHp/vst/YxXIMqoGTy0AxwhV9HR/rjH/
        jL2pB1+X20ORpYO14rdellgLT0dkKT8v7F6H0FccwKyjnsqUOLg4+IQwp46flANtGrO/ieztHhqmV
        ao9MMngHMNctYbUx6qnWiNiyfu7A4uzAEyWJSkESgU0bH0VbT7BYiwyNNr6wU8mUORtlGL6xypPxI
        wKEgjIagNbJsX+jmRw7BqCdIvVWH3M6F2FTR49Huo5xH/FseDWl4qECX/o+Wm8O0yD/myZVqfRamO
        Aa4fTA7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqHoj-0001mc-Hc; Fri, 18 Dec 2020 15:37:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACD22300446;
        Fri, 18 Dec 2020 16:37:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AB2F20122356; Fri, 18 Dec 2020 16:37:16 +0100 (CET)
Date:   Fri, 18 Dec 2020 16:37:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: __local_bh_enable_ip() vs lockdep
Message-ID: <20201218153716.GI3021@hirez.programming.kicks-ass.net>
References: <20201215190152.GA22285@osiris>
 <20201215144724.40ab7612@gandalf.local.home>
 <20201216175259.GP3040@hirez.programming.kicks-ass.net>
 <20201218153356.GA7932@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218153356.GA7932@osiris>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 04:33:56PM +0100, Heiko Carstens wrote:

> Peter, will you make proper patch out of this?

Yes, let me go do that now, and stick it in the quilt series before I go
off and don't think for 2 weeks.
