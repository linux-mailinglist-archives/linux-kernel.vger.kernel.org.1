Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30902B5C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgKQKAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgKQKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:00:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CE7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sJWlIJf2Pt4tnjPJDlQRhe8ivTuZU0+s+pSU+BozkHA=; b=LF6k8N4mzA0pTMgRv3lmY/Ey4q
        AGIrti2W6EZ9Uy/Qt5md9YKM/pY5rkk5ivFVLGW3dqReurUueIwJeA9izUsXi1IwnoEn/5y0GppPG
        dzynQ78PZNzlaQngN3CCD9ZEqH36H8rzlB3fG4cSR5sooxnvpgmMM2IHiye6QUEfpaGcOW9LKrwLr
        PK7fJHkoOHmdFOfgQOr8zPy+AWok1Gew/v/l3iZZ9Gp8hRJFAj8tgf5viV2D+HMFN4NaC3dQfea7h
        SHrMi4DsoYgQcvM7zhfetHXMfHZGeyMQQdzV0h6OLNb6RswkPQOpsA4GGQK7r2ucGXhQ1CuPh260X
        49H5mmIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kexmd-0003xs-EN; Tue, 17 Nov 2020 10:00:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B795C3012DC;
        Tue, 17 Nov 2020 11:00:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9ECDB20116732; Tue, 17 Nov 2020 11:00:17 +0100 (CET)
Date:   Tue, 17 Nov 2020 11:00:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH 0/4] x86/xen: do some paravirt cleanup
Message-ID: <20201117100017.GB3121406@hirez.programming.kicks-ass.net>
References: <20201116152301.24558-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116152301.24558-1-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 04:22:57PM +0100, Juergen Gross wrote:
> Eliminate the usergs_sysret64 paravirt call completely and switch
> the swapgs one to use ALTERNATIVE instead. This requires to fix the
> IST based exception entries for Xen PV to use the same mechanism as
> NMI and debug exception already do.
> 
> Juergen Gross (4):
>   x86/xen: use specific Xen pv interrupt entry for MCE
>   x86/xen: use specific Xen pv interrupt entry for DF
>   x86/pv: switch SWAPGS to ALTERNATIVE
>   x86/xen: drop USERGS_SYSRET64 paravirt call

Looks 'sane' :-))

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
