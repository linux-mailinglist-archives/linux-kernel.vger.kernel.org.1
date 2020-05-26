Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680E11CEBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 05:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgELDoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 23:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727942AbgELDoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 23:44:05 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2886C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 20:44:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYLpo-006Rzt-4M; Tue, 12 May 2020 03:44:00 +0000
Date:   Tue, 12 May 2020 04:44:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Potapenko <glider@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in
 fill_thread_core_info()
Message-ID: <20200512034400.GA1537486@ZenIV.linux.org.uk>
References: <20200419100848.63472-1-glider@google.com>
 <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook>
 <20200421034249.GB23230@ZenIV.linux.org.uk>
 <CAG_fn=VZZ7yUxtOGzuTLkr7wmfXWtKK9BHHYawj=rt9XWnCYvg@mail.gmail.com>
 <20200512010901.GQ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512010901.GQ23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 02:09:01AM +0100, Al Viro wrote:
> On Tue, Apr 21, 2020 at 10:14:25AM +0200, Alexander Potapenko wrote:
> > > Not lately and I would also like to hear the details; which regset it is?
> > > Should be reasonably easy to find - just memset() the damn thing to something
> > > recognizable, do whatever triggers that KMSAN report and look at that
> > > resulting coredump.
> > 
> > The bug is easily triggerable by the following program:
> > 
> > ================================================
> > int main() {
> >   volatile char *c = 0;
> >   (void)*c;
> >   return 0;
> > }
> > ================================================
> > 
> > in my QEMU after I do `ulimit -c 10000`.
> 
> .config, please - I hadn't been able to reproduce that on mine.
> Coredump obviously does happen, but not a trace of the poison
> is there - with your memset(data, 0xae, size) added, that is.

Actually, more interesting question would be your /proc/cpuinfo...
