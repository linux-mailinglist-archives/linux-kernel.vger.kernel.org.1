Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F611A849D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391446AbgDNQYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391400AbgDNQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:22:50 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A3CC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q6C07mXJ/zBdy1ZUQCuoEcuxb0ss9+96s0LP3Iuz92A=; b=R65maa+YqBPB8wCgLqP7ZulH82
        cpzMeNwaqgkP7izwqlZ9iJGdzqJ6a1t0zfnTBG7Pl4/GFIGLWcHalwbNQJTu5zBDQ1o0DrRyCNDvT
        83t8d5VI8X7A6epXWEwXZWkicLGrKkdkDFIaqFLaxNHKsEka1i/e8HZXYdtiH432OyF+vVWXHwdPO
        y8St66cW6CvnLZ3NApn2VUZDr6Av0oLc/7rqlgksrsvyIELJNadjh7AdQyXL32BWYmy+XAsXcOHww
        9q4fYsVkdEBEG6JBxrJ+QfQJzjDc/FkrDxDoz38aBhoBxJvsdXIV+CL7XB4URGAoOm249RWzgmkSp
        /4qCaP7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOOKO-0007SV-Hu; Tue, 14 Apr 2020 16:22:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA147306089;
        Tue, 14 Apr 2020 18:22:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A555D2038BC5A; Tue, 14 Apr 2020 18:22:21 +0200 (CEST)
Date:   Tue, 14 Apr 2020 18:22:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: microcode: fix return value for microcode late
 loading
Message-ID: <20200414162221.GQ20713@hirez.programming.kicks-ass.net>
References: <1586858135-29337-1-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586858135-29337-1-git-send-email-mihai.carabas@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:55:35PM +0300, Mihai Carabas wrote:
> The return value from stop_machine might not be consistent.
> 
> stop_machine_cpuslocked returns:
> - zero if all functions have returned 0
> - a non-zero value if at least one of the functions returned
> a non-zero value
> 
> There is no way to know if it is negative or positive. So make
> __reload_late return 0 on success, or negative otherwise.
> 
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>

Isn't the right fix to disable late-loading?
