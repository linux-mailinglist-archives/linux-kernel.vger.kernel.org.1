Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02C829A634
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894388AbgJ0IHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:07:50 -0400
Received: from casper.infradead.org ([90.155.50.34]:34132 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgJ0IHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tP+Tygnqk+POwnifrL6U3LGD+YGYZBiKxYocZhRiZfI=; b=Z/42g85E2JDMNAl24NCigLPUbi
        eYimZsjIqfHVvR9A1oY/y84OplWG0FbaYiS4stoykdxuUVhV6ljzVLyC+pfpdE9xAKD8nUWYBL8nd
        j22FYevgAgDxroZa9s3P5zVzDCuZyXa5jQy0Ze2MTM+LnkPcTDSGVIEZDdtWIF2y5lZNNnTYLQpTB
        7ZyJ1yJdDJwmDpRRzAh38UBI0nV+7RfHXNmWpOAalzt3BdN140hHXqWrmHET+GQdgeIlvEUrLLzDD
        7msyhNdx7mspnUv0gbLUDbXxI36kd0HydZf/i5Vh+0aPpIOnk+73e33sR67vthb8kKMWF5p+756y9
        jDc6DMYw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXK1B-0000fp-Q9; Tue, 27 Oct 2020 08:07:45 +0000
Date:   Tue, 27 Oct 2020 08:07:45 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with splice from /proc (was Linux 5.10-rc1)
Message-ID: <20201027080745.GA31045@infradead.org>
References: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
 <20201027064832.GA209538@kroah.com>
 <20201027074911.GB29565@infradead.org>
 <20201027075541.GA24429@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027075541.GA24429@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 08:55:41AM +0100, Greg KH wrote:
> This is just a test, part of the bionic test suite to verify that bionic
> is working properly, and is run on new kernels as a verification that
> nothing functional broke in the kernel update.
> 
> I don't know about "real applications" yet.
> 
> Do you have to implement this on a per-proc-file-basis, or will it work
> for the whole filesystem?
> 
> And are the patches public anywhere that I could test them out?

This all branch has the last posted version:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/set_fs-rw.2

with tthe proc:, sysctl: and seq_file: patches related to it.  It did
switch over all seq_file instances, but non-seq_file instances and write
operations will need manual per-instance work.
