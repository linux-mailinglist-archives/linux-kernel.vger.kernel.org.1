Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16202AB1C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgKIHhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:37:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:57480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbgKIHhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:37:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604907428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g/PynSuV8B/34816mCj4wqI5WVsbyHQQr0XxJVvTNIo=;
        b=oIVN8JybJ7CZI+XPTUH5xh4Sj04Ey0hAzBc33gWEdd4MyEAYPWjESz/sTnXsvi+J1sl+gw
        rpmRgH1ZF+qMLV9l/+xfTPDYmR7IUGRokWdRDH73Xng6h/qOELhPnyetYNj1PbbA4UbvKP
        494+FKvPnHfBw2BlPSplltmBKF5qbc4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C985AABAE;
        Mon,  9 Nov 2020 07:37:08 +0000 (UTC)
Date:   Mon, 9 Nov 2020 08:37:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: introduce oom_kill_disable sysctl knob
Message-ID: <20201109073706.GA12240@dhcp22.suse.cz>
References: <20201106203238.1375577-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106203238.1375577-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-11-20 12:32:38, Minchan Kim wrote:
> It's hard to have some tests to be supposed to work under heavy
> memory pressure(e.g., injecting some memory hogger) because
> out-of-memory killer easily kicks out one of processes so system
> is broken or system loses the memory pressure state since it has
> plenty of free memory soon so.

I do not follow the reasoning here. So you want to test for a close to
no memory available situation and the oom killer stands in the way
because it puts a relief?

> Even though we could mark existing process's oom_adj to -1000,
> it couldn't cover upcoming processes to be forked for the job.

Why?

> This knob is handy to keep system memory pressure.

This sounds like a very dubious reason to introduce a knob to cripple
the system.

I can see some reason to control the oom handling policy because the
effect of the oom killer is really disruptive but a global on/off switch
sounds like a too coarse interface. Really what kind of production
environment would ever go with oom killer disabled completely?

-- 
Michal Hocko
SUSE Labs
