Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7500F1B12F1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 19:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgDTR1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 13:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726081AbgDTR1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:27:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1379DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:27:15 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQaCJ-00035u-5q; Mon, 20 Apr 2020 19:27:07 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8C56C101623; Mon, 20 Apr 2020 19:27:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [patch 00/15] x86/tlb: Unexport per-CPU tlbstate
In-Reply-To: <20200420092045.GC24518@infradead.org>
References: <20200419203137.214111265@linutronix.de> <20200420092045.GC24518@infradead.org>
Date:   Mon, 20 Apr 2020 19:27:06 +0200
Message-ID: <87sggyax05.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:
> Just looking over some exports at the end of the series (and thus
> ignoring bisection issues):
>
>  - Is there any good reason to keep __flush_tlb_all inline vs moving it
>    out of line and kill the flush_tlb_local and flush_tlb_global exports.
>    Also there is just a single modular users in SVM, I wonder if there is
>    any way to get rid of that one as well.

I'll have a look again.

> Also I think cpu_tlbstate itself could be marked static in tlb.c with
> a few more changes, I wonder if would be worth it?

Unfortunately it can't. We need it in the low level entry code due to
PTI and solving that would be a messy surgery.

Thanks,

        tglx


