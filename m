Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA562859A2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgJGHhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:37:42 -0400
Received: from verein.lst.de ([213.95.11.211]:36452 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgJGHhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:37:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4B76C6736F; Wed,  7 Oct 2020 09:37:39 +0200 (CEST)
Date:   Wed, 7 Oct 2020 09:37:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: use case for register_pstore_blk?
Message-ID: <20201007073739.GA11745@lst.de>
References: <20201006155220.GA11668@lst.de> <202010070007.8FF59EC42@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010070007.8FF59EC42@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 12:13:27AM -0700, Kees Cook wrote:
> On Tue, Oct 06, 2020 at 05:52:20PM +0200, Christoph Hellwig wrote:
> > Hi WeiXiong, hi Kees,
> > 
> > what is the use case for the code added in commit 17639f67c1d6 
> > ("pstore/blk: Introduce backend for block devices").
> > 
> > This still doesn't have a user, and the API looks really odd to me.
> 
> pstore is a beast. :) The API is there so that a blk device can declare
> its direct support of pstore (specifically, to provide a panic_write
> handler).
> 
> The MTD device does this, but yes, that's a good point, there isn't a
> blk device user of that entry point yet.
> 
> > By our normal kernel rules we should not add new exports without
> > users and this should probably be reverted for the 5.9 release.
> 
> I don't want to revert the entire patch (I'm still using
> __register_pstore_blk by way of pstore/blk's "best_effort" option), but
> I wouldn't object to something like this:

That is a minimum.  But the MTD support is also completely and
utterly broken as well, by declaring on-stack struct file and
struct file_operations instances instead of actually reusing the
block layer code.  This kind of stuff really needs more coordination
with the block layer and maintainers instead of the crap that ended
up being merged.
