Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981C025BB46
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 08:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgICG4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 02:56:19 -0400
Received: from verein.lst.de ([213.95.11.211]:36552 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgICG4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 02:56:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E465068BEB; Thu,  3 Sep 2020 08:56:13 +0200 (CEST)
Date:   Thu, 3 Sep 2020 08:56:13 +0200
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
Message-ID: <20200903065613.GA18731@lst.de>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com> <20200901140208.GA95447@C02TD0UTHF1T.local> <20200901144641.GA28580@lst.de> <20200901145442.GC95447@C02TD0UTHF1T.local> <20200901150553.GA30034@lst.de> <20200901154629.GA882@lst.de> <20200902114348.GA1002@C02TD0UTHF1T.local> <20200902133231.GA32133@lst.de> <20200902172330.GB1002@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902172330.GB1002@C02TD0UTHF1T.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 06:23:30PM +0100, Mark Rutland wrote:
> I've pushed an initial/incomplete/WIP stab (just the kernel accessors)
> to:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/set_fs-removal

Thanks!

> ... and doing that made it clear that the necessary arm64 rework is a
> bit more fractal than I thought (e.g. SDEI bits), so it might be a short
> while before I post a series.

SDEI is just forcing back a KERNEL_DS to a normal USER_DS, isn't it?

> 
> It might be handy to have a stable branch with the common bits so that
> the arm64 rework could go via the arm64 tree in case there's any
> fallout.

The series will need at least one more repost, but hopefully I'll have
s stable branch soon.
