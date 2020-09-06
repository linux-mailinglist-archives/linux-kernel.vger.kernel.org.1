Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2FD25F073
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 22:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIFUJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 16:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgIFUJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 16:09:14 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 003DB208B3;
        Sun,  6 Sep 2020 20:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599422953;
        bh=meX/Fm+ItdLklwXvfvZ1OtWwc9SIs7LcjL3XvWaMhnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBFgIQKPUvH9/wjWI+cAznRFeU92TlPIaJ2yzbFjxTyimuAg0Bih/rsjsohGCUuev
         pjAJLyVY6esCBTg5nwl5yKlrtW2b1RkY1Yjof8L5L022zA8bQBmXaFc36q5AqkbNol
         0mJ5NARU9kPagKMcRggLgK00Kga/SemNLlrxgHWc=
Date:   Sun, 6 Sep 2020 22:09:29 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /dev/zero: also implement ->read
Message-ID: <20200906200929.GA554621@kroah.com>
References: <20200903155922.1111551-1-hch@lst.de>
 <55d1ecb8-4a0c-fa58-d3cf-bf6796eea7bd@csgroup.eu>
 <3b0b58be4b844162b73db1b108a9b995@AcuMS.aculab.com>
 <20200906182122.GA12295@amd>
 <8c353864-76a9-90bf-fa2f-f7a8231b5487@csgroup.eu>
 <20200906183820.GA13290@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200906183820.GA13290@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 08:38:20PM +0200, Pavel Machek wrote:
> On Sun 2020-09-06 20:35:38, Christophe Leroy wrote:
> > Hi,
> > 
> > Le 06/09/2020 à 20:21, Pavel Machek a écrit :
> > >Hi!
> > >
> > >>>>Christophe reported a major speedup due to avoiding the iov_iter
> > >>>>overhead, so just add this trivial function.  Note that /dev/zero
> > >>>>already implements both an iter and non-iter writes so this just
> > >>>>makes it more symmetric.
> > >>>>
> > >>>>Christophe Leroy <christophe.leroy@csgroup.eu>
> > >>>>Signed-off-by: Christoph Hellwig <hch@lst.de>
> > >>>
> > >>>Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > >>
> > >>Any idea what has happened to make the 'iter' version so bad?
> > >
> > >Exactly. Also it would be nice to note how the speedup was measured
> > >and what the speedup is.
> > >
> > 
> > Was measured on an 8xx powerpc running at 132MHz with:
> > 
> > 	dd if=/dev/zero of=/dev/null count=1M
> > 
> > With the patch, dd displays a throughput of 113.5MB/s
> > Without the patch it is 99.9MB/s
> 
> Actually... that does not seem like a huge deal. read(/dev/zero) is
> not that common operation.

There is nothing wrong with this patch (aside from the sparse warning),
and it's in my tree now, so I don't understand complaining about it...

greg k-h
