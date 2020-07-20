Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A538D225BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 11:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgGTJdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 05:33:23 -0400
Received: from verein.lst.de ([213.95.11.211]:46152 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgGTJdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:33:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 14CAB68C4E; Mon, 20 Jul 2020 11:33:20 +0200 (CEST)
Date:   Mon, 20 Jul 2020 11:33:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/23] seq_file: switch over direct seq_read method
 calls to seq_read_iter
Message-ID: <20200720093319.GA18123@lst.de>
References: <20200707174801.4162712-1-hch@lst.de> <20200707174801.4162712-16-hch@lst.de> <87eep9rgqu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eep9rgqu.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 11:09:13PM +0200, Thomas Gleixner wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > Switch over all instances used directly as methods using these sed
> > expressions:
> >
> > sed -i -e 's/\.read\(\s*=\s*\)seq_read/\.read_iter\1seq_read_iter/g'
> 
> This sucks, really. I just got a patch against this converting the
> changed version to DEFINE_SHOW_ATTRIBUTE(somefile) and thereby removing
> the whole open coded gunk.

The changed version of what?

> If we do a tree wide change like this, then can we pretty please use a
> coccinelle script to convert all trivial instances to use
> DEFINE_SHOW_ATTRIBUTE so we don't have to touch the same place over and
> over.

I'm not going to complain about that if someone offers a script
for that.
