Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5E72F2EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbhALMYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387473AbhALMYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:24:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53013C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vY5CkWOSzrKwkx+Lg9L+kh7XLyKvhavbRykhww58a7I=; b=g1fziY21uYil16P0MjK0GhYWKp
        t2yCVvSMuSXtQTeYKf3hf1t321JHSA9w4ZRFWQlnlw47zSygIwJmwaOan335OX0GdZ0h4/cEZMQKD
        H70WWpKiTCvtIfupgokFAIuaR11XtF+ClGLCY1+fMP4Vo1XUYK0+F/DHO0U2YKAR6RblXLgQPWG4Y
        RwK4/EKWah80g7dvX+iKLe9NscDOQif6JRb1zj+1842pqxUI1mTQ+/XKj79MnWWuB/HWTBg50dGgw
        Id8eC9Q2oFVxFit1PxUd58OI01TqoRBTZmOWXon14872ryjfO8GEF7oRXE94rhPAi8qe0VLpFE5Ea
        GOQCzu8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kzIhB-004l6r-Ce; Tue, 12 Jan 2021 12:22:55 +0000
Date:   Tue, 12 Jan 2021 12:22:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH] mm: slub: Convert sys slab alloc_calls, free_calls to
 bin attribute
Message-ID: <20210112122245.GK35215@casper.infradead.org>
References: <1610443287-23933-1-git-send-email-faiyazm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610443287-23933-1-git-send-email-faiyazm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 02:51:27PM +0530, Faiyaz Mohammed wrote:
> @@ -5180,6 +5187,7 @@ static int any_slab_objects(struct kmem_cache *s)
>  
>  struct slab_attribute {
>  	struct attribute attr;
> +	struct bin_attribute bin_attr;
>  	ssize_t (*show)(struct kmem_cache *s, char *buf);
>  	ssize_t (*store)(struct kmem_cache *s, const char *x, size_t count);
>  };

I'd rather you added a struct slab_bin_attribute.  If that's even
needed ..  I think you could just use the bin_attribute directly instead
of embedding it in this struct.

