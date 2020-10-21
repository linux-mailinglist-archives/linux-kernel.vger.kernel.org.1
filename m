Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562E32952E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504915AbgJUTYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441922AbgJUTYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:24:20 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30912C0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:24:20 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n11so2914219ota.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYM9cUyMSOj9mKCWCe707+J8b20m45BOShUil5OYiuY=;
        b=UcRTFA71oa+ZohVvqr5nTk2VrlQIDJZuL8YbFFB6slZWA8umJ/bN/qbSbMlqTB7z0q
         bIxgy64Kmi9zqOgOlY5HP3Sd823hLvIZ4IY3eeEDdvu0znOIz4Dey+GMkJlQfrWVVWss
         6QNEH9JVNXJd4SlM1j+HDRzTJLUTR8870k28s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYM9cUyMSOj9mKCWCe707+J8b20m45BOShUil5OYiuY=;
        b=EuTyhWoyMwXOnz9K0lJxTszDTGMAWBY6T4+G9XYCowDmhYU2FSUUhX4RWFcfWg5old
         l8V8GcSuUjNbw9mYJF2OE6NmglxNlDDLp7TvncjzebefweX4oFqHWgce1/4paKszQg9o
         Huah8kSf7Ma3m5Klm13TtAvaqXrC3ExcyYPIcu1xKOviIUPLHsgGDlLHRMCk27sxRXwh
         Jk3bZVtIkwCAXJ3cVBNK1KuZppYjNkD/j8zM1agXBUKi+QbutuKSaC3HB84FMuVQefya
         c40aLiFgRiWKg0vww61ByfG1PC2EVYSddRR7f8AXallypeVcWemc8OHIWdqWbPm2dxKz
         54Bg==
X-Gm-Message-State: AOAM531iQkhrmeZS3qnFPIvCZjDcouJeVnDJXOXISN8wci2H0GNCw1BR
        ne0DhOmGOmUUm4PG9bNl1GoLrERPzEb9ofCGwiIeuQ==
X-Google-Smtp-Source: ABdhPJwJGiQE46eBJclvgjHXJJ+j87WJ+7cjHqpCSH7v0fZi8HkcRkC+gln/SdoBFVWEgA88/UYBf7mOSQSqgr0L7bk=
X-Received: by 2002:a05:6830:1647:: with SMTP id h7mr3877970otr.281.1603308259478;
 Wed, 21 Oct 2020 12:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201021085655.1192025-1-daniel.vetter@ffwll.ch>
 <20201021085655.1192025-13-daniel.vetter@ffwll.ch> <20201021125030.GK36674@ziepe.ca>
 <CAKMK7uEWe8CaT7zjcZ6dJAKHxtxtqzjVB35fCFviwhcnqksDfw@mail.gmail.com>
 <20201021151352.GL36674@ziepe.ca> <CAKMK7uGq0=ks7Zj1Et44k7x9FwE9u_ua4zANSqrLRri0v01V+Q@mail.gmail.com>
 <20201021163702.GM36674@ziepe.ca>
In-Reply-To: <20201021163702.GM36674@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 21 Oct 2020 21:24:08 +0200
Message-ID: <CAKMK7uEjE5sHUq0hV_bnYjPKRxYyBnty0sLre+owANGZjLJg9Q@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] PCI: Obey iomem restrictions for procfs mmap
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 6:37 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Oct 21, 2020 at 05:54:54PM +0200, Daniel Vetter wrote:
>
> > The trouble is that io_remap_pfn adjust vma->pgoff, so we'd need to
> > split that. So ideally ->mmap would never set up any ptes.
>
> /dev/mem makes pgoff == pfn so it doesn't get changed by remap.
>
> pgoff doesn't get touched for MAP_SHARED either, so there are other
> users that could work like this - eg anyone mmaping IO memory is
> probably OK.

I was more generally thinking for io_remap_pfn_users because of the
mkwrite use-case we might have in fbdev emulation in drm.

> > I guess one option would be if remap_pfn_range would steal the
> > vma->vm_ops pointer for itself, then it could set up the correct
> > ->install_ptes hook. But there's tons of callers for that, so not sure
> > that's a bright idea.
>
> The caller has to check that the mapping is still live, and I think
> hold a lock across the remap? Auto-defering it doesn't seem feasible.

Right auto-defering reopens the race, so making this work
automatically is a bit much. I guess just splitting this into a
setup/install part and then doing the install of all the ptes at first
fault should be good enough. We don't really need a new install_pages
for that, just an io_remap_pfn_range that's split in two parts.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
