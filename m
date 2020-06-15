Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE961F94DC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 12:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgFOKr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgFOKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:47:25 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7CBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UYG8iL47fsRoRKjxPoG9NBoov4V0eZBJOPZR2/0HGqQ=; b=1TSKnUTasfM1qZ5paxJKFtDT6h
        OFyYY6neCc9p1kybx5xi/z/zW9yVgb4JkvQspgLmaIT/IHpL+ynqmz8z/6ihlNrvDas1BGPV4EA3a
        uVd/y4KZKfHGjwwF1hQzWI93+KJYASnp+z18yVnV6UrJwQ4trtOV8NFJJ6u+tGzejMbDNPG1pbhzi
        22IDSND4en850ae8qL4TmybLogrbmzI+pdmkANmI8wwfBvCAei0Atn/LiYS4IWfmrwtLPfSOg2n9V
        w/sZiIMc6zyI6Vc/stiayhEnhc3saIjthcSURHixGU2vrVsh14l0Hv+obM+nVSKG54HYPUywdl/LD
        s6hAMtMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkmds-0000yp-NT; Mon, 15 Jun 2020 10:47:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96C643010C8;
        Mon, 15 Jun 2020 12:47:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7875920705C4E; Mon, 15 Jun 2020 12:47:02 +0200 (CEST)
Date:   Mon, 15 Jun 2020 12:47:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Free memory in error case in special_get_alts
Message-ID: <20200615104702.GN2497@hirez.programming.kicks-ass.net>
References: <20200612115628.8992-1-tklauser@distanz.ch>
 <alpine.LSU.2.21.2006151238390.5945@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2006151238390.5945@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 12:40:32PM +0200, Miroslav Benes wrote:
> Hi,
> 
> On Fri, 12 Jun 2020, Tobias Klauser wrote:
> 
> > Avoid a memory leak in case get_alt_entry returns an error.
> 
> yes, this is not the only one, but I doubt we want to spend time on that. 
> The process is about to exit anyway.

Right, that's just wasting cycles.
