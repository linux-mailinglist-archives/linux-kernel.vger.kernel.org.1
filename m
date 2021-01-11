Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC332F1884
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbhAKOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbhAKOna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:43:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9ACC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fwsrjpL/qcc2tmetrE74gAScuxLMD5oO3poGVVbN/1E=; b=lOEb2S50RyF2+UneQLLdOKvAtC
        FsdBdfBH/gvUeqkCU3GqpG4Cenr+9j5CcURU62uW9keSlZsObNOJh3Avyn+kraBtrfOoJGt8SnYJc
        w+VeqdJnaL5m5+97RIRBPRVG6xikrnSiUXuhrb3hbji+e8nZtBST1b2xOO3vmC0a0E7JvMfRp4clK
        PApCpdg/m8xDax5PsNNlw/RTyoax5LxJh4tMIgJUnq1evFp8nxWiVR2dj2F35n92ZZEq0c57+hrN2
        TmgCRRhjY3WifGBLOALV89INNMa+1Ky87hSaFQ0M67i+6XLc7YTj2/h9Y1JyxuvoL4mBkQm2EDL/P
        iyUQk36g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kyyOr-003NOQ-CM; Mon, 11 Jan 2021 14:42:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E85D304E03;
        Mon, 11 Jan 2021 15:42:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC5572BB730D6; Mon, 11 Jan 2021 15:42:28 +0100 (CET)
Date:   Mon, 11 Jan 2021 15:42:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, bristot@redhat.com, frederic@kernel.org
Subject: Re: lockdep splat in v5.11-rc1 involving console_sem and rq locks
Message-ID: <X/xj1HL8MuoFc7F+@hirez.programming.kicks-ass.net>
References: <20210105220115.GA27357@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105220115.GA27357@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 02:01:15PM -0800, Paul E. McKenney wrote:
> Hello!
> 
> The RUDE01 rcutorture scenario (and less often, the TASKS01 scenario)

Is:

  tools/testing/selftests/rcutorture/bin/kvm.sh --duration 10 --configs RUDE01 --allcpus

the right incantation?
