Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766A628CA52
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403870AbgJMIeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390540AbgJMIeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:34:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A918C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:34:09 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ecc00b688821b0a181b84.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:cc00:b688:821b:a18:1b84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE8A41EC0266;
        Tue, 13 Oct 2020 10:34:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602578047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qIMkzQUnWuHLeAaIIT8VKeYzvlpHwBquaWrTGZd623o=;
        b=G9vZ9fVLTUcepYGcX7uvO+ojsvTkcyGmZm2ARXnEBEy1lAvcwHPL57rziyJlzEtBYv3J2I
        feD1lHj9zxtJy5sNdX1PdRol1U30gVGUzOGrLilC52TgxhP2MM/w1Dv0xMLnPY8kfBukLH
        kJOExQfAJ6IlVbhHbBmDbf2oxmdGZrU=
Date:   Tue, 13 Oct 2020 10:33:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/64: Initialize 5-level paging variables earlier
Message-ID: <20201013083358.GB28215@zn.tnic>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201010191110.4060905-1-nivedita@alum.mit.edu>
 <20201010192624.GA4062867@rani.riverdale.lan>
 <20201012140830.vrc25x2gwo7yo4kn@black.fi.intel.com>
 <20201012153501.GA559681@rani.riverdale.lan>
 <20201013081117.GA28215@zn.tnic>
 <20201013082047.ifigo5hua2qdrv75@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201013082047.ifigo5hua2qdrv75@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 11:20:47AM +0300, Kirill A. Shutemov wrote:
> With TCG or KVM? I use -machine "type=q35,accel=tcg".

Thx, that triggered it - it was KVM before.

Btw, are 5level boxes shipping already or not yet? Because I've not seen
one yet. If you have access to the hw, I'd appreciate it if you could
test Arvind's patch ontop of

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/seves

which does that early pagetable rework.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
