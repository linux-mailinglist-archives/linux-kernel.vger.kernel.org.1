Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312121BA642
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgD0OWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 10:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgD0OWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:22:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1FC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9epgz8WRXrtU6IImjK3/yyqjBcvbZymElclLrOdmIdg=; b=XXmn7huD7Rh4YffwB3SLpcq9uU
        Kd9pEAPv6vP/moOu88+xkOQNtVPl/yNclBs92i1ITmnqs2tWVoOVzDHCDjbWCA9ZV9eUoXbrgN5H3
        7lLqydjkrMJF8Nfub7YCRG5PiNp8xwfrpD0FglnHlaM3yZwMpIJbQT/mWSUXY5xMOP5D7fgYzypk3
        G7KL51QzTRRtaRrB8ahw5kB324ermwwpHaFKidd2kRhJH/M/jJK/QiZkmz/Waqct1IQ0jB/fPeAU3
        H8ZtvT3AhdLjfbgszf6l0PrOVMx5So4YZLNbAGN0gHh/UGHbKats092L2gnc5X3han8SkhlWPCZe9
        WLCjlTuQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT4e4-0002bG-F0; Mon, 27 Apr 2020 14:22:04 +0000
Date:   Mon, 27 Apr 2020 07:22:04 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2] mm/slub: Fix incorrect interpretation of s->offset
Message-ID: <20200427142204.GG29705@bombadil.infradead.org>
References: <20200427140822.18619-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427140822.18619-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:08:22AM -0400, Waiman Long wrote:
> In a couple of places in the slub memory allocator, the code uses
> "s->offset" as a check to see if the free pointer is put right after the
> object. That check is no longer true with commit 3202fa62fb43 ("slub:
> relocate freelist pointer to middle of object").
> 
> As a result, echoing "1" into the validate sysfs file, e.g. of dentry,
> may cause a bunch of "Freepointer corrupt" error reports like the
> following to appear with the system in panic afterwards.
> 
> [   38.579769] =============================================================================
> [   38.580845] BUG dentry(666:pmcd.service) (Tainted: G    B): Freepointer corrupt
> [   38.581948] -----------------------------------------------------------------------------
> 
> To fix it, use the check "s->offset == s->inuse" in the new helper
> function freeptr_after_object() instead. Also add another helper function
> get_info_end() to return the end of info block (inuse + free pointer
> if not overlapping with object).
> 
> Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of object")
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
