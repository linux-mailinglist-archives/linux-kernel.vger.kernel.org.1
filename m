Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847C728FE9F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 08:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394499AbgJPGyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 02:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394162AbgJPGyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 02:54:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0DC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 23:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6qmV6T/fkjw04YEk4tETd5MpPwH/0OOPAH2ymP/DpVc=; b=ndM3N2H9UJgv0dwSmm6hAx628h
        Hf6/x7fwbqfjb71sajdhWuHIdexSlUT6qZmoBnrUPftILWZJrSxKRkHQOKRFr/SL0J5xsFisirEHu
        XXl3i4wFRhBxPGO8cF0ilc88GjbGphNnwUCVQ723Pr1nYon64Qxx3WfPINc+aGQKDubqhm75AWa19
        0AMOAp/6O2St/+im05QN0aok38sjTB9vYYjApnZRfJy7GIfEuVUuI/yz6h/Unz6l53LdkYP0o4Bx4
        lx6sbKjnUDN1wnpe1yHIIDarGrOUyQ/PoTWRdETrUjQfdl4bNsG85Xiucbhc6bpQMBcyKwaZToyWz
        WqxkeE+w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTJcp-0002W2-I9; Fri, 16 Oct 2020 06:54:03 +0000
Date:   Fri, 16 Oct 2020 07:54:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Christopher M. Riedl" <cmr@codefail.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/8] powerpc/uaccess: Add unsafe_copy_from_user
Message-ID: <20201016065403.GA9343@infradead.org>
References: <20201015150159.28933-1-cmr@codefail.de>
 <20201015150159.28933-2-cmr@codefail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015150159.28933-2-cmr@codefail.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 10:01:52AM -0500, Christopher M. Riedl wrote:
> Implement raw_copy_from_user_allowed() which assumes that userspace read
> access is open. Use this new function to implement raw_copy_from_user().
> Finally, wrap the new function to follow the usual "unsafe_" convention
> of taking a label argument. The new raw_copy_from_user_allowed() calls
> __copy_tofrom_user() internally, but this is still safe to call in user
> access blocks formed with user_*_access_begin()/user_*_access_end()
> since asm functions are not instrumented for tracing.

Please also add a fallback unsafe_copy_from_user to linux/uaccess.h
so this can be used as a generic API.
