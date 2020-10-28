Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0729DF9D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbgJ2BDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbgJ1WKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:22 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96363C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:10:22 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s14so462708qkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a61uin/SMm84aFoeFhhwpsXIkHzjVZ1k0dxQ8owfxUg=;
        b=A76MPonpnK+AbYDcMc+UjtSwVFu+UVf3Au8mEEB5ejzMN2+ux0slLM0Fkpsu9l8ZLo
         OVOP0KoKmuDrhFn/+6W/mDKQ+fbM4AbeTO3UnUuOVzDz8UHkMvczG9qovr5nplUefb1/
         Bh5jZwRE0P3ZXS1QM+EPLPKLO6l+FlBo9hFrdVwZiDrwpvAiccokW+D9Agr/oPfqtu5p
         ysB2bt5B5OI+NQWUNmIVTRpxSuACWy8zMKnbTiVMLufBWfXIBL2rx08BB2bdYnOQpLPT
         jH8D2R/w5Tv4LY/SNNdOcdTvzTZOOYD1GdHI1YnnilPljoV7PpqSFMXSpqUYIBOHHuGW
         ZogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a61uin/SMm84aFoeFhhwpsXIkHzjVZ1k0dxQ8owfxUg=;
        b=QhkTswcPDFqk/RKqSlvr1hZuN29bXMENP+HwlQjopR6e/IE99mv+z/qP4jWSA5SgJi
         yChaWvUAqX8+jYd6b0NGFf7NTImzoDryQYiTN/7MCEIACJAOTe2dJ9ik4MIrevajVPWD
         cQSpjqEzKDqMuQpjHuIMQXCoYHS8EW/QYDF6UJAqH3W3liokpmQDBu0Rbg8dOlDjIqJ+
         HkIaLNEzL+8Yr/ymv6cyh5C8wthtW49EfW1Ndot1y5roTJQ+hea2wYAoiM8GPd16uo+/
         L5mKOXrc6rJl5WeBRQ4i/ZvgiDsFeMOcjWBOdOu5NsdZW/Zmz0tlXcY8/+Rq2Cm72QuL
         W41w==
X-Gm-Message-State: AOAM5313inHA5xUC+2/bsuhA6IL6u1fsTy0sWWNhmBWiFlV3uUO6hici
        P2kO8YJIMGIMS7Rfdp09zpvtsQqqlttrXQ==
X-Google-Smtp-Source: ABdhPJzcjmhYcP0dQSEBhY/JqsSTKnRiXr1DiES/thiy46Mv5h95hsz0PVMNCqKlMYfOExX5O7+O7w==
X-Received: by 2002:a37:de17:: with SMTP id h23mr2081926qkj.267.1603903809825;
        Wed, 28 Oct 2020 09:50:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m6sm3276437qki.112.2020.10.28.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 09:50:08 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 28 Oct 2020 12:50:07 -0400
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] x86/boot/compressed/64: Introduce sev_status
Message-ID: <20201028165007.GB1989568@rani.riverdale.lan>
References: <20201021123938.3696-1-joro@8bytes.org>
 <20201021123938.3696-2-joro@8bytes.org>
 <20201026182706.GG22116@zn.tnic>
 <20201028082352.GA18723@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201028082352.GA18723@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 09:23:52AM +0100, Joerg Roedel wrote:
> On Mon, Oct 26, 2020 at 07:27:06PM +0100, Borislav Petkov wrote:
> > A couple of lines above you call get_sev_encryption_bit() which already
> > reads MSR_AMD64_SEV. Why not set sev_status there too instead of reading
> > that MSR again here?
> > 
> > It can read that MSR once and use sev_status(%rip) from then on to avoid
> > reading that MSR multiple times...
> 
> Right, makes sense. I updated the patch.

Hang on, get_sev_encryption_bit() is also called from startup_32(),
so it can't contain any 64-bit instructions to set sev_status.
