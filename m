Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD852E0A80
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgLVNNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:13:19 -0500
Received: from verein.lst.de ([213.95.11.211]:58979 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgLVNNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:13:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B372B67373; Tue, 22 Dec 2020 14:12:34 +0100 (CET)
Date:   Tue, 22 Dec 2020 14:12:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joe Perches <joe@perches.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, apw@canonical.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-doc <linux-doc@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] checkpatch: make the line length warnings match the
 coding style document
Message-ID: <20201222131234.GA29028@lst.de>
References: <20201210082251.2717564-1-hch@lst.de> <c3f1d9de2e5a61588f64e69a1309968d84a2dd12.camel@perches.com> <20201210200930.GB7338@casper.infradead.org> <4898c0c03d370a23b1b98ddabb72e70ec8d430fa.camel@perches.com> <93a470c7631d2607e7b2a12e9cc5d8e930911989.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93a470c7631d2607e7b2a12e9cc5d8e930911989.camel@perches.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 08:08:20PM -0800, Joe Perches wrote:
> On Thu, 2020-12-10 at 13:27 -0800, Joe Perches wrote:
> > On Thu, 2020-12-10 at 20:09 +0000, Matthew Wilcox wrote:
> > > On Thu, Dec 10, 2020 at 12:05:04PM -0800, Joe Perches wrote:
> > > > Also, given the ever increasing average identifier length, strict
> > > > adherence to 80 columns is sometimes just not possible without silly
> > > > visual gymnastics.  The kernel now has quite a lot of 30+ character
> > > > length function names, constants, and structs.
> > > 
> > > maybe checkpatch should warn for identifiers that are 30+ characters
> > > long?  address the problem at its source ..
> > 
> > Hard to know when to warn as patches could just add uses of already
> > existing names and emitting warnings for those would just be annoying.
> > 
> > Maybe something that tests long identifier additions of
> > defines/functions/macros/structs but not their uses and maybe only
> > then in patches and not files.
> > 
> > Perhaps:
> 
> Anyone care that this should be added or not added to checkpatch?

It is pretty useless.  What we need is a patch that doesn't make people
uselessly add overly long lines against the intent of the coding style
document.  I have submitted a pretty reasonable one, and I'm open to
alternatives, but we need to to stop people submitting code that does
not fit the coding style all the time because checkpatch doesn't
complain.
