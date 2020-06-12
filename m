Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF1F1F75F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 11:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgFLJaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 05:30:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:59948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgFLJaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:30:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A4B5ADC5;
        Fri, 12 Jun 2020 09:30:02 +0000 (UTC)
Date:   Fri, 12 Jun 2020 11:29:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Ilias Stamatis <stamatis.iliass@gmail.com>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: remove incorrect comment in
 kthread_create_on_cpu()
Message-ID: <20200612092958.GD4311@linux-b0ei>
References: <20200611135920.240551-1-stamatis.iliass@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611135920.240551-1-stamatis.iliass@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-06-11 16:59:21, Ilias Stamatis wrote:
> Originally kthread_create_on_cpu() parked and woke up the new thread.
> However, since commit a65d40961dc7 ("kthread/smpboot: do not park in
> kthread_create_on_cpu()") this is no longer the case. This patch removes
> the comment that has been left behind and is now incorrect / stale.
> 
> Signed-off-by: Ilias Stamatis <stamatis.iliass@gmail.com>

Good catch!

Fixes: a65d40961dc7 ("kthread/smpboot: do not park in kthread_create_on_cpu()")
Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
