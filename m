Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A88C2DE2B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 13:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgLRMSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 07:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgLRMSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 07:18:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73838C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 04:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I6Jc1yJjcNRC/skT3yP0vC8c2+p2pnxaOzpHPFUwwOA=; b=AOVmnq/OYugj7hrwBq6E0fUU+3
        L46xEaZCG5ccilFMkBnAe6XgAx9OM7OiQc1G5CPSEoSkVOhIHaDDEvxDQNka9U1DqqYppcWO2u0NZ
        l7RAfbsLNHXW3fROkLTBSQttgh5nDLLaG5a1I8/372S15q7tHN6Pa/O2nQJ6JzRnMJRK76YVUclmv
        1QK21mB7MgDSwO1MvlnvLaXDp02wspjb5OmHeOvP/SNc+izzMCwQzdmhXOD2fvgPeytyXnceNe33m
        jxaV21oVi9VKoJq/NocLl5yOdEfoMr9OE/lGB3l6T7lgBBW0w2sychLlufVVaLH1KEB9t40QIqx+z
        NA80GEdg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqEhk-00071q-Sa; Fri, 18 Dec 2020 12:17:52 +0000
Date:   Fri, 18 Dec 2020 12:17:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jacob Wen <jian.w.wen@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/vmscan: DRY cleanup for do_try_to_free_pages()
Message-ID: <20201218121752.GK15600@casper.infradead.org>
References: <20201218102217.186836-1-jian.w.wen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218102217.186836-1-jian.w.wen@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 06:22:17PM +0800, Jacob Wen wrote:
> This patch reduces repetition of set_task_reclaim_state() around
> do_try_to_free_pages().

what is a DRY cleanup?
