Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FBF2E0C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgLVOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbgLVOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:52:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6EEC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0yQ8UYqXYhuWeo88yhwpae0/ouSJbgBQji4T5APlSZo=; b=lJcTKd0y1qgaGiy6Xvw8aQkzsN
        tl8FNYsXi9WQht26DlkWcH12TWUtegtaNDHLtiiW79CwVUicw5/u4SSNOAzB+Y7jE/w6fKPChOAx7
        9AbuP0fhQTja6ZjKRCainCiAbfnrU5jQCVnQLEYYQiTqPIe517eRvDF2eALdVo2TYo7j33A2us2Le
        RZW2/IXi8V+GFpmYehzHHJ9SADstknPLqUmAT2MFEo+LQOafP+Uc6vTiPVpzEsRY/hHWOUkaotDpK
        u94rkoJwDguo5d7Qhk//ZpLiwjkoyAeLPxQPVCFYs+xqW8ukmyUkGJnxXFx4MN0POQII4gjq4XbsN
        fytn2dMw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krj0k-0006s1-FV; Tue, 22 Dec 2020 14:51:38 +0000
Date:   Tue, 22 Dec 2020 14:51:38 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Adrian Huang <adrianhuang0701@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] x86/mm: Refine mmap syscall implementation
Message-ID: <20201222145138.GA25752@infradead.org>
References: <20201217052648.24656-1-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217052648.24656-1-adrianhuang0701@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 01:26:48PM +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> It is unnecessary to use the local variable 'error' in the mmap
> syscall implementation function, so use the return statement
> instead of it.

I'm normally not a fan of standalone cleanup patches, but this one
actually improves the function a lot, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
