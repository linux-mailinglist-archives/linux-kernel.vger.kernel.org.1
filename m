Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA61BE329
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgD2PyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 11:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgD2PyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:54:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DED5C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ga1tL7Cb91RHx4h9wCdEYMImUg579CTIGHOnzw0W/7c=; b=p2KjsrREzZAVZyw/NEbtrqNNc8
        42bWwCX5h7LQ1qjSqRalLYoc6QRPbs15ScE9qVLQ+Xt/M4JJ+11aY92tCij/q4sCXcTYvW4excMFL
        O6TmgGfy92NDPtLEwLBkVS2pbCl/EKmgOVSexZMBZJHgawfqo3Jqit+cJLIG6QKLa2upogw/XE99U
        DpdGbEpAJkjHxxyHi5G2YiPhfSyzm+ZAlxKhGnB/ndkr9zrvQEpez6Vi17fGxsgpBFiq106luVAtc
        WN/kKs5YMoGlu82+r/AE35fLtMgKJPEdvOQ321YjeO2QbZQzegFnwlHyCYNW3bfxWURJGiUU3c0QF
        B3YtAKsQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTp2K-0001Lj-Ma; Wed, 29 Apr 2020 15:54:12 +0000
Date:   Wed, 29 Apr 2020 08:54:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] mm/slub: Fix incorrect interpretation of s->offset
Message-ID: <20200429155412.GT29705@bombadil.infradead.org>
References: <20200429135328.26976-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429135328.26976-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 09:53:28AM -0400, Waiman Long wrote:
> As a result, echoing "1" into the validate sysfs file, e.g. of dentry,
> may cause a bunch of "Freepointer corrupt" error reports like the
> following to appear with the system in panic afterwards.
> 
> [   38.579769] =============================================================================
> [   38.580845] BUG dentry(666:pmcd.service) (Tainted: G    B): Freepointer corrupt
> [   38.581948] -----------------------------------------------------------------------------

I might trim the timestamp and the === and --- from the commit message ...

> To fix it, use the check "s->offset == s->inuse" in the new helper
> function freeptr_outside_object() instead. Also add another helper function
> get_info_end() to return the end of info block (inuse + free pointer
> if not overlapping with object).
> 
> Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of object")
> Signed-off-by: Waiman Long <longman@redhat.com>

But the patch looks great.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
