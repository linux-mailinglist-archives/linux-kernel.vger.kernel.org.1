Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978AA2FDDE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393075AbhAUA2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404091AbhATXYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:24:18 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65512C061342
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:03:23 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2MV4-0041GW-6h; Wed, 20 Jan 2021 23:02:54 +0000
Date:   Wed, 20 Jan 2021 23:02:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Splicing to/from a tty
Message-ID: <20210120230254.GD740243@zeniv-ca>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
 <20210118193457.GA736435@zeniv-ca>
 <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
 <20210118195400.GC736435@zeniv-ca>
 <20210120162608.GB740243@zeniv-ca>
 <20210120191116.GC740243@zeniv-ca>
 <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
 <29625ab9f4f94b84aacf96ad9b5da828@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29625ab9f4f94b84aacf96ad9b5da828@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:25:56PM +0000, David Laight wrote:

> I also wonder if pread/pwrite with offset == 0 should be valid
> on things where the offset makes no sense.
> 
> I'm rather surprised the offset isn't just silently ignored
> for devices where seeking is non-sensical.
> You might want to error it for mag tapes, but not pipes,
> ttys, sockets etc.
> 
> I really can't remember what SYSV, Solaris or NetBSD do.

... nor can you be arsed to RTFPOSIX.   Why am I not surprised?

In https://pubs.opengroup.org/onlinepubs/9699919799/functions/write.html
(located by arcane action known as googling for pwrite POSIX):
==============================
The pwrite() function shall fail if:

[EINVAL]
	The file is a regular file or block special file, and the offset argument is negative.
The file offset shall remain unchanged.
[ESPIPE]
	The file is incapable of seeking.
==============================
