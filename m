Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7032FAAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437795AbhART4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393997AbhARTyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:54:47 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B655C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:54:07 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1abA-0036Xa-LY; Mon, 18 Jan 2021 19:54:00 +0000
Date:   Mon, 18 Jan 2021 19:54:00 +0000
From:   Al Viro <viro@zeniv-ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Splicing to/from a tty
Message-ID: <20210118195400.GC736435@zeniv-ca>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
 <20210118193457.GA736435@zeniv-ca>
 <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:46:42AM -0800, Linus Torvalds wrote:
> On Mon, Jan 18, 2021 at 11:35 AM Al Viro <viro@zeniv-ca> wrote:
> >
> > I'd rather have sendfile(2) do what splice(2) does and handle pipes
> > directly.  Let me take a look,,,
> 
> It's not technically just the sendfile() thing. Some things do
> sendfile "internally" (ie they use do_splice_direct()).
> 
> Although maybe they always happen just on non-pipe destinations (ie
> file-to-file copy). I didn't check.
> 
> But particularly if it can be handled in do_splice_direct(), that
> would be a good thing.

FWIW, it might make sense to merge do_splice_direct() and do_splice();
interfaces are very similar and do_splice() is basically
	if both are pipes
		....
	else if input is pipe
		....
	else if output is pipe
		....
	else
		return -EINVAL
with do_splice_direct() being fairly close to the missing case.
