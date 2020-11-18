Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FFF2B85EF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgKRUqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgKRUqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:46:31 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E72BC0613D4;
        Wed, 18 Nov 2020 12:46:31 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D92282EF;
        Wed, 18 Nov 2020 20:46:30 +0000 (UTC)
Date:   Wed, 18 Nov 2020 13:46:29 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>, Zi Yan <ziy@nvidia.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/vm: remove unused 3 items explanation for
 /proc/vmstat
Message-ID: <20201118134629.31b3cdf8@lwn.net>
In-Reply-To: <1605520282-51993-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605520282-51993-1-git-send-email-alex.shi@linux.alibaba.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 17:51:22 +0800
Alex Shi <alex.shi@linux.alibaba.com> wrote:

> Commit 5647bc293ab1 ("mm: compaction: Move migration fail/success
> stats to migrate.c"), removed 3 items in /proc/vmstat. but the docs
> still has their explanation. let's remove them.
> 
> "compact_blocks_moved",
> "compact_pages_moved",
> "compact_pagemigrate_failed",

So a quick look says that the above-mentioned patch didn't remove those
three items; two of them were, instead, renamed.  Rather than just taking
out the old information, it seems we should actually update it to reflect
current reality?

Thanks,

jon
