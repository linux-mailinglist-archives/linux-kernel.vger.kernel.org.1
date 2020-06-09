Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369591F46CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 21:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbgFITJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 15:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbgFITJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:09:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1363CC03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:09:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i12so1798888pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HQ56nm4mooZrZLgVMVr3lZPOBHVENmtQeTfjkfw/YJA=;
        b=jnaQZ8MEekRFeh3Jik9anJ+/Px5C4alE3zNqedi1bqR8jiPLxE/33C7/RiybjLNOsq
         AmQ9rdfd3Ze4Ax/HonsNV1UFkPQEvOwezedHn5AF5Jnzkw2BlAW1K5ep2YZIi8eWslnH
         VFv1//pXv1ACBo1/iRJVPWdY32ebVtXojWK9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HQ56nm4mooZrZLgVMVr3lZPOBHVENmtQeTfjkfw/YJA=;
        b=Kwobjg0RwqJOCkUauaoe38IDTOI6YD361/z6tinXtKlCBTUheUEvRceISY6EOmTtym
         +KQhQ4zT7ybIfHIKSBUok2Ee60u4hIfV+dC6rWcp12fN+FDRW/vDTamsN5l0qpTcNN+T
         MbOxlniMNiXFPyq1octb0bsgNScde6pqDa66ybVORWmQKsWpIKkA4hIRbwgRSHfH+lBd
         6uk8Q0rFuZUYT9M6RcTr0qrIoTbUVMcDxEaQw9EYurCCKOoIUdh9zWuTJPIhVy3E4lcb
         jO59sRaF3A1Evzm0kZBlGjyMjn/IIDjYyHq8lM0Bln/ISs7iHYUBDV2u7/IzoHXdLzHr
         CmSg==
X-Gm-Message-State: AOAM531oNZaqsJLkyTySEjFqb4WQ4v0p8pVU/esY9znNE0t9zo88gYGB
        HzZexEGGA1JDQQSziTcQGlyavQ==
X-Google-Smtp-Source: ABdhPJyKqh5iCm5EpXlVTd6GWynqUSgX0FSb3wwJXSw5Kt+fNblO4xqG/eduJstaxdLXws8XUiWjng==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr1188647pll.237.1591729769700;
        Tue, 09 Jun 2020 12:09:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r8sm10830771pfq.16.2020.06.09.12.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:09:28 -0700 (PDT)
Date:   Tue, 9 Jun 2020 12:09:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Emese Revfy <re.emese@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Mathias Krause <minipli@googlemail.com>,
        PaX Team <pageexec@freemail.hu>,
        Brad Spengler <spender@grsecurity.net>,
        Laura Abbott <labbott@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel-hardening@lists.openwall.com, linux-kbuild@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org, notify@kernel.org
Subject: Re: [PATCH 5/5] gcc-plugins/stackleak: Don't instrument
 vgettimeofday.c in arm64 VDSO
Message-ID: <202006091149.6C78419@keescook>
References: <20200604134957.505389-1-alex.popov@linux.com>
 <20200604134957.505389-6-alex.popov@linux.com>
 <20200604135806.GA3170@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604135806.GA3170@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 02:58:06PM +0100, Will Deacon wrote:
> On Thu, Jun 04, 2020 at 04:49:57PM +0300, Alexander Popov wrote:
> > Don't try instrumenting functions in arch/arm64/kernel/vdso/vgettimeofday.c.
> > Otherwise that can cause issues if the cleanup pass of stackleak gcc plugin
> > is disabled.
> > 
> > Signed-off-by: Alexander Popov <alex.popov@linux.com>
> > ---
> >  arch/arm64/kernel/vdso/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > index 3862cad2410c..9b84cafbd2da 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -32,7 +32,8 @@ UBSAN_SANITIZE			:= n
> >  OBJECT_FILES_NON_STANDARD	:= y
> >  KCOV_INSTRUMENT			:= n
> >  
> > -CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables
> > +CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables \
> > +		$(DISABLE_STACKLEAK_PLUGIN)
> 
> I can pick this one up via arm64, thanks. Are there any other plugins we
> should be wary of? It looks like x86 filters out $(GCC_PLUGINS_CFLAGS)
> when building the vDSO.

I didn't realize/remember that arm64 retained the kernel build flags for
vDSO builds. (I'm used to x86 throwing all its flags away for its vDSO.)

How does 32-bit ARM do its vDSO?

My quick run-through on plugins:

arm_ssp_per_task_plugin.c
	32-bit ARM only (but likely needs disabling for 32-bit ARM vDSO?)

cyc_complexity_plugin.c
	compile-time reporting only

latent_entropy_plugin.c
	this shouldn't get triggered for the vDSO (no __latent_entropy
	nor __init attributes in vDSO), but perhaps explicitly disabling
	it would be a sensible thing to do, just for robustness?

randomize_layout_plugin.c
	this shouldn't get triggered (again, lacking attributes), but
	should likely be disabled too.

sancov_plugin.c
	This should be tracking the KCOV directly (see
	scripts/Makefile.kcov), which is already disabled here.

structleak_plugin.c
	This should be fine in the vDSO, but there's not security
	boundary here, so it wouldn't be important to KEEP it enabled.

-- 
Kees Cook
