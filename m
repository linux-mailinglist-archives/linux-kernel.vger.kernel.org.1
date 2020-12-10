Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717282D53B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 07:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbgLJGT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 01:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgLJGT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:19:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B63C0613CF;
        Wed,  9 Dec 2020 22:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ye2aSnJjX217xHUTyrjdBL8gLFd5rK3vrFBT0OM+VfU=; b=Pkrw2geFluvRyAKwXKahvAtr44
        USMnGC6mFVM/j5Z0D2x4P9aRs5sfujT7iOCGnY6njN5Dz6uJSvMuT5nqCUcQYBLUAXL1rZdhKaR7Z
        BQPSoEQ253ZSYLgeo/34twEw1o9tScrghi8oOia5tyQMDIlsiA88E9Tkr0NKZrfOab/f5rygAXgzp
        10fFE+gHOdR8Us1Aw9yPC7nJxMdNbCdseofuLWchl1hghCiUgy77h1z/FLbLHD3OeSmYDgG8QUPQ9
        4oHj/20/Ro7Lr08NupUenNcp9HOkZmdGeAKBy9WxqcHxAqwdTjCpU8z8MSkpUUX7d5Y0Or/n8KHU/
        nyfFtcog==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knFHo-0005XA-Az; Thu, 10 Dec 2020 06:18:44 +0000
Date:   Thu, 10 Dec 2020 06:18:44 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] block: blk-iocost: fix build for ARCH with missing
 local64.h files
Message-ID: <20201210061844.GA21126@infradead.org>
References: <20201209204657.6676-1-rdunlap@infradead.org>
 <20201210060742.GA19263@infradead.org>
 <04828b4e-8791-6f3e-8984-9de06f40c85a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04828b4e-8791-6f3e-8984-9de06f40c85a@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 10:16:20PM -0800, Randy Dunlap wrote:
> include/asm-generic/local64.h has comments about some $arch could do
> its things better/faster instead of using asm-generic, but no $arch has
> done that since 2010 when it was added.
> 
> Is that conclusive?
> If it is, why even use mandatory-y?
> Why not just change all occurrences of <asm/local64.h>
> to <asm-generic/local64.h> ?

asm-generic must not be included by non-arch code directly.  So the
sensible options are either:

 a) mark it as mandatory-y in include/asm-generic/Kbuild
 b) rename it to linux/local64.h and fixup all references

a) seems much less invasive, but b) might be the better option long
term.
