Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB551CA19B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 05:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgEHDgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 23:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgEHDgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 23:36:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA770C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 20:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UxNMWZjNhfV34kPVBQKKTvAd+cCvU1MJhKY7a3erSOs=; b=exK3GG9NDiCumIvC5L939lj7NO
        W37nuFbrVWsR/5ORD2kYGjuFrUzErDYHi75DQ+4mQVEYg06AaRT2qyGxzjEOoorztE1YRYQnkTDQ0
        WEHtvYeBNIeHTURKKOJS/xPUm8zKklsPkGQt1kUPSALzdPVhdp329URlcUkpYxt6Bf7aaC6JNmn7q
        hi6E7uwkx3CHRm2ZhGRNGhUmBR8WRieHmXdPYBaXCioGbW3ylIT9eD6X2HNL8LzuhsR5Cybf/uil6
        yNegQWAd/JWnGDslxfd//DZ5vzJyxZGLMc2lDkCu+0stktCJ0fkWq+WAkpSwav6HqXXM1mmQd8efV
        uRz+UPqw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWtoH-0007Zm-QA; Fri, 08 May 2020 03:36:25 +0000
Date:   Thu, 7 May 2020 20:36:25 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vasily Averin <vvs@virtuozzo.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] ipc/util.c: sysvipc_find_ipc() incorrectly updates
 position index
Message-ID: <20200508033625.GO16070@bombadil.infradead.org>
References: <ad24ee52-21a8-3ff0-e968-63d315472b91@virtuozzo.com>
 <4921fe9b-9385-a2b4-1dc4-1099be6d2e39@virtuozzo.com>
 <20200507170242.6cbb88ae672deed67152e221@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507170242.6cbb88ae672deed67152e221@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 05:02:42PM -0700, Andrew Morton wrote:
> Here's how I resolved things.  Please check?
> 
> static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
> 					      loff_t *new_pos)
> {
> 	unsigned long index = pos;
> 	struct kern_ipc_perm *ipc;
> 
> 	rcu_read_lock();
> 	ipc = xa_find(&ids->ipcs, &index, ULONG_MAX, XA_PRESENT);
> 	if (ipc)
> 		ipc_lock_object(ipc);
> 	else
> 		rcu_read_unlock();
> 	*new_pos = pos + 1;
> 	return ipc;
> }

Surely that should be '*new_pos = index + 1'?  Or did I misunderstand
the reasoning behind the other patch?

