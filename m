Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E2C259186
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 16:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgIAOwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 10:52:21 -0400
Received: from foss.arm.com ([217.140.110.172]:42742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgIAOwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:52:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37FE41045;
        Tue,  1 Sep 2020 07:52:09 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.10.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 246CA3F71F;
        Tue,  1 Sep 2020 07:52:05 -0700 (PDT)
Date:   Tue, 1 Sep 2020 15:52:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200901145203.GB95447@C02TD0UTHF1T.local>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <20200901140208.GA95447@C02TD0UTHF1T.local>
 <20200901142158.fo7tecobgki5hffa@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901142158.fo7tecobgki5hffa@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 09:21:58AM -0500, Josh Poimboeuf wrote:
> On Tue, Sep 01, 2020 at 03:02:08PM +0100, Mark Rutland wrote:
> > d instead do user pointer
> > > masking, throughout the x86 uaccess code.  This is similar to what arm64
> > > is already doing.
> > > 
> > > barrier_nospec() is now unused, and can be removed.
> > 
> > One thing to consider is whether you need a speculation barrier after
> > set_fs(). Otherwise for code like:
> > 
> > | fs = get_fs();
> > | if (cond)
> > |	set_fs(KERNEL_DS);
> > | copy_to_user(...)
> > | set_fs(fs)
> > 
> > ... the set_fs() can occur speculatively, and may be able to satisfy
> > the masking logic if forwarded within the cpu.
> > 
> > See arm64 commit:
> > 
> >   c2f0ad4fc089cff8 ("arm64: uaccess: Prevent speculative use of the current addr_limit")
> 
> Do you have any examples of that conditional set_fs(KERNEL_DS) pattern?
> I wasn't able to find any.

I'm afraid not -- we used to in arm64 in some memory dump code, but that
is now gone. It might be that this is no longer necessary.

If set_fs() goes entirely, that's even better...

Thanks,
Mark.
