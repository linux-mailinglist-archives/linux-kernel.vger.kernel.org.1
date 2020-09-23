Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5A7275018
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 06:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgIWEwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 00:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgIWEwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 00:52:34 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974E3C061755;
        Tue, 22 Sep 2020 21:52:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKwlb-004Ihd-2q; Wed, 23 Sep 2020 04:52:31 +0000
Date:   Wed, 23 Sep 2020 05:52:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Guo Ren <guoren@kernel.org>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] csky: Fix a size determination in gpr_get()
Message-ID: <20200923045231.GH3421308@ZenIV.linux.org.uk>
References: <20200922091505.471-1-zhenzhong.duan@gmail.com>
 <20200922162901.GA3421308@ZenIV.linux.org.uk>
 <CAJF2gTSMWc_=j1NKCTXqhLj7cmSB_A3dYB7nL4F7H3jqT+u38A@mail.gmail.com>
 <20200923002315.GC3421308@ZenIV.linux.org.uk>
 <CAJF2gTSU4e4yU63z1q502SeuTf2m2BKaD0yZ0deFj0TkiVupFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTSU4e4yU63z1q502SeuTf2m2BKaD0yZ0deFj0TkiVupFg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:37:31AM +0800, Guo Ren wrote:

> > What's going on there?  The mapping is really weird - assuming
> > you had v0..v31 in the first 32 elements of regs->vr[], you
> > end up with
> >
> > v0 v1 v2 v3 v2 v3 v6 v7 v4 v5 v10 v11 v6 v7 v14 v15
> > v8 v9 v18 v19 v10 v11 v22 v23 v12 v13 v26 v27 v14 v15 v30 v31
> >
> > in the beginning of the output.  Assuming it is the intended
> > behaviour, it's probably worth some comments...
> FPU & VDSP use the same regs. 32 FPU regs' width is 64b and 16 VDSP
> regs' width is 128b.
> 
> vr[0], vr[1] = fp[0] & vr[0] vr[1], vr[2], vr[3] = vdsp reg[0]
> ...
> vr[60], vr[61] = fp[15] & vr[60] vr[61], vr[62], vr[63] = vdsp reg[15]
> vr[64], vr[65] = fp[16]
> vr[66], vr[67] = fp[17]
> ...
> vr[94], vr[95] = fp[31]
> 
> Yeah, this is confusing and I'll add a comment later.

Umm...  It would help if you described these 3 layouts:
	1) kernel-side with VDSP
	2) userland (identical to (1)?)
	3) kernel-side without VDSP
Still confused...

PS: my apologies re commit message - I left a note to myself when doing
that series and then forgot about it ;-/

Anyway, which tree should it go through?  In any case, that fix is
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
and I can take it through vfs.git or you guys can pick in csky tree;
up to you.
