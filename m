Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2712075AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 16:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403813AbgFXO16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 10:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390161AbgFXO15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:27:57 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE7DC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B/J/FyLP/cMIITemkspmNPRPSrnTgO5+iMCk+rIrMjM=; b=fTHXbrpCNIaXRmGIlFIzloHQWu
        BefmN2QQ0pisXXhOvnyQ6qCVkwZyhiaNPwpapudqETMZ0aGNFS538bNGR0AdHhKkeSZ9hvexmFbY4
        VyuOkBd+g8RJ+SQ/JDXH1dvjileLyG8oox+d3kYjVNF9CWK5fv9ZY7UuogIAk+l0EXe22836Eqtkc
        hihNt12XrBJIe6cS2SkYL9IObIRQLhT1dkuKyXJvHbxTQlu9pSdWK0huV+WIxBhEx90g4gBi5uOp7
        y1A/WINxN+h1XIqcC7uuYH6xnrbF9hd2egil1WG3mcF1VHslWgnoNufND0LlhHTH1X6uXlyZGz7lQ
        F2dZvMnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo6NI-0000qG-El; Wed, 24 Jun 2020 14:27:40 +0000
Date:   Wed, 24 Jun 2020 15:27:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page_alloc: fix documentation error and remove magic
 numbers
Message-ID: <20200624142740.GO21350@casper.infradead.org>
References: <20200624032712.23263-1-jsavitz@redhat.com>
 <20200624111255.GL21350@casper.infradead.org>
 <20200624140727.GA1987277@optiplex-lnx>
 <20200624140958.GN21350@casper.infradead.org>
 <20200624142626.GB1987277@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624142626.GB1987277@optiplex-lnx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:26:26AM -0400, Rafael Aquini wrote:
> Joel's approach, however, makes sense if you consider it's generally a 
> good practice to get rid of the unnamed magic numbers anti-pattern.

But I don't.  I care about how easy it is to understand the code, not
conforming to some bullshit trendy word salad.
