Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19792134F5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 09:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgGCH2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 03:28:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:47144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCH2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:28:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E160CAF43;
        Fri,  3 Jul 2020 07:28:18 +0000 (UTC)
Date:   Fri, 3 Jul 2020 09:28:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     qiang.zhang@windriver.com
Cc:     ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        peterz@infradead.org, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: Don't cancel a work that is being cancelled
Message-ID: <20200703072818.GC11587@alley>
References: <20200702044324.32927-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702044324.32927-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-07-02 12:43:24, qiang.zhang@windriver.com wrote:
> From: Zhang Qiang <qiang.zhang@windriver.com>
> 
> When canceling a work, if it is found that the work is in
> the cancelling state, we should directly exit the cancelled
> operation.

No, the function guarantees that the work is not longer running
when it returns. This is why it has the suffix "_sync" in the name.

We would need to add kthread_cancel_work() without the "_sync"
wrappers that would not wait for the work in progress. But it
might be dangerous. The API users usually want to make sure
that the work in not longer running to avoid races.

What is the use case for the non-sync behavior, please?

Best Regards,
Petr
