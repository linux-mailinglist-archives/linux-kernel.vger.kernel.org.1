Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE09298C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773925AbgJZLkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:40:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41156 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773910AbgJZLkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k3myULEFtog5AWC/ZKa5hJLaQTgjEDatFr9wR9ogfpo=; b=NuU1N7sN8NattmmlDC8V+bEd+l
        zfhZdRaZvHfaBPsfUKrp9qaC6tt+N3brens4A/LsYDP4Z0om3Kbwc7dxeqMVN2AlPpfMM2rwrlTkS
        LNf768HPO4jP2dDNcWvlCTAmMmxtdKkWBcppfP1fqQ4eCjlkJazAxZiAyKz8fndNkCCHqvD0yy0lX
        Xc5waFkHH7ky9Ss13la9z7EQ1ON52GBv1QyqWx5sOCQh3E1ifK9u5/HguoELPwpzQdBLLi/DXGXbj
        MJrF7j84cYhUyINJcsVB4/niMRlJiA4tuiD+rzvzNIwsPaCfzrISQFJtkKzTb22VmCNYwhqZF2+0G
        XR72hLow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX0rF-0005tu-7c; Mon, 26 Oct 2020 11:40:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE09F302526;
        Mon, 26 Oct 2020 12:40:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA5342B411E57; Mon, 26 Oct 2020 12:40:09 +0100 (CET)
Date:   Mon, 26 Oct 2020 12:40:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>
Subject: Re: possible lockdep regression introduced by 4d004099a668
 ("lockdep: Fix lockdep recursion")
Message-ID: <20201026114009.GN2594@hirez.programming.kicks-ass.net>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 11:26:49AM +0000, Filipe Manana wrote:
> Hello,
> 
> I've recently started to hit a warning followed by tasks hanging after
> attempts to freeze a filesystem. A git bisection pointed to the
> following commit:
> 
> commit 4d004099a668c41522242aa146a38cc4eb59cb1e
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Fri Oct 2 11:04:21 2020 +0200
> 
>     lockdep: Fix lockdep recursion
> 
> This happens very reliably when running all xfstests with lockdep
> enabled, and the tested filesystem is btrfs (haven't tried other
> filesystems, but it shouldn't matter). The warning and task hangs always
> happen at either test generic/068 or test generic/390, and (oddly)
> always have to run all tests for it to trigger, running those tests
> individually on an infinite loop doesn't seem to trigger it (at least
> for a couple hours).
> 
> The warning triggered is at fs/super.c:__sb_start_write() which always
> results later in several tasks hanging on a percpu rw_sem:
> 
> https://pastebin.com/qnLvf94E
> 
> What happens is percpu_rwsem_is_held() is apparently returning a false
> positive,

That smells like the same issue reported here:

  https://lkml.kernel.org/r/20201022111700.GZ2651@hirez.programming.kicks-ass.net

Make sure you have commit:

  f8e48a3dca06 ("lockdep: Fix preemption WARN for spurious IRQ-enable")

(in Linus' tree by now) and do you have CONFIG_DEBUG_PREEMPT enabled?




