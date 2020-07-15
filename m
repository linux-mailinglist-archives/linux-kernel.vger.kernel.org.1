Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1614A2217B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 00:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgGOWWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 18:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOWWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:22:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB40C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:22:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z24so4535041ljn.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QQLzvz01x+b8v3+Cnyl7jGabL4vkvUR6NP/JnDRqN14=;
        b=t6qmthfa2lAn6qPwWRBsl1GYTeI7O9H+AGbAsb4IxmUyvEHHu7fJK1c224oXidHvmZ
         5AMdfkj6yFJC2kHTm4TOyTPpVtA2o/xE9NjwHt7C60xpdfuBkE/teayYJacmxzGDOdZW
         oJbqNFfuBFbWTh5wzW6rl26wHAx82ioSAM5EtzXQUes5raOLOCYfkroCswbzjPxIlBUT
         /8QKGEclyi661apiOLbs3iuEf1mkRSBXZ/CqUrMD38x7aMkQz2OTITKPPn//QaYzYJfo
         W/iI5R7wgEGjK8RrMtshOmUBj6wl1smJGLhCZOoaQnxKC1hX619J7iHFGarIIARs5hPn
         5exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQLzvz01x+b8v3+Cnyl7jGabL4vkvUR6NP/JnDRqN14=;
        b=aDWQVAHykqkOmxXBw1GkToBGcshoZrfbpda2V2PNxgukWeSoGbzMue78WQYvx9PaB4
         t6+6iKYvAwiMi/5POgXKy2a6XwfVJy4u8Wg8X3C5CWdHhm+PpbGtON9NMQu2+tc8ILo4
         zSSR6H5asLCHGmBBOune/cuVG6zxBZhiOuJBfZap475F37gJDY16MlflIEa8cLDTZOsR
         09ZqRHJzh+fjDk1flgLxRpY2QbakAV98E6GpfMEiHopO75InpHjPSXklI6F+rRS36M9B
         9tvBQJQaMpKsfyFE2J8d1SI+7uLJmlwhQyx3mO+LymQ9zGcC2Tb2rWBdaBiYXcN9zsOn
         WSxw==
X-Gm-Message-State: AOAM531/IVczgRpFYOA2I+T2QfhTF3CzXXDmh7emh6+k6lW4ugDI0ix2
        Owj6aTAgVC3S5TAD+4E1Z35j2g==
X-Google-Smtp-Source: ABdhPJyj3VFOBx+30maf++ddl657sJxm7UjHak+BcLiZlBDP5KWvcTAUDiP0zVjwmsERLy3vKL2u3Q==
X-Received: by 2002:a2e:8046:: with SMTP id p6mr616358ljg.100.1594851742568;
        Wed, 15 Jul 2020 15:22:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b16sm669040ljp.124.2020.07.15.15.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:22:22 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5CB9C102143; Thu, 16 Jul 2020 01:22:28 +0300 (+03)
Date:   Thu, 16 Jul 2020 01:22:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
Message-ID: <20200715222228.jf2pv5u2wyhtc5o5@box>
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com>
 <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
 <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 02:43:00PM -0700, Linus Torvalds wrote:
> On Wed, Jul 15, 2020 at 2:31 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Naresh - don't test that version. The bugs Joel found just make the
> > math wrong, so it won't work.
> 
> Here's a new version with the thing that Joel and Kirill both noticed
> hopefully fixed.
> 
> But I probably screwed it up again. I guess I should test it, but I
> don't have any really relevant environment (the plain mremap() case
> should have shown the obvious bugs, though, so that's just an excuse
> for my laziness)

Sorry, but the patch is broken.

It overcopies entires in some cases. It doesn't handles correctly if you
try to move PTEs from the middle of VMA.

The test case below rightly sigfaults without the patch when trying access
DST_ADDR[0], but not with the patch. It creates PTE entry at DST_ADDR that
doesn't belong to any VMA. :/

#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>

#define SRC_ADDR ((char *)(4UL << 30))
#define DST_ADDR ((char *)(5UL << 30))


int main(void)
{
	mmap(SRC_ADDR, 2UL << 20, PROT_READ | PROT_WRITE,
		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	madvise(SRC_ADDR, 2UL << 20, MADV_NOHUGEPAGE);
	memset(SRC_ADDR, 0x33, 2UL << 20);

	mremap(SRC_ADDR + 4096, 4096, 4096, MREMAP_MAYMOVE | MREMAP_FIXED,
		     DST_ADDR + 4096);
	printf("0: %#x 4096: %#x\n", DST_ADDR[0], DST_ADDR[4096]);
	return 0;
}

-- 
 Kirill A. Shutemov
