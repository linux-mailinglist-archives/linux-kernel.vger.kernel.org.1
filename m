Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409992DCFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgLQKyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgLQKyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:54:49 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DCBC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:54:09 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o19so30597163lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U2gdYWgfYq7/caNuHmA4slgJYp3VoGcO5t/XEQGLQQ0=;
        b=Y0vnIunm2BtL/nDigBSGNBcw/P80MeXJ3EktmUtjqwbdQoeIMih/9ec50Y2mgdyVGb
         YicrV8G2h8AV7KYlpscj68yN6nUzW0bmrl0gG0ZpUfAycLNiq46+sz0B8r1KAYx1PDq7
         dw4YSLjL7JryxLo9VaWuFT+c+e6kqeKEUeiXQ/vTD6qRGPK+35YudpfKB0RIuykYkhIM
         1r5hDiInL8OOBEMkGwmVjtF3UzBhSIeglXR/Yq6g8C/3CZj+I0mq939SwuzDEGrjza8W
         ffCRQAIVjRM5g1L2nolpR+H5YxTTI6hKuFwtw3oUmloGhOGPHj/qJ9CL7h9enpMfNt+q
         IMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U2gdYWgfYq7/caNuHmA4slgJYp3VoGcO5t/XEQGLQQ0=;
        b=ZIKFEQ2JQQtQGnPtNi+u2EEGbQOyo+L7VODfu1itC/WHGn6YXxtidx5l8FCsCgVBb7
         4iwEiCtCqfbOtOcfsWMuG4Z+SE83HBSVNLKAb38ate9MZywE4WL/FcOgtK8H1gdhWVvr
         OIRRbafTIdqDDYHCk0P82A5iIj3vA+iLTUhvOT7/L8bHjtQCFEYQz802s+0gFW/0U6UI
         D1yx0BHQWIST8W3GEQNO+CuSanjwbKHitKXYjeeH+Pd1Et4/4yIzzLFalDjr8zXNb5Ny
         6v3ir7PbtL5ydVv7QlszPUOP6quR3pt2nqzvSi/cOpdq/E3lM9/2BgHfHLTEL4EqoE2U
         tXJQ==
X-Gm-Message-State: AOAM531Ydy96+csall64opTL6Mugs74QYY80YBhx3AIw4dfXRNAGQSxI
        Zn/MYVszGhXJJ5f6Y23RzvvKdQ==
X-Google-Smtp-Source: ABdhPJw5YnXWpK4XOuli92QD7Gp3bI1r5jX1GrLIR/ZzJhjBrvbLIp9dNy4FbuDSBpMT+m8YLfK+2Q==
X-Received: by 2002:a2e:918f:: with SMTP id f15mr8283125ljg.82.1608202447739;
        Thu, 17 Dec 2020 02:54:07 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j1sm545204lfg.225.2020.12.17.02.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 02:54:07 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 011E31033F4; Thu, 17 Dec 2020 13:54:09 +0300 (+03)
Date:   Thu, 17 Dec 2020 13:54:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries
 when prefaulting
Message-ID: <20201217105409.2gacwgg7rco2ft3m@box>
References: <20201209163950.8494-2-will@kernel.org>
 <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
 <20201209184049.GA8778@willie-the-truck>
 <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
 <20201210150828.4b7pg5lx666r7l2u@black.fi.intel.com>
 <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
 <20201214160724.ewhjqoi32chheone@box>
 <CAHk-=wi80Qp6nZC0yyewhnqvrmPx2h_yWvfq4A25ONb7z9BywQ@mail.gmail.com>
 <20201216170703.o5lpsnjfmoj7f3ml@box>
 <CAHk-=wiVRMADHC0qjTFAVx2Pp0DN-fT-VPC10boDdX0O4=h01w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiVRMADHC0qjTFAVx2Pp0DN-fT-VPC10boDdX0O4=h01w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 10:41:36AM -0800, Linus Torvalds wrote:
> On Wed, Dec 16, 2020 at 9:07 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > If this looks fine, I'll submit a proper patch.
> 
> That patch looks good to me.
> 
> It would be good if somebody else looked it through - maybe I like it
> just because I got to pee in the snow and make my mark. But i think
> that filemap_map_pages() now looks a lot more understandable, and
> having that pte_offset_map_lock() outside the loop should be good.

It worth noting that after the change in the worth case scenario we will
have additional ref/unref and lock/unlock of the page if we get deep
enough into filemap_map_pmd(), but fail to map the page.

Also if the range doesn't have a mappable page we would setup a page
table into the PMD entry. It means we cannot have huge page mapped there
later. It may be a bummer: getting the page table out of page table tree
requires mmap_write_lock().

We also take ptl for cold page cache. It may increase ptl contention, but
it should be negligible with split-ptl.

-- 
 Kirill A. Shutemov
