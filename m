Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BDC231EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 14:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgG2Mo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 08:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2Mo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:44:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A160BC061794;
        Wed, 29 Jul 2020 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=weDZ153O0WszD1lg73pMLbyVJhub3UvuXl9mB+X5/WQ=; b=aF10hOXYWB6dW8cUaGkD/X/M10
        CnYujoQEnh8v9KTORVdERfT0qB/PddMK7cORQK7YFro9LyfcxyMbRYkZvGeSwx9DxlN2cQD988LuW
        mj15ePfK82QYt5Q6W/sEW1gASNpJW+xXqE5y/SCc4HuUMSghFdskDKKPRZ+aPECWMJZe8qwmg1yam
        CWfrNtQST78HLH4fQBBa2Avo57H6JpUFx5vrB+Nj1mLHrKRgrU0yFA+r+DQekQ+WBRmGfHAyFilgg
        1nYKhPi35dIpQDupzXWS1o50yxhiGHAb8vMb7MGMzh5syD+4M8tSgZE5/nRG7MJ8T/D0LIKnYkxBE
        L1XzNZfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0lRy-0007nb-Is; Wed, 29 Jul 2020 12:44:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82D813011F0;
        Wed, 29 Jul 2020 14:44:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4174D203D0691; Wed, 29 Jul 2020 14:44:45 +0200 (CEST)
Date:   Wed, 29 Jul 2020 14:44:45 +0200
From:   peterz@infradead.org
To:     NeilBrown <neilb@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Minor RST rant
Message-ID: <20200729124445.GB2638@hirez.programming.kicks-ass.net>
References: <20200724132200.51fd2065@oasis.local.home>
 <20200724113325.44923f75@lwn.net>
 <20200724144234.3227b501@oasis.local.home>
 <877dusv5lc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dusv5lc.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 09:46:55AM +1000, NeilBrown wrote:

>  Constant names stand out least effectively by themselves.  In
>  kernel-doc comments they are preceded by a '%'.  Would that make the
>  text more readable for you?  Does our doc infrastructure honour that in
>  .rst documents?

It does not. It also still reads really weird.

And for some reason firefox chokes on the HTML file I tried it with, and
make htmldocs takes for bloody ever.

Give me a plain text file, please. All this modern crap just doesn't
work.
