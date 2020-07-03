Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC11213923
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 13:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGCLLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 07:11:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:54744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGCLLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:11:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55C19AEA7;
        Fri,  3 Jul 2020 11:11:14 +0000 (UTC)
Date:   Fri, 3 Jul 2020 13:11:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     qiang.zhang@windriver.com
Cc:     ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        peterz@infradead.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] kthread: work could not be queued when worker being
 destroyed
Message-ID: <20200703111113.GG14288@alley>
References: <20200702070156.5862-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702070156.5862-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-07-02 15:01:56, qiang.zhang@windriver.com wrote:
> From: Zhang Qiang <qiang.zhang@windriver.com>
> 
> The "queuing_blocked" func should print warning message and
> returns true when the worker being destroyed.
>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>

Looks good to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Adding Andrew into CC. Changes in kernel/kthread.c usually goes
through him. You might need to resend the patch once again
with Andrew in CC.

Best Regards,
Petr Mladek
