Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66161274DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 02:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgIWAXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 20:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgIWAXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 20:23:18 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFA4C061755;
        Tue, 22 Sep 2020 17:23:18 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKsZ1-004BGH-0x; Wed, 23 Sep 2020 00:23:15 +0000
Date:   Wed, 23 Sep 2020 01:23:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Guo Ren <guoren@kernel.org>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] csky: Fix a size determination in gpr_get()
Message-ID: <20200923002315.GC3421308@ZenIV.linux.org.uk>
References: <20200922091505.471-1-zhenzhong.duan@gmail.com>
 <20200922162901.GA3421308@ZenIV.linux.org.uk>
 <CAJF2gTSMWc_=j1NKCTXqhLj7cmSB_A3dYB7nL4F7H3jqT+u38A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTSMWc_=j1NKCTXqhLj7cmSB_A3dYB7nL4F7H3jqT+u38A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 08:03:20AM +0800, Guo Ren wrote:
> Thx Duan,
> 
> Acked-by: Guo Ren <guoren@kernel.org>
> 
> Hi AI,
> 
> I found the broken commit still has a question:
> 
> > commit dcad7854fcce6a2d49b6a3ead5bbefeff047e559
> > Author: Al Viro <viro@zeniv.linux.org.uk>
> > Date:   Tue Jun 16 15:28:29 2020 -0400
> 
> >    csky: switch to ->regset_get()
> 
> >    NB: WTF "- what the fuck :(" is fpregs_get() playing at???
> The fpregs_get() is for REGSET_FPR regset used by ptrace (gdb) and all
> fp regs are stored in threads' context.
> So, WTF question for?

The part under
#if defined(CONFIG_CPU_HAS_FPUV2) && !defined(CONFIG_CPU_HAS_VDSP)

What's going on there?  The mapping is really weird - assuming
you had v0..v31 in the first 32 elements of regs->vr[], you
end up with

v0 v1 v2 v3 v2 v3 v6 v7 v4 v5 v10 v11 v6 v7 v14 v15
v8 v9 v18 v19 v10 v11 v22 v23 v12 v13 v26 v27 v14 v15 v30 v31

in the beginning of the output.  Assuming it is the intended
behaviour, it's probably worth some comments...
