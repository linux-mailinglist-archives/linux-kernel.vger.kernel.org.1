Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2686D2A5604
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbgKCVYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgKCVYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:24:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606C1C0613D1;
        Tue,  3 Nov 2020 13:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OTpGkkPVLBqbuJKuUynXBJXRcpvpXyRlR7kNaipl1g0=; b=a+KaNNfb2mVrCm1dq9NVVz+odZ
        dvqawNcTbxQSpsvdaZ8nL6kisjevYihXuUJF2z4lP92tQqlv/LhumY0XjYepewKztLrOD0zRcjwLX
        euBLlfQCduNg9c3F/XONx14QVIzRmq+lO9t3G3MkaXRkuw4VYwO3YHrmTtsxe9kBJ6Y6QvH2Ll4Wl
        xIoPa44txA/PG3m06s1qOSiTbA0dxjGTtbUDK8kAyFXbma4mx3qc/v/VXiRZnZJnLBdhZ10mRRE6Z
        rbWXMIPJSWPo7uL81/qrQuZ3aD7TcsORr59fNVxxMevMOz1tiB0mpj44uR0tmBRnBhzy8KcfjdN/1
        ZHegQFNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ka3n6-00010w-DI; Tue, 03 Nov 2020 21:24:32 +0000
Date:   Tue, 3 Nov 2020 21:24:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [GIT PULL] Docs-build warning fixes for 5.10-rc3
Message-ID: <20201103212432.GI27442@casper.infradead.org>
References: <20201103124420.46bf5a37@lwn.net>
 <CAHk-=wghhw0SpqSKKUqt5eum=UfLD3Qa0suoRxLy_cJc4hChug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wghhw0SpqSKKUqt5eum=UfLD3Qa0suoRxLy_cJc4hChug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:18:27PM -0800, Linus Torvalds wrote:
> On Tue, Nov 3, 2020 at 11:44 AM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > This pull contains a series of warning fixes from Mauro; once applied, the
> > number of warnings from the once-noisy docs build process is nearly zero.
> > Getting to this point has required a lot of work; once there, hopefully we
> > can keep things that way.
> 
> I wonder if it is quiet enough that we could make new doc build noise
> trigger some kind of linux-next warning?

We can move checkdoc out of W=1 ... something like this?

+++ b/scripts/Makefile.build
@@ -103,9 +103,7 @@ else ifeq ($(KBUILD_CHECKSRC),2)
         cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
 endif
 
-ifneq ($(KBUILD_EXTRA_WARN),)
-  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
-endif
+cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
 
 # Compile C sources (.c)
 # ---------------------------------------------------------------------------

although people might whinge if it increases kernel build time noticably
(I haven't checked if it does).

It won't catch all the things that actually running Sphinx will, but
it catches the common things (forgot to update the docs after changing a
function parameter, for example)
