Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D58259239
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 17:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgIAPGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 11:06:16 -0400
Received: from verein.lst.de ([213.95.11.211]:53698 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgIAPF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:05:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90CCB68B05; Tue,  1 Sep 2020 17:05:53 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:05:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200901150553.GA30034@lst.de>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com> <20200901140208.GA95447@C02TD0UTHF1T.local> <20200901144641.GA28580@lst.de> <20200901145442.GC95447@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901145442.GC95447@C02TD0UTHF1T.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 03:54:42PM +0100, Mark Rutland wrote:
> On Tue, Sep 01, 2020 at 04:46:41PM +0200, Christoph Hellwig wrote:
> > On Tue, Sep 01, 2020 at 03:02:08PM +0100, Mark Rutland wrote:
> > > One thing to consider is whether you need a speculation barrier after
> > > set_fs(). Otherwise for code like:
> > 
> > FYI, at least for x86 and powerpc I have a pending series to kill
> > set_fs().  I'd love to see someone help with the arm/arm64 side, otherwise
> > I'll try to get to it eventually.
> 
> Is there anything in particular that's tricky, or do you just want
> someone to look generally? From a quick grep arch/arm64/* looks clean, but
> I suspect that's misleading.

Yes, it should be mostly trivial.  I just bet the maintainers are
better at optimizing the low-level assembly code with the variable
address limit gone than I am.  (See Linus comments on the x86 version
for example).  And I don't have a physical arm64 to test with so I'd
have to rely on qemu for any testing.
