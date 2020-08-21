Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CFD24DF1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 20:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHUSJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 14:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgHUSJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:09:35 -0400
Received: from gaia (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC15120738;
        Fri, 21 Aug 2020 18:09:33 +0000 (UTC)
Date:   Fri, 21 Aug 2020 19:09:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, oleg@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] mm/kmemleak: rely on rcu for task stack scanning
Message-ID: <20200821180931.GF6823@gaia>
References: <20200820203902.11308-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820203902.11308-1-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 01:39:02PM -0700, Davidlohr Bueso wrote:
> kmemleak_scan() currently relies on the big tasklist_lock
> hammer to stabilize iterating through the tasklist. Instead,
> this patch proposes simply using rcu along with the rcu-safe
> for_each_process_thread flavor (without changing scan semantics),
> which doesn't make use of next_thread/p->thread_group and thus
> cannot race with exit. Furthermore, any races with fork()
> and not seeing the new child should be benign as it's not
> running yet and can also be detected by the next scan.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

As long as the kernel thread stack is still around (kmemleak does use
try_get_task_stack()), I'm fine with the change:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
