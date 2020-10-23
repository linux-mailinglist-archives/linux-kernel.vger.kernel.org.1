Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88E12975F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753769AbgJWRqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465983AbgJWRqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:46:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4367C0613CE;
        Fri, 23 Oct 2020 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JfgsMhDbA99tcfIDEdFDKWaKwDcgvevNjRrzupEstqc=; b=gT0IY0JmTzxQUE4TMALayuyU0G
        IlhoOngDJz3NUWpD6MhDbx6pG76uTFJ+5M/X5P7EgY/NvR4kHZUxtv9lKxQV1tXl18o+7r79x1ygD
        QQjDe1/Z9W2Y0rIq9HtVir/ZAEZTcR/skeTxisuS4I2lNF6afqdmq+GGrzE2PyrldGw50ydq+tG7s
        zOzxygauyU7q4zxuyV0wQ1biMv0FJO6xBl9sHhIQhqvCZXvZJlJJrBoERunKuvZR8VGaWjDD6KizT
        UONR98jNrsC3EkIZP2+VGIevI7zK0IgUT0j98y7o+V/TBKptTYHOj0K6K7g9KpbJGP/AJ5RMGQXCm
        nUBzQdlA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kW18h-0005j1-Ph; Fri, 23 Oct 2020 17:46:08 +0000
Date:   Fri, 23 Oct 2020 18:46:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 54/56] mm: fix kernel-doc markups
Message-ID: <20201023174607.GD20115@casper.infradead.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <61d452a7006c9aca9bb352bfa6ed52537dba5060.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d452a7006c9aca9bb352bfa6ed52537dba5060.1603469755.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 06:33:41PM +0200, Mauro Carvalho Chehab wrote:
>  /**
> - * This helper is similar with the above one, except that it accounts for pages
> - * that are likely on a pagevec and count them in @nr_pagevec, which will used by
> + * invalidate_mapping_pagevec - This helper is similar with
> + * invalidate_mapping_pages(), except that it accounts for pages tat are

You introduced a typo here, s/tat/that/

> + * likely on a pagevec and count them in @nr_pagevec, which will used by

... and while you're touching this paragraph, s/will used/will be used/
and s/similar with/similar to/

>   * the caller.
> + *
> + * @mapping: the address_space which holds the pages to invalidate
> + * @start: the offset 'from' which to invalidate
> + * @end: the offset 'to' which to invalidate (inclusive)
> + *
>   */
>  void invalidate_mapping_pagevec(struct address_space *mapping,
>  		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec)
> -- 
> 2.26.2
> 
> 
