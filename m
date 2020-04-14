Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D21A8CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 22:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633370AbgDNUsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 16:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729251AbgDNUr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:47:56 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C48C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x/ZHKyopRWpGoE5or87zVjBqHsy00autP4YjoXBOFt4=; b=0vMH94ZqgvoFZ370/AwwqWO9kz
        gcsxZanJ1zhyZUQQ7qZCywIeJRSeXAxCh8lsKrf8GsJzJpE+bTb/3hRzbaYAXdWdP3ts7ctO777DE
        MpPFOvTjKUdqrY5JUwofxlt7i9U5LSkLDr0V73pCgz03F5h2QxmVPVsqH98rlbcxwfrtVU6LE8UWj
        sYg8uPAPKgqtBgJc0/iGQWnTUP3BCSBhmwcxrsfjYc9VP1hImyOtP/wOvmefnPx2T53u7+2pKWwEC
        sSlXjdWGptckv6gj9XPu+bPX8eR35tj7ozdsawz38mvZyuvpc5+EZBn9Em+U+OUSElsNEwJz2pDMt
        iTXUGLdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOSSy-0005nq-20; Tue, 14 Apr 2020 20:47:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7352F980FA9; Tue, 14 Apr 2020 22:47:29 +0200 (CEST)
Date:   Tue, 14 Apr 2020 22:47:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Helsley <mhelsley@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC][PATCH 00/36] objtool: Make recordmcount a subcommand
Message-ID: <20200414204729.GJ2483@worktop.programming.kicks-ass.net>
References: <cover.1586468801.git.mhelsley@vmware.com>
 <3a3f70df-07b0-91d9-33e1-e997e72b0c5c@redhat.com>
 <20200414093506.7b91bbbb@gandalf.local.home>
 <064f41bd-0dfe-e875-df7c-214184c29fa7@redhat.com>
 <20200414115458.093e221b@gandalf.local.home>
 <20200414200910.GB118458@rlwimi.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414200910.GB118458@rlwimi.vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 01:09:10PM -0700, Matt Helsley wrote:
> I also noticed that, for example, sorttable uses the same ELF code /
> patterns as recordmcount -- like the double-include trick. Of course
> it operates on a larger scale than per-object-file and so there might
> only be code maintenance savings there...

I'm >< close to having objtool run on vmlinux in the link stage too :-)
