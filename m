Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE34217887
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 22:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgGGUEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 16:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgGGUEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:04:07 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2C5206F6;
        Tue,  7 Jul 2020 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594152246;
        bh=lOqxPHD1G7v4ptCDcrU8Zzd0/sIT1tjdxKx6H0SH6CE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZMH8B4e4BRy7pNzi9c8aXzN6seq1gBHeil+eQ9hiIVQ8URQja30LSG6juVf3BboAK
         eqmvjEeVsslRYG1GyeqNTPPdk6ri3P0pNFuC3bsDHKCp14dL8DekEVflRRCZM/xDRJ
         VrscB+AV4GSw6wX0kntnBxGxQ/qOh31JOGMkQXzc=
Date:   Tue, 7 Jul 2020 13:04:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mm/vmstat: Add events for THP migration without
 split
Message-Id: <20200707130406.21ce3d61a4cce25831abb2d1@linux-foundation.org>
In-Reply-To: <1594080415-27924-1-git-send-email-anshuman.khandual@arm.com>
References: <1594080415-27924-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jul 2020 05:36:55 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> Add following new vmstat events which will help in validating THP migration
> without split. Statistics reported through these new VM events will help in
> performance debugging.
> 
> 1. THP_MIGRATION_SUCCESS
> 2. THP_MIGRATION_FAILURE
> 3. THP_MIGRATION_SPLIT
> 
> In addition, these new events also update normal page migration statistics
> appropriately via PGMIGRATE_SUCCESS and PGMIGRATE_FAILURE. While here, this
> updates current trace event 'mm_migrate_pages' to accommodate now available
> THP statistics.

Patch looks straightforward enough.  It would be nice to see some
confirmation from others that these metrics are a desirable thing to
export.

> ...
>
> -	trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);
> +	if (nr_thp_succeeded)
> +		count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
> +	if (nr_thp_failed)
> +		count_vm_events(THP_MIGRATION_FAILURE, nr_thp_failed);
> +	if (nr_thp_split)
> +		count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);

Are these "if"s worthwhile to have?

> +	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
> +			       nr_thp_failed, nr_thp_split, mode, reason);


