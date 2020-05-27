Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C631E4E94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 21:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgE0TxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 15:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0TxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:53:10 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1190C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:53:10 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1je26p-00GTjv-QR; Wed, 27 May 2020 19:53:03 +0000
Date:   Wed, 27 May 2020 20:53:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com,
        x86@kernel.org
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in
 fill_thread_core_info()
Message-ID: <20200527195303.GF23230@ZenIV.linux.org.uk>
References: <202004201540.01C8F82B@keescook>
 <20200421034249.GB23230@ZenIV.linux.org.uk>
 <CAG_fn=VZZ7yUxtOGzuTLkr7wmfXWtKK9BHHYawj=rt9XWnCYvg@mail.gmail.com>
 <20200512010901.GQ23230@ZenIV.linux.org.uk>
 <20200512034400.GA1537486@ZenIV.linux.org.uk>
 <CAG_fn=Xopqwu8qpdH2xDHmGSy1utp7uyPn7s6btm0hdaV7JVRg@mail.gmail.com>
 <20200513033349.GR23230@ZenIV.linux.org.uk>
 <20200524234535.GA23230@ZenIV.linux.org.uk>
 <20200526223817.GA3819674@ZenIV.linux.org.uk>
 <20200527190456.GD1721@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527190456.GD1721@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:04:56PM +0200, Borislav Petkov wrote:
> On Tue, May 26, 2020 at 11:38:17PM +0100, Al Viro wrote:
> > Folks, could you test the following?
> > 
> > copy_xstate_to_kernel(): don't leave parts of destination uninitialized
> > 
> > copy the corresponding pieces of init_fpstate into the gaps instead.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Am I taking this through tip (would prefer to as there's other FPU stuff
> pending) or should I ack this so that you can send it upwards?

Either way would work - I was going to send it to Linus tonight and an
extra Acked-by: would be welcome.  OTOH, if you would rather have all
x86-related patches go through x86 git... your subtree, your rules.
