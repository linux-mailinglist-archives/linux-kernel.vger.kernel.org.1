Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE09D2A21FE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 23:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgKAWGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 17:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgKAWGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 17:06:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE82C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 14:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=auZJL386i9bjm2MWt5wDlaf7Q2dtUWWeL5G9LrgakYc=; b=fLt2r7cmGvPtur84cW6FZ2N+Jg
        Nctqmd906xfHrHReBe9tl9Hiw2OHQ9UgvBdYOA8j6yc8GJpVQpURm4+cnxpexuiXHVAVWvdBu6hwV
        aNTO2IY5gHf1orO2e2iud8ZMrVKWFVCkE+IjJ2sDrsrMBREHSI0hWERxBluh5BA+ZBbQc2tSxd652
        i2FlVzD99bJ3wKG13SifoeBWkiOroAVPk6pZrD7h7n/wFGrbUR265tT795rYwllEaHBMDjMiBeWlo
        wMNVlRzYkaJ1ltfQ5BcDKVz3gcwMQ+XhnslKZFCg7Yx0YVq0dZtXV1OKITKD63BzBP9I8NdbkEEFu
        c99tzW/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZLUC-0007bx-7K; Sun, 01 Nov 2020 22:06:04 +0000
Date:   Sun, 1 Nov 2020 22:06:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use
 sysfs_emit_at
Message-ID: <20201101220604.GI27442@casper.infradead.org>
References: <cover.1604261483.git.joe@perches.com>
 <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
 <20201101204834.GF27442@casper.infradead.org>
 <616b92af9378e9f9697555074bba1e377450477f.camel@perches.com>
 <20201101211910.GG27442@casper.infradead.org>
 <bc1a4a2a7ff69eeee131744881e1e8c72444be01.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc1a4a2a7ff69eeee131744881e1e8c72444be01.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 01:43:13PM -0800, Joe Perches wrote:
> > Why did you change this?
> 
> Are you asking about the function argument alignment or the commit message?

The indentation.  Don't change the fucking indentation, Joe.

> > Look, this isn't performance sensitive code.  Just do something simple.
> > 
> > 		if (shmem_huge == values[i])
> > 			buf += sysfs_emit(buf, "[%s]",
> > 					shmem_format_huge(values[i]));
> > 		else
> > 			buf += sysfs_emit(buf, "%s",
> > 					shmem_format_huge(values[i]));
> > 		if (i == ARRAY_SIZE(values) - 1)
> > 			buf += sysfs_emit(buf, "\n");
> > 		else
> > 			buf += sysfs_emit(buf, " ");
> > 
> > Shame there's no sysfs_emitc, but there you go.
> 
> I think what's there is simple.

Again, you're wrong.

> And your suggested code doesn't work.
> sysfs_emit is used for single emits.
> sysfs_emit_at is used for multiple emits.

Oh, ugh, sysfs_emit() should be able to work on a buffer that isn't
page aligned.  Greg, how about this?

+++ b/fs/sysfs/file.c
@@ -722,13 +722,13 @@ int sysfs_emit(char *buf, const char *fmt, ...)
 {
        va_list args;
        int len;
+       int start = offset_in_page(buf);
 
-       if (WARN(!buf || offset_in_page(buf),
-                "invalid sysfs_emit: buf:%p\n", buf))
+       if (WARN(!buf, "invalid sysfs_emit: buf:%p\n", buf))
                return 0;
 
        va_start(args, fmt);
-       len = vscnprintf(buf, PAGE_SIZE, fmt, args);
+       len = vscnprintf(buf, PAGE_SIZE - start, fmt, args);
        va_end(args);
 
        return len;

