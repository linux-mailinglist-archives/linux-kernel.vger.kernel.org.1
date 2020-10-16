Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F4A2902BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395284AbgJPKVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 06:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgJPKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 06:21:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA5C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 03:21:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d0d0089517c9ee4bbfe7f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d00:8951:7c9e:e4bb:fe7f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5B401EC0434;
        Fri, 16 Oct 2020 12:21:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602843706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6xHostpyDNxVnWurk+0lFDditqkkNw5E2M1WKE2zWIc=;
        b=E0RTPCh6g4bTUTiYYt7uTUwyyctZF/YjubY8aGeq5Ue9A0mVCDBBxyFGyC/ZQCHgxIqdLT
        7BooNBsXqVLgOkOdZ/iPZpbkPe2ljYYPAEtvzKr8CMk8lkOc3MOgY0W5RFTyasq8mSuvXz
        5U7kCcRGtGGggFk+GXzx5Oz2Op0LPWQ=
Date:   Fri, 16 Oct 2020 12:21:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/64: Initialize 5-level paging variables earlier
Message-ID: <20201016102135.GC8483@zn.tnic>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201010191110.4060905-1-nivedita@alum.mit.edu>
 <20201010192624.GA4062867@rani.riverdale.lan>
 <20201012140830.vrc25x2gwo7yo4kn@black.fi.intel.com>
 <20201012153501.GA559681@rani.riverdale.lan>
 <20201013081117.GA28215@zn.tnic>
 <20201013082047.ifigo5hua2qdrv75@black.fi.intel.com>
 <20201013083358.GB28215@zn.tnic>
 <20201015135209.cojpqumlqntird2o@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201015135209.cojpqumlqntird2o@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 04:52:09PM +0300, Kirill A. Shutemov wrote:
> Yes, the patch helps to fix 5-level paging boot:
> 
> Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
