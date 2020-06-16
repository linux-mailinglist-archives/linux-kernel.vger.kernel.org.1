Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298BA1FB5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 17:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgFPPQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 11:16:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:57520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgFPPQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:16:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72DD5B19C;
        Tue, 16 Jun 2020 15:16:59 +0000 (UTC)
Date:   Tue, 16 Jun 2020 17:16:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, frederic@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, sergey.senozhatsky@gmail.com
Subject: Re: [PATCH 5/6] irq_work: Cleanup
Message-ID: <20200616151654.GQ31238@alley>
References: <20200615125654.678940605@infradead.org>
 <20200615131143.373485207@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615131143.373485207@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-06-15 14:56:59, Peter Zijlstra wrote:
> Get rid of the __call_single_node union and clean up the API a little
> to avoid external code relying on the structure layout as much.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Revieved-by: Petr Mladek <pmladek@suse.com>

I focused on the printk part. But the rest looks fine as well.
It is a nice cleanup.

Best Regards,
Petr
