Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCF629A4DC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 07:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbgJ0Gsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 02:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgJ0Gsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 02:48:36 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A62120B1F;
        Tue, 27 Oct 2020 06:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603781316;
        bh=97Q1QKetcOCCOZuLlUxWMP/P31O7i+94Yd9QC1fy3jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4TM2cAtnqmMk68y6nVhx0DArc/NAIZVMOC9s86GT6K2G+bneTXBM2kzIQ0Bdgjo+
         Im/CG9912AKxAg9C0aAr+93gCEEkCE1YOnjCMPrJYjvcdVynQJAW5RgvB496p9+Lyt
         2N3I7/ZwTGccJC2T4bG4yQESbIyp1Qd5pWG7+ufU=
Date:   Tue, 27 Oct 2020 07:48:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: problems with splice from /proc (was Linux 5.10-rc1)
Message-ID: <20201027064832.GA209538@kroah.com>
References: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 03:40:27PM -0700, Linus Torvalds wrote:
> The most interesting - to me - change here is Christoph's setf_fs()
> removal (it got merged through Al Viro, as you can see in my mergelog
> below).  It's not a _huge_ change, but it's interesting because the
> whole model of set_fs() to specify whether a userspace copy actually
> goes to user space or kernel space goes back to pretty much the
> original release of Linux, and while the name is entirely historic (it
> hasn't used the %fs segment register in a long time), the concept has
> remained. Until now.

I told Al this yesterday, but figured I would mention it here for others
to see.

Commit 36e2c7421f02 ("fs: don't allow splice read/write without explicit
ops") from this patch series, is breaking the bionic test suite that
does the following to verify that splice is working:

	int in = open("/proc/cpuinfo", O_RDONLY);
	ASSERT_NE(in, -1);

	TemporaryFile tf;
	ssize_t bytes_read = splice(in, nullptr, pipe_fds[1], nullptr, 8*1024, SPLICE_F_MORE | SPLICE_F_MOVE);
	ASSERT_NE(bytes_read, -1);

Before this change, all works well but now splice fails on /proc files
(and I'm guessing other virtual filesystems).

I'll ask the bionic developers if they can change their test to some
other file, but this is a regression and might show up in other "test
platforms" as well.  Using /proc for this is just so simple because
these files are "always there" and don't require any housekeeping for
test suites to worry about .

thanks,

greg k-h
