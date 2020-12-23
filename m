Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FAD2E1C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 13:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgLWMMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 07:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgLWMMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 07:12:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26174C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 04:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8oaG0qKqyS1F6NiV0JGgSi0wPiRzch5yyHCD8liSGYg=; b=k5jgYvcwhPV8Yd9aVd3xqH0GHX
        mAk+cTRNgTcC49Y1IpJ9fcJtYYtLHo2lY45wUWgGP7TBbo64BwsmdPAJZLbz6dVbzoqRjltpfOrU9
        CuXdIVz8aElqF1RtDJ78UH9oZ1qh1yfKTb2SLWaMH1ZeU01WAdUYCkLwmtSsOL7j1cobMva/RutPV
        zFchi+aq9/aRvpaRFPnuQ4afqKN3sPsPIroaH5ySCYT95oZ7UNVqF+PRl0lC7kL1x8KSW8YKv2IWn
        yaBMvKVk4Fi8L0wiVdw1AQXH+CAm4jsS+AVtwKYB+/ny+FyJw4SRqWIMd6pL1nRp6EwWureYZbxf3
        MrTv4iZA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ks2zQ-0003tT-8c; Wed, 23 Dec 2020 12:11:36 +0000
Date:   Wed, 23 Dec 2020 12:11:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: [PATCH] mm: add prototype for __add_to_page_cache_locked()
Message-ID: <20201223121136.GP874@casper.infradead.org>
References: <1608646792-29073-1-git-send-email-jrdr.linux@gmail.com>
 <20201222204000.GN874@casper.infradead.org>
 <20201222155345.e7086ad37967c9b7feae29e4@linux-foundation.org>
 <20201223083126.GA27049@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223083126.GA27049@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 08:31:26AM +0000, Christoph Hellwig wrote:
> Can we please make the eBPF code stop referencing this function instead
> of papering over this crap?  It has no business poking into page cache
> internals.

The reference from the BPF code is simply "you can inject errors here".
And I think we want to be able to inject errors to test the error paths,
no?
