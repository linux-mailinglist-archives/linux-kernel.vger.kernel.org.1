Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E8E1E4ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 22:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgE0UJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgE0UJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:09:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C1BC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:09:22 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b8700952f735680ed3731.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8700:952f:7356:80ed:3731])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 67B761EC03C1;
        Wed, 27 May 2020 22:09:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590610160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fRPuxBakBVbcmSCEg2bC/jV+3VKUhQ73s7iWSD9boGI=;
        b=EoqI1QIYPQYGvHcoAvkkthP8DyiXmirTvOWJWMdEpPPAt5Th+ltsYDYwHq96Oed8CXrbff
        xwhGNI7UpdhvzhDifoZ03vmJlfZRBY9HPzpKMeGbU/Dm0Bf0ba/ueAE6Rh0byf8nLebdfI
        TWreLrS7TjWgUlGN49vxBIydfyLHCvI=
Date:   Wed, 27 May 2020 22:09:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com,
        x86@kernel.org
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in
 fill_thread_core_info()
Message-ID: <20200527200910.GE1721@zn.tnic>
References: <20200421034249.GB23230@ZenIV.linux.org.uk>
 <CAG_fn=VZZ7yUxtOGzuTLkr7wmfXWtKK9BHHYawj=rt9XWnCYvg@mail.gmail.com>
 <20200512010901.GQ23230@ZenIV.linux.org.uk>
 <20200512034400.GA1537486@ZenIV.linux.org.uk>
 <CAG_fn=Xopqwu8qpdH2xDHmGSy1utp7uyPn7s6btm0hdaV7JVRg@mail.gmail.com>
 <20200513033349.GR23230@ZenIV.linux.org.uk>
 <20200524234535.GA23230@ZenIV.linux.org.uk>
 <20200526223817.GA3819674@ZenIV.linux.org.uk>
 <20200527190456.GD1721@zn.tnic>
 <20200527195303.GF23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527195303.GF23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 08:53:03PM +0100, Al Viro wrote:
> Either way would work - I was going to send it to Linus tonight and an
> extra Acked-by: would be welcome.  OTOH, if you would rather have all
> x86-related patches go through x86 git... your subtree, your rules.

Ok, here we go:

Acked-by: Borislav Petkov <bp@suse.de>

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
