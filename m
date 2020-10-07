Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08994286796
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgJGSnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:43:03 -0400
Received: from verein.lst.de ([213.95.11.211]:38229 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJGSnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:43:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0B5C168B05; Wed,  7 Oct 2020 20:42:59 +0200 (CEST)
Date:   Wed, 7 Oct 2020 20:42:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: Re: use case for register_pstore_blk?
Message-ID: <20201007184258.GA6157@lst.de>
References: <20201006155220.GA11668@lst.de> <202010070007.8FF59EC42@keescook> <20201007075537.GA12531@lst.de> <20201007083715.GA15695@lst.de> <202010071130.7EA00291@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010071130.7EA00291@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem with the block code is that it is completely broken.
It uses on-stack structures where it can't, it pokes into internals
of the block device read/write path for absolutely not reason, and
it uses name_to_dev_t which must not be used in new code.

Or in other words: it is a complete piece of crap full of layering
violations that should never have been merged in that form.

It also does not happen to share code with the mtd case.

On Wed, Oct 07, 2020 at 11:40:36AM -0700, Kees Cook wrote:
> On Wed, Oct 07, 2020 at 10:37:15AM +0200, Christoph Hellwig wrote:
> > Looking at this more:  in addition to the block code being totally
> > broken, there is really no point in mtdpstore even using this code.
> > It does nothing but minimal parameter validation to just pass it
> > on to the pstore zone interface.  IMHO writing the mtd code directly
> > to the zone interface makes a whole lot more sense even if we grow
> > a non-broken block backend at some point.  Something like this:
> 
> I really don't like this, sorry. I'm using the pstore/blk bits myself
> already, and I don't want that removed. Additionally I really don't want
> the structures open-coded in the MTD driver. The whole point was to
> encapsulate it. I've spent a lot of time clawing pstore back from the
> brink of open-coded argument and member explosion. :)
> 
> I'm fine to drop the exported register_pstore_blk() API until someone
> actually uses it, but I want to keep pstore/blk itself and the existing
> separation between pstore backing devices and pstore storage logic so
> that configuration happens at the storage level, not the backing device
> level. My intent, for example, is to migrate ramoops to pstore/zone,
> etc, and remove all the ramoops-specific configuration which is common
> to pstore/zone.
> 
> -- 
> Kees Cook
---end quoted text---
