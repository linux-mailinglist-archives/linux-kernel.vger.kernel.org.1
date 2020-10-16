Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4443F290D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 23:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411302AbgJPVZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 17:25:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57688 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411186AbgJPVYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 17:24:06 -0400
Received: from zn.tnic (p200300ec2f0d0d00b8b03f33e530a485.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d00:b8b0:3f33:e530:a485])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 806141EC03C1;
        Fri, 16 Oct 2020 23:24:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602883445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hInRbbVPmcrN+QDKknsmHC0i1jis2/gZJcSS52hsJsE=;
        b=lnNpzqN+T+/YlunoGFF6ec+rolh8r4Z+fnXmvvFrcsiiWm9whg1sNRommrCc2FYsouCd57
        ui89fXpL3BPzxfAdHTN07E0gZGdzbrWrDHR6uAKcXfV/851YWSu7enG6S1cXX8wG4mySq0
        KmKHLiImg0NIf92jQtbYJrgdiy1J7QU=
Date:   Fri, 16 Oct 2020 23:23:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] x86/boot/64: Explicitly map boot_params and
 command line
Message-ID: <20201016212352.GK8483@zn.tnic>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-5-nivedita@alum.mit.edu>
 <20201016162759.GG8483@zn.tnic>
 <20201016164755.GA1185111@rani.riverdale.lan>
 <20201016170726.GH8483@zn.tnic>
 <20201016172058.GA1246432@rani.riverdale.lan>
 <20201016173232.GI8483@zn.tnic>
 <20201016211841.GA1634455@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016211841.GA1634455@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 05:18:41PM -0400, Arvind Sankar wrote:
> I just sent out v3, with the patches reordered. Maybe just pick up the
> fix for now, and the other three patches I can resend sometime after the
> merge window, along with other cleanups I've been working on.

Sure, however you prefer.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
