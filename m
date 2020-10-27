Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50A129A5CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508122AbgJ0HtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:49:17 -0400
Received: from casper.infradead.org ([90.155.50.34]:33734 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508113AbgJ0HtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ckyJT15Q3WXMV7QcWaYBtVSjlooaGQaEAxQSRsp8uzk=; b=Lr5rCSI5TMkqbGpn1eW+Egko0t
        ah8QIVCExy64CmofLQQqdMgGEe92lOqdSirlLD8ddgEfanJX4CcF4MiOvVN/BWI0yvx5WxHScA74B
        SZ0YRn065lNaM4HbqgQq6kMfUZyJ9BdhlOqvK1tVNGPZyolohPKM/oRQnhCPvanbbNf4xy2PXMlGo
        1iPNsfHx4jxJkNs3OVbaGC/NvPbeE5C4Y8MTlgL7Hk/vOFRhilj6dEzbcym38j3UdIPB+bN+dmovq
        WdwEmzhH+DnKwkKZr/NAlFt7U3YmWREpRZtVtsa7t9hqACivJevnPD4QOTrAD5zDXwBLU5IBZXUEe
        mg3e/N7Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXJjD-0007pt-WB; Tue, 27 Oct 2020 07:49:12 +0000
Date:   Tue, 27 Oct 2020 07:49:11 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with splice from /proc (was Linux 5.10-rc1)
Message-ID: <20201027074911.GB29565@infradead.org>
References: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
 <20201027064832.GA209538@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027064832.GA209538@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 07:48:32AM +0100, Greg KH wrote:
> On Sun, Oct 25, 2020 at 03:40:27PM -0700, Linus Torvalds wrote:
> > The most interesting - to me - change here is Christoph's setf_fs()
> > removal (it got merged through Al Viro, as you can see in my mergelog
> > below).  It's not a _huge_ change, but it's interesting because the
> > whole model of set_fs() to specify whether a userspace copy actually
> > goes to user space or kernel space goes back to pretty much the
> > original release of Linux, and while the name is entirely historic (it
> > hasn't used the %fs segment register in a long time), the concept has
> > remained. Until now.
> 
> I told Al this yesterday, but figured I would mention it here for others
> to see.
> 
> Commit 36e2c7421f02 ("fs: don't allow splice read/write without explicit
> ops") from this patch series, is breaking the bionic test suite that
> does the following to verify that splice is working:
> 
> 	int in = open("/proc/cpuinfo", O_RDONLY);
> 	ASSERT_NE(in, -1);
> 
> 	TemporaryFile tf;
> 	ssize_t bytes_read = splice(in, nullptr, pipe_fds[1], nullptr, 8*1024, SPLICE_F_MORE | SPLICE_F_MOVE);
> 	ASSERT_NE(bytes_read, -1);
> 
> Before this change, all works well but now splice fails on /proc files
> (and I'm guessing other virtual filesystems).
> 
> I'll ask the bionic developers if they can change their test to some
> other file, but this is a regression and might show up in other "test
> platforms" as well.  Using /proc for this is just so simple because
> these files are "always there" and don't require any housekeeping for
> test suites to worry about .

Is this just a test or a real application?   I already have the
infrastructure to support read_iter/write_iter on procfs and seq_files,
but due to the intrusiveness we decided to only fix instances on an as
needed basis.  So we'll have everything ready once we pull the trigger.
