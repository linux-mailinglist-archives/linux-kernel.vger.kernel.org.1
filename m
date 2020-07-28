Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C70D230AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 14:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgG1MxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 08:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgG1MxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:53:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68798C061794;
        Tue, 28 Jul 2020 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UgVQRvZJixUv6JYF5NwVa4T32Vg00H3gT3hmhAxa1kQ=; b=KSqMSEQhA17NtjqHKn38xSqgt6
        zHXQfifZ84Dd/efwyw+dirBDJqvLC1ttSvegpdnN33kR1bp/fCib/TlHEXuKnVQT1HmvSbSk3njbb
        9LtNUsK8XHesz0Mt23dTG9VhCrlAwlobY/ULokJMsD5xzuLP4dzjDnOOumMqQfeV1/tk5L6wOkiiP
        Dv/dioQHpy1SnvQZB/A7dRpyQzvcKuDQfQKPZZAHrejYtJQd5OazIYgTL7tSaBOklThF3COFZKdql
        ZPjlim/3ReNbMJTVnVpjgP/YnRA9k5k4N7vkKUe3zGyDgUCDZR3eOvzFknYZZJG2Y9F/Zvr7Z8nHm
        URVU2h3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0P6E-0003Fs-2g; Tue, 28 Jul 2020 12:52:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5751A304B6D;
        Tue, 28 Jul 2020 14:52:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5B7B29DE295A; Tue, 28 Jul 2020 14:52:52 +0200 (CEST)
Date:   Tue, 28 Jul 2020 14:52:52 +0200
From:   peterz@infradead.org
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>
Subject: Re: Minor RST rant
Message-ID: <20200728125252.GW119549@hirez.programming.kicks-ass.net>
References: <20200724132200.51fd2065@oasis.local.home>
 <20200724113325.44923f75@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724113325.44923f75@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:33:25AM -0600, Jonathan Corbet wrote:

> I'm not sure what to do other than to continue to push for minimal use of
> intrusive markup.

Perhaps make it clearer in:

  Documentation/doc-guide/

because people claim they follow that, but the result is that I get
completely unreadable garbage from them.

Like I've written many times before, I'm starting to loathe RST, it's an
absolute failure. I'm near the point where I'm looking to write a script
that will silently convert any RST crap to plain text in my commit
script.
