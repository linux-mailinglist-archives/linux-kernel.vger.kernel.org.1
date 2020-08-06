Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84D23D701
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 08:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgHFGsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 02:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgHFGsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 02:48:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84CDC061574;
        Wed,  5 Aug 2020 23:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0ETtt3bGMW4XUze5AkKh67V3N6Iw1g4CzmBpAFLh8dA=; b=LOGJ0PUyOjZnOZ6qc8Gbcev0hM
        nGf4lIqxQMzNZJSOHwUvWg1h8K8UgxSgcVRfGOxT4q6ry9ij9JdSqbLtCvjxKlLZ63dWBKIE/0dMh
        gbOcqmzPuSeU8P/Vv2nPxzZ6h6s4mSIAMHrYHJsZWLaQoSE1W4p1F2MOmyo/P7aO9Cp9bPWhzHYgs
        QvFsEeXdQoGtxe0X8ZEsVuU5dIlEArBlUzMBV+COpY6H+BsBvce4wOSV3BgoozGc3vqbtZFEgaGbB
        OuEVL3rH0Asa2Y9fgK9dnmTDWiYc11Dbsaq9pbdQWiweknpTqAY/eZI7FrIXSSd1R2HRgezDNBNdr
        qq0MBRaQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3ZhP-0002MU-JT; Thu, 06 Aug 2020 06:48:23 +0000
Date:   Thu, 6 Aug 2020 07:48:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     peterz@infradead.org
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        NeilBrown <neilb@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Minor RST rant
Message-ID: <20200806064823.GA7292@infradead.org>
References: <20200724132200.51fd2065@oasis.local.home>
 <20200724113325.44923f75@lwn.net>
 <20200724144234.3227b501@oasis.local.home>
 <877dusv5lc.fsf@notabene.neil.brown.name>
 <20200729124445.GB2638@hirez.programming.kicks-ass.net>
 <1e60ff85-4965-92cb-e50b-8ea9ccf6788e@oracle.com>
 <20200805151230.GT2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805151230.GT2674@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 05:12:30PM +0200, peterz@infradead.org wrote:
> On Wed, Aug 05, 2020 at 04:49:50PM +0200, Vegard Nossum wrote:
> > FWIW, I *really* like how the extra markup renders in a browser, and I
> > don't think I'm the only one.
> 
> The thing is, I write code in a text editor, not a browser. When a
> header file says: read Documentation/foo I do 'gf' and that file gets
> opened in a buffer.
> 
> Needing a browser is a fail.

And that is my main problem with all the RST craze.  It optmizes for
shiny display in a browser, but copletely messed up the typical
developer flow.
