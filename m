Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D8328CB24
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391250AbgJMJqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgJMJqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:46:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61827C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:46:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ecc00023049173123656a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:cc00:230:4917:3123:656a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E29341EC04D3;
        Tue, 13 Oct 2020 11:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602582377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oeoa5g1E1IZ9VZCC2cbE94aJQFEaLA3goG7QpqLbuqQ=;
        b=qExpYZiPzvChShjeM6uY0sMuv7VGwCxgfbH+PJF4Zu5r2tKdifuBGnH284Bvig+0us8XT0
        A5UrHP0co/ZjAoYse3ljlzNvZqzpBdw+muHd9cKQRjviEmhM9ToddiHU6781yirjjiZdu3
        hasfVk+5UGDGXWtkukZf6o4GMMJ2AcI=
Date:   Tue, 13 Oct 2020 11:46:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/64: Initialize 5-level paging variables earlier
Message-ID: <20201013094613.GC28215@zn.tnic>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201010191110.4060905-1-nivedita@alum.mit.edu>
 <20201010192624.GA4062867@rani.riverdale.lan>
 <20201012140830.vrc25x2gwo7yo4kn@black.fi.intel.com>
 <20201012153501.GA559681@rani.riverdale.lan>
 <20201013081117.GA28215@zn.tnic>
 <20201013082047.ifigo5hua2qdrv75@black.fi.intel.com>
 <20201013083358.GB28215@zn.tnic>
 <20201013091228.tzklrsjvo4tvb4ej@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201013091228.tzklrsjvo4tvb4ej@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 12:12:28PM +0300, Kirill A. Shutemov wrote:
> Not yet.

Oh good, that makes this fix a lot less critical then.

> Okay, will do.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
