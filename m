Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB51E4DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 21:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgE0TFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 15:05:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36922 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgE0TFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:05:03 -0400
Received: from zn.tnic (p200300ec2f0b8700dda2f727e1b752eb.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8700:dda2:f727:e1b7:52eb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DFFDF1EC02B3;
        Wed, 27 May 2020 21:05:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590606302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/hBQwlO36HqTw7b3/a9y2PU9fbwGlde7Xw6IvZwUL1k=;
        b=Nd9abdxSIUPRqq0wm4UFeDxDA4cN2klC1VYeab2tmXCHyJBaaQSrgI7P9Te07A4B9DCe9k
        GlIKjetw2s7t3wlqhp0Au822vwm0MGl1Yc3BqRAY3DAp6mNdo1BOPVDVgbqCLZGoXIh1ld
        HLDYcv2h+g7BGIYFEqUr9pC6ErZtKRM=
Date:   Wed, 27 May 2020 21:04:56 +0200
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
Message-ID: <20200527190456.GD1721@zn.tnic>
References: <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook>
 <20200421034249.GB23230@ZenIV.linux.org.uk>
 <CAG_fn=VZZ7yUxtOGzuTLkr7wmfXWtKK9BHHYawj=rt9XWnCYvg@mail.gmail.com>
 <20200512010901.GQ23230@ZenIV.linux.org.uk>
 <20200512034400.GA1537486@ZenIV.linux.org.uk>
 <CAG_fn=Xopqwu8qpdH2xDHmGSy1utp7uyPn7s6btm0hdaV7JVRg@mail.gmail.com>
 <20200513033349.GR23230@ZenIV.linux.org.uk>
 <20200524234535.GA23230@ZenIV.linux.org.uk>
 <20200526223817.GA3819674@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200526223817.GA3819674@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 11:38:17PM +0100, Al Viro wrote:
> Folks, could you test the following?
> 
> copy_xstate_to_kernel(): don't leave parts of destination uninitialized
> 
> copy the corresponding pieces of init_fpstate into the gaps instead.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Am I taking this through tip (would prefer to as there's other FPU stuff
pending) or should I ack this so that you can send it upwards?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
