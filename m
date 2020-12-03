Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA442CD2C4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbgLCJl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:41:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:47040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387563AbgLCJl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:41:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9950AC2E;
        Thu,  3 Dec 2020 09:40:46 +0000 (UTC)
Date:   Thu, 3 Dec 2020 09:40:44 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH 1/2] sched: Move '\n' to the prior seq_printf in
 show_schedstat()
Message-ID: <20201203094044.GC3306@suse.de>
References: <66f73a23-a273-7dff-4202-adc61c3152c8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <66f73a23-a273-7dff-4202-adc61c3152c8@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:46:23PM +0800, Yunfeng Ye wrote:
> A little clean up that moving the '\n' to the prior seq_printf. and
> remove the separate seq_printf which for line breaks.
> 
> No functional changes.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
