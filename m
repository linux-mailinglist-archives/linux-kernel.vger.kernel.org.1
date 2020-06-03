Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73CC1ECB1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFCIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 04:10:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgFCIKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:10:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6A628AC37;
        Wed,  3 Jun 2020 08:10:31 +0000 (UTC)
Date:   Wed, 3 Jun 2020 10:10:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     daniel.thompson@linaro.org, kgdb-bugreport@lists.sourceforge.net,
        jason.wessel@windriver.com, dianders@chromium.org,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kdb: Make kdb_printf() console handling more
 robust
Message-ID: <20200603081025.GC14855@linux-b0ei>
References: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
 <1591168935-6382-4-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591168935-6382-4-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-06-03 12:52:14, Sumit Garg wrote:
> While rounding up CPUs via NMIs, its possible that a rounded up CPU
> maybe holding a console port lock leading to kgdb master CPU stuck in
> a deadlock during invocation of console write operations. A similar
> deadlock could also be possible while using synchronous breakpoints.
> 
> So in order to avoid such a deadlock, set oops_in_progress to encourage
> the console drivers to disregard their internal spin locks: in the
> current calling context the risk of deadlock is a bigger problem than
> risks due to re-entering the console driver. We operate directly on
> oops_in_progress rather than using bust_spinlocks() because the calls
> bust_spinlocks() makes on exit are not appropriate for this calling
> context.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>

I think that this was actually suggested by Sergey.

> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Otherwise, it looks good. With updated suggested by:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
