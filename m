Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429C11AF477
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 22:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgDRUEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 16:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgDRUEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:04:06 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1593420732;
        Sat, 18 Apr 2020 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587240246;
        bh=0nBNiOhYslBGZi3hU6t23pUnSQPLLvrhg3F00+x4rhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TD5HNLsgCT1Q3YLxiBZsmnSj79nVmSV8L581P/wdVS3XDs/xJ5hqfRqky6pfIPPV3
         dwGpvT4Lkp9bHL78VWhuGSgU0V5jme8Oz0Fy7uP/MX2HYmYyNTzJJTL8eKbEJne0E5
         cY0alrHRaPcmdNeP7GotooiUy1MHA3VB8HiAociw=
Date:   Sat, 18 Apr 2020 13:04:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, joe.jin@oracle.com
Subject: Re: [PATCH 1/1] mm: slub: fix corrupted freechain in
 deactivate_slab()
Message-Id: <20200418130405.b1cc0a2d23cbe30d632a3ec7@linux-foundation.org>
In-Reply-To: <d9ebb540-b3ec-a29a-1d7a-2f5762010b53@oracle.com>
References: <20200331031450.12182-1-dongli.zhang@oracle.com>
        <20200417181219.bef9b2f9ade92bf3798e3622@linux-foundation.org>
        <d9ebb540-b3ec-a29a-1d7a-2f5762010b53@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 18:56:51 -0700 Dongli Zhang <dongli.zhang@oracle.com> wrote:

> > @@ -2096,6 +2097,7 @@ static void deactivate_slab(struct kmem_
> >  			slab_fix(s, "Isolate corrupted freechain");
> >  			break;
> >  		}
> > +#endif
> >  
> >  		do {
> >  			prior = page->freelist;
> > 
> > But it's a bit ugly.  How about this?
> 
> Sorry that I did not realize check_valid_pointer() requires CONFIG_SLAB_DEBUG.
> 
> Yes, it is much better to encapsulate it into freelist_corrupted() and just
> return false when CONFIG_SLAB_DEBUG is not involved. The check_object() has
> similar implementation.
> 
> Should I resend with your "Signed-off-by" or you would just fix it when applying?

That's OK.  I'll fold the patches together and update the changelog
before sending the patch in to Linus.

