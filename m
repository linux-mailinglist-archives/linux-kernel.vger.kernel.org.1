Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4882F8DE2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbhAPRLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbhAPRLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:11:07 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6F3C06179A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 09:09:25 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l0oij-007MTH-H2; Sat, 16 Jan 2021 17:46:37 +0100
Message-ID: <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
Subject: Re: Splicing to/from a tty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Oliver Giles <ohw.giles@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Date:   Sat, 16 Jan 2021 17:46:33 +0100
In-Reply-To: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-01-16 at 20:35 +1300, Oliver Giles wrote:
> Commit 36e2c7421f02 (fs: don't allow splice read/write without
> explicit ops) broke my userspace application which talks to an SSL VPN
> by splice()ing between "openssl s_client" and "pppd". The latter
> operates over a pty, and since that commit there is no fallback for
> splice()ing between a pipe and a pty, or any tty for that matter.
> 
> The above commit mentions switching them to the iter ops and using
> generic_file_splice_read. IIUC, this would require implementing iter
> ops also on the line disciplines, which sounds pretty disruptive.
> 
> For my case, I attempted to instead implement splice_write and
> splice_read in tty_fops; I managed to get splice_write working calling
> ld->ops->write, but splice_read is not so simple because the
> tty_ldisc_ops read method expects a userspace buffer. So I cannot see
> how to implement this without either (a) using set_fs, or (b)
> implementing iter ops on all line disciplines.
> 
> Is splice()ing between a tty and a pipe worth supporting at all? Not a
> big deal for my use case at least, but it used to work.

Is it even strictly related to the tty?

I was just now looking into why my cgit/fcgi/nginx setup no longer
works, and the reason is getting -EINVAL from sendfile() when the input
is a file and the output is a pipe().

So I wrote a simple test program (below) and that errors out on kernel
5.10.4, while it works fine on the 5.9.16 I currently have. Haven't
tried reverting anything yet, but now that I haev a test program it
should be simple to even bisect.

johannes


#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/sendfile.h>
#include <stdio.h>
#include <assert.h>

int main(int argc, char **argv)
{
	int in = open(argv[0], O_RDONLY);
	int p[2], out;
	off_t off = 0;
	int err;

	assert(in >= 0);
	assert(pipe(p) >= 0);
	out = p[1];
	err = sendfile(out, in, &off, 1024);
	if (err < 0)
		perror("sendfile");
	assert(err == 1024);

	return 0;
}


