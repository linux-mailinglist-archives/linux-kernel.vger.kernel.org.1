Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287E429BC6A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1802576AbgJ0QcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:32:20 -0400
Received: from casper.infradead.org ([90.155.50.34]:47756 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1798634AbgJ0QcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H05ltON33z0fCdXh2EgSujvsztqcC4kd9zN/VDX94OE=; b=gvrxYDSrU2k4WlnyLsg3sRhVt8
        kE41rt04oAhSHOiWv1IReEwHvAAvs97HMaUj1sDhnJo/HduW/nIQR7i68q1Sm0q6vEpqHEpD+qdMR
        v6Ta84ML8X7YJBqQBrMs7xrbS/xCx+pT5IXuUIO81XzRSbO38/POdxa/QELOxJTBMjqtWxKcbSEJ9
        ZsQCvBrJvLLu6FY3v0O8FePX6DV5K4vd/Zly9PAaqJnzuRcWlvJYktYtCqkLCwjKv3WjctqzqT9sE
        Kno2WRGH1Wjz3d57N+QdUfyssZ6ZS2OitMGVCbum12NVOgd2O87qPzbxyABovgvWKBezKWygVWvAF
        kaLKoZHw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXRtN-0007eh-CM; Tue, 27 Oct 2020 16:32:13 +0000
Date:   Tue, 27 Oct 2020 16:32:13 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with splice from /proc (was Linux 5.10-rc1)
Message-ID: <20201027163213.GA25390@infradead.org>
References: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
 <20201027064832.GA209538@kroah.com>
 <20201027074911.GB29565@infradead.org>
 <20201027075541.GA24429@kroah.com>
 <20201027080745.GA31045@infradead.org>
 <20201027081420.GA30177@kroah.com>
 <20201027091725.GA42707@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027091725.GA42707@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:17:25AM +0100, Greg KH wrote:
> Ok, I couldn't get a clean merge of that old branch on top of your
> 5.10-rc1 tree, so I can't give it a run-through.  If you have an updated
> series you want me to test, I'll be glad to do so.

Can you give this branch a spin?

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/set_fs-proc
