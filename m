Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30A12605AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 22:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgIGU1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 16:27:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37848 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbgIGU1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:27:45 -0400
Received: from zn.tnic (p200300ec2f0909008054e7a53e29f06e.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:900:8054:e7a5:3e29:f06e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 368951EC0445;
        Mon,  7 Sep 2020 22:27:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599510464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=q9SzNFIgUnMtRWBkXPeQKo69d0fiJd9l6vcPHHJOJUY=;
        b=D4Uk2Q7sUwFReoDoJhBlUwqWoGqSpat6PsPcL+nv+QhUGfbv4T8wni/a91ufF430mzhrGj
        AEpBQ5LZHjbJejethBpYD5pX4I++18bDOYtFcO+AosoBr9bvkFyltU5us1k+EWgusSRIMF
        KkfIN9yNkzeNZUMSBBHPtvQu9YY1+Go=
Date:   Mon, 7 Sep 2020 22:27:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86-ml <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Message-ID: <20200907202737.GF16029@zn.tnic>
References: <20200906212130.GA28456@zn.tnic>
 <CALCETrV4YN6t3Wqh+u4K=dQkj5RFQ0UbPj3nXXn2iHO+eZm4vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrV4YN6t3Wqh+u4K=dQkj5RFQ0UbPj3nXXn2iHO+eZm4vA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 01:16:43PM -0700, Andy Lutomirski wrote:
> > +       asm volatile("rdmsr" : EAX_EDX_RET(val, low, high) : "c" (msr));
> 
> I don't like this.  Plain rdmsrl() will at least print a nice error if it fails.

I think you read my commit message too quickly :)

The point is to not print anything and not have *any* exception handling
or whatever - just plain RDMSR.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
