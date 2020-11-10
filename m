Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830742AD70F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgKJND6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbgKJND5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:03:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6D6C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fp7D+Rk1gLctsTUwetXl8upRlcZipYf0vD5R4+hKV0M=; b=Wb0kyjvffOMslQMoTbAl+UlVaX
        0aWnay1Ll8eC01J959isieyKksAa8ZQRfrda8aP6KjB098GDWGLhpR7mIQO6GUiGBxv1Z9beXVD7I
        zqzts4RtXpVOwgHHkXY7vrWWaBx5Lza89PPh0HXI9schtfRIoBpUV8J/YD8sMYIYi9MXUodq+pzir
        ynRzukDMGnfnGy26eQv0T8/jmUwujxBp9tv6dxtsKGpWx/lX61WmcbXotX1qQpk788r0BJVbxMkrs
        ys5TGlDx8ILat9+/qfjPk0ho/n+H5BTQrzD7rQSEi+CjBFmkrnzv/XlCFbMr2FU5fc4Q1sLrVs186
        NfdNF87A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcTJO-0002Xd-Or; Tue, 10 Nov 2020 13:03:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1307A301E02;
        Tue, 10 Nov 2020 14:03:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5B952BA1DD1B; Tue, 10 Nov 2020 14:03:48 +0100 (CET)
Date:   Tue, 10 Nov 2020 14:03:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 0/2] arm64: Allow the rescheduling IPI to bypass
 irq_enter/exit
Message-ID: <20201110130348.GK2594@hirez.programming.kicks-ass.net>
References: <20201101131430.257038-1-maz@kernel.org>
 <jhjsg9syrs5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjsg9syrs5.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 10:30:50AM +0000, Valentin Schneider wrote:

> Now, I'd like to pen exactly why we think it's okay to forgo irq_{enter,
> exit}() for that one IRQ and not any other.

Thomas already said a few words on this, but basically scheduler_ipi()
is a NOP (*almost*), the IPI has no body. All it does is tickle the
return-from-interrupt path. So any setup and tear-down done for the
non-existing body is a waste of time.


