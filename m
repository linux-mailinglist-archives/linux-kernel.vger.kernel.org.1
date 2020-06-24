Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6152079D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 19:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405344AbgFXRBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404959AbgFXRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:01:49 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF74DC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1baVfimWLcXjNC1LOBhrvYVgFXcqgjspjMtUDc+uHOg=; b=FsRK7tXtToINS4RWLZ6bldI3ZR
        svjWT2G3Htdr+57klE8pWMcwOgxpJge+NOntnu1bRGoXiS6VuWzE+JyGgHB9pnR9AqvcR5MF3qZVw
        g7ZHqtGt2hPHbtqLklJWTUGQJiLC+ph00eHFm4I5tbKi+7RanswXUOFqBQm67uT/unUvGJOkSWcbP
        XpIk4aVNJ0t8K7iqUjL2/DUVu/UWfkdrn79w3sULpCyBR7IljycqxW64pxfYpYuevFA/ul3bLZucw
        ayTdO3f54gPtRJAEygoVxwzcWV1T3uyCUD1hEGgOh1Kq++rjNEhQipjwKEQR/VD1bVt6vpsXgDF17
        qWTPZvfA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo8mB-0000An-Aq; Wed, 24 Jun 2020 17:01:31 +0000
Date:   Wed, 24 Jun 2020 18:01:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rafael Aquini <aquini@redhat.com>,
        Fabrizio D'Angelo <fdangelo@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/page_alloc: fix documentation error and remove
 magic numbers
Message-ID: <20200624170131.GQ21350@casper.infradead.org>
References: <20200624164943.32048-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624164943.32048-1-jsavitz@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:49:43PM -0400, Joel Savitz wrote:
> When I increased the upper bound of the min_free_kbytes value in
> ee8eb9a5fe863, I forgot to tweak the above comment to reflect
> the new value. This patch fixes that mistake.
> 
> In addition, this patch replaces the magic number bounds with symbolic
> constants to clarify the logic.
> 
> changes from v1:
> - declare constants via enum instead of separate integers
> 
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>

NAK.  Just fix the documentation.  It's bad form to combine two completely
different things in one patch anyway.
