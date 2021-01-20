Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A602FD937
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392385AbhATTM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbhATTMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:12:16 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18606C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:11:33 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2Isu-003wj0-9O; Wed, 20 Jan 2021 19:11:16 +0000
Date:   Wed, 20 Jan 2021 19:11:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Splicing to/from a tty
Message-ID: <20210120191116.GC740243@zeniv-ca>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
 <20210118193457.GA736435@zeniv-ca>
 <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
 <20210118195400.GC736435@zeniv-ca>
 <20210120162608.GB740243@zeniv-ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120162608.GB740243@zeniv-ca>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 04:26:08PM +0000, Al Viro wrote:

> [1] yes, it is possible to have O_APPEND opened pipes - open a FIFO with
> O_APPEND and you've got it.  We are not quite consistent in handling
> those - sendfile() to such is rejected, splice() is not.

BTW, according to manpages of splice(2) and sendfile(2), we have
       EINVAL [snip] target file is opened in append mode [snip]
and
       EINVAL out_fd has the O_APPEND flag set.  This is not currently supported by sendfile().

However, splice(2) to FIFO opened with O_APPEND works just fine.  So
it doesn't match the manpage either.

Why do we care about O_APPEND on anything without FMODE_PWRITE (including
pipes), anyway?  All writes there ignore position, after all...
