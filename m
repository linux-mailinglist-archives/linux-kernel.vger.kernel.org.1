Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82112C4073
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgKYMqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKYMqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:46:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6E2C0613D4;
        Wed, 25 Nov 2020 04:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AOuNFlot/VyZabqwTIsLmcD2t/G7f3vZneAFiQv6T6c=; b=KEa6PL7BAbuR5GDeG0E/m6yG1y
        DSuILW9uHkBwm9sUaooAAuTk+2TsRtyOo8emEqt8DjHqpThcZYTRwfARucMLlL34aK7h0Hp3ao/+l
        NrEvthAJDpIc42zLtHmYA0j0h0myOm8yqTVov2qewm4Y71tIIucuqh0nC7UqddOjqUso0YnMo6n4B
        y4WtGTqHRYpElIHNqv+okvxU2yqD4uVPnGIzefQiFAZgynlBwMnRqGFbuQwpKpu6mmpOWT9u9uPmt
        0pFaF4q3tu2NZqTnPRFsnRKaGIrg/OaWlLw3ig+LpGiSjUOVeJXiGiKUJxSzNtKZ7eSwOBpvs9JYQ
        ZYAYPk1g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khuBP-0004eu-Ba; Wed, 25 Nov 2020 12:46:03 +0000
Date:   Wed, 25 Nov 2020 12:46:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, davem@davemloft.net, rppt@kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm: Move free_unref_page to mm/internal.h
Message-ID: <20201125124603.GL4327@casper.infradead.org>
References: <20201125034655.27687-1-willy@infradead.org>
 <20201125034655.27687-2-willy@infradead.org>
 <6418f355-ae69-a0bc-3006-b89a4e1cc09c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6418f355-ae69-a0bc-3006-b89a4e1cc09c@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 01:34:04PM +0100, Vlastimil Babka wrote:
> On 11/25/20 4:46 AM, Matthew Wilcox (Oracle) wrote:
> > Code outside mm/ should not be calling free_unref_page().  Also
> > move free_unref_page_list().
> 
> Good idea.
> 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> There seems to be some effort to remove "extern" from function declarations
> from headers. Do we want to do that, at once, or piecemeal? If the latter,
> this is a chance for these functions at least :)

I'm generally in favour of those efforts, but since I was just moving
the function declarations, and all the code near the destination was
using 'extern', I decided not to remove it so as to avoid getting caught
up in bikeshedding ...
