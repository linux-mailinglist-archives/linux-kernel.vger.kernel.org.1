Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B912CA2B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgLAM3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:29:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:47636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgLAM3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:29:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B55FACC1;
        Tue,  1 Dec 2020 12:28:24 +0000 (UTC)
Date:   Tue, 1 Dec 2020 12:28:20 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        qianjun.kernel@gmail.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/6] sched, fair: use __schedstat_set() in
 set_next_entity()
Message-ID: <20201201122820.GS3306@suse.de>
References: <20201201115416.26515-1-laoar.shao@gmail.com>
 <20201201115416.26515-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201201115416.26515-3-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 07:54:12PM +0800, Yafang Shao wrote:
> schedstat_enabled() has been already checked, so we can use
> __schedstat_set() directly.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
