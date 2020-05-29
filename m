Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30491E8A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 23:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgE2Vp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 17:45:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55476 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgE2Vpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RNuAZkRuWdbMfqnpvN7spk0s8Bbmz59zdmfGiC6+E4g=; b=vaz+sD1Cyird0t3NvpnMaViBZE
        lpOHWi0O2xQPOUNArQgbtNl3NxU2BAR+jmY0Q0sWCO62a81Iy1/AlHiznI8q5bbNbwt2HyF6KPsOm
        Cn7RrPBmYIpB/jZL/972e+qHjTboxvdIQG1aj6m45T283MBep6QD1EtT/E5bQ+eEyvA18JlsWrXCr
        D4RB8B4Hb8vKwYsAZRzCmSo89XVCjgIjK4FKMK/T3XyHvBH/FMj/7orkFy+n8PHwpUZUdY7UWQBlT
        34uq51a9n66Ao4ve+YzqFEJWHl7Fj9BmU5h/fhLTJ0NkbmLmyiILYVeK2jVw7ftp7JMIgY7FtBNv5
        Ywvn8fdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemmJ-0007TF-Ue; Fri, 29 May 2020 21:43:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21F203011FF;
        Fri, 29 May 2020 23:42:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CB10F2B9B1BC4; Fri, 29 May 2020 23:42:57 +0200 (CEST)
Message-ID: <20200529213550.683440625@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:35:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 0/5] lockdep: Change IRQ state tracking to use per-cpu variables
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmed and Sebastian wanted additional lockdep_assert*() macros and ran
into header hell.

Move the IRQ state into per-cpu variables, which removes the dependency on
task_struct, which is what generated the header-hell.

These patches are intended to go on top of:

 https://lkml.kernel.org/r/20200529212728.795169701@infradead.org

but should apply on current tip/master without much difficulty.

There are a few build fixes for Sparc64, PowerPC64 and s390. Especially the
Sparc one I'm not sure about.

