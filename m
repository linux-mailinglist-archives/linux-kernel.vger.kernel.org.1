Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499D02DF6F0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 22:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgLTVrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 16:47:19 -0500
Received: from casper.infradead.org ([90.155.50.34]:36472 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgLTVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 16:47:19 -0500
X-Greylist: delayed 1394 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Dec 2020 16:47:18 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8CmA/+iqvN3zztpIeSvAxDsfABLhxgTfMQ78M+L2Ba4=; b=TEjAKdJAA8U/aavuONJm/+c5ee
        zF6zg/qV1LsfCAGQoygJKTua+2NZ60LXLY5J2UUHq36Dhu27frqRfU/QZ5haMi4kcmDIb0FQ9TfOa
        pb10RotAM3eH3osS79txNoTuFTsCeLk05pnnTj12UrQ6Yumm84LBNq0qkd5ciAr8z0vgopycQtakX
        AlcKpePovpNQaClpBZTxVvjBXhBzRniqEFo03e4LZAHj4WT6N5JpkAHUqivWwRNkym4DktZ12zUhN
        jXYHp6MyxHPEMrmPAgAxofG+stKTJSTbMZRacm66cwVjXwcQxkb+lVRZKebDatnOU86ogP5smsA+p
        Dr/5877w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kr6Ai-0005t5-Tu; Sun, 20 Dec 2020 21:23:21 +0000
Date:   Sun, 20 Dec 2020 21:23:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/2] log2: handle LARGE input to
 __roundup_pow_of_two()
Message-ID: <20201220212320.GA15600@casper.infradead.org>
References: <20201220211037.1354-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220211037.1354-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 01:10:37PM -0800, Randy Dunlap wrote:
> UBSAN detected a 64-bit shift in log2.h:__roundup_pow_of_two():
>   UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
>   shift exponent 64 is too large for 64-bit type 'long unsigned int'
> 
> This is during a call from mm/readahead.c:ondemand_readahead(),
> get_init_ra_size(), where the 'size' parameter must have been
> extremely large (or "negative").

Actually, I think it was zero, which is the real bug that should be fixed.
