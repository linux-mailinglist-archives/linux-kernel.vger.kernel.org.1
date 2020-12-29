Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF93D2E74FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 23:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgL2WYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 17:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL2WYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 17:24:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC562C061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 14:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j/bNtqMm2dxQxj54tA+5zXYhll2ElA1bhXS58HU9rB8=; b=HF87GccL7FEt19lB2EOb+Dp1vL
        pJwxP4UUvqUkpZLrydtqaiJ6BMXK5dYiDyflIsEremMLY1RDv1d5wPWb2uBdcoLg1ahhcREGhwdtq
        JEYPbVZmI0fo5XY1nBo7Ft677yCx+6f9jGdTDEiuO8agsCmZX2BFdz5kQ7DKDjOzqFhy4qrQJf85i
        O2w17+RGBkyx1IrrGh+cDLxY7mE4lVQ/MK0z57C8w9M21pmu2PRVGmHO2XLS1TjAdxxp7yOT7CD+w
        zJKnUoqBj1NaMpWeBeHjSDfIirUbZd9Ohu1xfqJtmEroBAZjp2bhNMnWRU/IfaW7+HnM3ie1mrMaC
        tD3+xH3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kuNOZ-000H1i-D0; Tue, 29 Dec 2020 22:23:18 +0000
Date:   Tue, 29 Dec 2020 22:23:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org
Subject: Re: [PATCH -mm] mm: readahead: apply a default readahead size
Message-ID: <20201229222311.GD28221@casper.infradead.org>
References: <20201229212634.31307-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229212634.31307-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 01:26:34PM -0800, Randy Dunlap wrote:
> UBSAN reports an invalid shift size:
> 
> mr-fox kernel: UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
> mr-fox kernel: shift exponent 64 is too large for 64-bit type 'long unsigned int'
> 
> Original report:
> https://lore.kernel.org/lkml/c6e5eb81-680f-dd5c-8a81-62041a5ce50c@gmx.de/
> 
> Follow-up report:
> https://lore.kernel.org/lkml/0c283ea9-b446-0e40-6dc8-e9585ae171b4@gmx.de/T/#m9b604660925f9e8a544f7453130c31d083c1e5bb
> 
> 
> Willy suggested that get_init_ra_size() was being called with a size of 0,
> which would cause this (instead of some Huge value), so add a check in
> that function for size == 0, and if 0, default it to 32 (pages).

No, this is wrong.  'size' in this case is the size of the read.
And it's zero.  Is this fixed by commit
3644e2d2dda78e21edd8f5415b6d7ab03f5f54f3

