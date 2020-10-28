Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51D629D372
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgJ1VoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:44:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59426 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgJ1VoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mI2WYUQDlxt9wNuhgFUC5l938OqTLaXsqw+0bIu6msA=; b=1nUL8dcFrzQZdDDHvDb6PHaByL
        d7q8TcZ71VPepHPpPgbWyNHpqHre+vXlsiS1Eu9+VcWb8S4S9uyWq7i9WHvg1CaqTYixeVRGJCBs8
        wD6+Y/4Y6qnnDrHJxeElbsmBIZJkQh2M0pQp9xytMw/3vLjlT1u7OzvxYkXYb0BOYEcudsdX7xiXF
        w79cxCdmKfwkVNMZRuz/tcCkQT3eBXWJm2GjbJGH+YlCr5j7RqfZfqDhQ+9Wv0kKX7u8oQNKDJUTq
        b6GlXGh3Y1MC05SNjjIZBFJV2b7feWQaVXac9fQ4tDCzEtgN7PhucBkSFnhte3i8G95/R13D7OEme
        k06EZTiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXhDb-0005I9-K9; Wed, 28 Oct 2020 08:54:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95C973006D0;
        Wed, 28 Oct 2020 09:54:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C58B2C5FEB42; Wed, 28 Oct 2020 09:54:05 +0100 (CET)
Date:   Wed, 28 Oct 2020 09:54:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Drop RDPID macro to discourage use of RDPID in the
 kernel
Message-ID: <20201028085405.GW2628@hirez.programming.kicks-ass.net>
References: <20201027214532.1792-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027214532.1792-1-sean.j.christopherson@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 02:45:32PM -0700, Sean Christopherson wrote:
> Drop the GAS-compatible RDPID macro as RDPID shouldn't be used in the
> kernel, excepting the vDSO, which handcodes RDPID in inline asm.  RDPID
> is unsafe in the kernel because KVM loads guest's TSC_AUX on VM-entry
> and may not restore the host's value until the CPU returns to userspace.
> 
> See commit 6a3ea3e68b8a ("x86/entry/64: Do not use RDPID in paranoid
> entry to accomodate KVM") for details.

Well, remove it because there is no (current) user, OK. But if there's a
compelling kernel side use for it, KVM can go suck rocks.
