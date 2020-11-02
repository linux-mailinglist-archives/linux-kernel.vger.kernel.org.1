Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB28C2A2C48
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgKBOIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKBOIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:08:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188EDC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rXbYTzMH5+21up+d520jyOeCTieBV+RqI0Jv3IRaYFc=; b=gmSIVHcNIL4p11AY1fEnKWj9v8
        eLFcihyAiXIwhxD2Yt90R4yd7VeN/sp3UjX2iAmc+Vdjp6qRK2kLAfvYX/GKf3GZU9OBlETYGlfIF
        9py3qr9JwnMX8SyERDWt+lSYSsTZfk2x3+Hl9wGr5vFJpA3oROSmifFRA/sQLPQY9yjcp0AJP6MWP
        Fvo/x8qsvnovciQ4/h2707YJukPhixmvGAx4U1hFM71qsNwsU235fsf2JdylJrMN6s9Gazy4EiHf8
        3gvgmgYhcT1is0C/gjk66wi107NUoEU2gslaM2IdBWzEP0Zl9u0AX0I8LTLaM+3K/iwG8sKCuLOs0
        DpQkFtDw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZaVg-0004gC-W5; Mon, 02 Nov 2020 14:08:37 +0000
Date:   Mon, 2 Nov 2020 14:08:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use
 sysfs_emit_at
Message-ID: <20201102140836.GJ27442@casper.infradead.org>
References: <cover.1604261483.git.joe@perches.com>
 <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
 <20201101204834.GF27442@casper.infradead.org>
 <616b92af9378e9f9697555074bba1e377450477f.camel@perches.com>
 <20201101211910.GG27442@casper.infradead.org>
 <bc1a4a2a7ff69eeee131744881e1e8c72444be01.camel@perches.com>
 <20201101220604.GI27442@casper.infradead.org>
 <20201102133343.GA1011963@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102133343.GA1011963@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 02:33:43PM +0100, Greg Kroah-Hartman wrote:
> > Oh, ugh, sysfs_emit() should be able to work on a buffer that isn't
> > page aligned.  Greg, how about this?
> 
> How can sysfs_emit() be called on a non-page-aligned buffer?  It's being
> used on the buffer that was passed to the sysfs call.
> 
> And if you are writing multiple values to a single sysfs file output,
> well, not good...

See shmem_enabled_show() in mm/shmem.c (output at
/sys/kernel/mm/transparent_hugepage/shmem_enabled on your machine).

I don't claim it's a good interface, but it exists.
