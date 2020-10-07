Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE6A285890
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 08:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgJGGRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 02:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgJGGRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 02:17:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8622C061755;
        Tue,  6 Oct 2020 23:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6uV8fR6Bo4rXo+4SAac2dN21jdBEtdjU/gp2f8k5a6U=; b=nBG61JS0gPJssVIiWhM4TYdaX7
        NgovjK/cwv32nuTrAfzI2XE875QD1msyMoU/d6LsDTlMx4hWrv/SV06X+dFN4UEKXrtc8PZEwmRSy
        YT8KOsQpo4OnvU3y5pjfWz7j9kRYCfs7g/BoP3VVzAwr6JWKgyLnQWEnGkPTboBr8OQi1UBRksyDq
        C8i1EaVzEYBrpBYuGBD0oiOUUeofK+Wd5LzZu8ia4eP5P3K0vQ6XDPRsRMXPna0vvNThUn6OVNGcF
        0LhSf36PaXv20v+r4fpqhRvwNeNYaMN3NDu0sns0rnEmMSa1aMFaTseom9/BtqVI2Wz9olyef0AIW
        FvLpwH7A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ2l2-00060F-10; Wed, 07 Oct 2020 06:17:00 +0000
Date:   Wed, 7 Oct 2020 07:16:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: SPARC version of arch_validate_prot() looks broken (UAF read)
Message-ID: <20201007061659.GA21685@infradead.org>
References: <CAG48ez3YsfTfOFKa-Po58e4PNp7FK54MFbkK3aUPSRt3LWtxQA@mail.gmail.com>
 <0fb905cc-77a2-4beb-dc9c-0c2849a6f0ae@oracle.com>
 <CAG48ez3istGAOA=G8fvrQkbMs4MroT8bj=Z=Wmnj0k73K0AFRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3istGAOA=G8fvrQkbMs4MroT8bj=Z=Wmnj0k73K0AFRA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 02:45:39AM +0200, Jann Horn wrote:
> > I think arch_validate_prot() is still the right hook to validate the
> > protection bits. sparc_validate_prot() can iterate over VMAs with read
> > lock. This will, of course, require range as well to be passed to
> > arch_validate_prot().
> 
> In that case, do you want to implement this?

Any reason to not just call arch_validate_prot after taking the mmap
lock?
