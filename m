Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3F2C6E0E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 02:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbgK1BBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 20:01:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgK1AwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 19:52:20 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C6221D46;
        Sat, 28 Nov 2020 00:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606524705;
        bh=seZSPmfrCgEO+88cDvs7ZWc7qrlgqROHVINfZRZbMJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O5fvwfuzd9cCkdEsEN+NRjVe9YKj573Wl3xmz9mDfhcj+ND+jUwkm9QADhzzFDBwR
         C/GK312geG1WK7yZCCwl6wPbg/9MuPdMxOGNMFOCTYJfPhgdPs/1YVOA/2aP1tTY3O
         VvHpJlAtPQTmgzUrvQ6QdsalvFK21wVFEBYwX2gk=
Date:   Fri, 27 Nov 2020 16:51:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Oscar Salvador <osalvador@suse.de>, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mm,hwpoison: Disable pcplists before grabbing a
 refcount
Message-Id: <20201127165144.3d788c7dc806788d05157f26@linux-foundation.org>
In-Reply-To: <5512967d-a96a-c94e-7442-e5e71baa7b19@suse.cz>
References: <20201119105716.5962-1-osalvador@suse.de>
        <20201119105716.5962-7-osalvador@suse.de>
        <5512967d-a96a-c94e-7442-e5e71baa7b19@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 14:45:30 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> Note as you say the series should go after [1] above, which means after 
> mm-page_alloc-disable-pcplists-during-memory-offline.patch in mmots, but 
> currently it's ordered before, where zone_pcp_disable() etc doesn't yet exist. 
> Found out as I review using checked out this commit from -next.

Thanks, I reordered them.
