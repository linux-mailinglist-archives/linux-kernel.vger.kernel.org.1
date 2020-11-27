Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75982C6A90
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbgK0RZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:25:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgK0RZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:25:46 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E6A2224E;
        Fri, 27 Nov 2020 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606497946;
        bh=JVTpSiRcTZdvNIAeyWzRlZe0G2E7p5QVR8ltVAIxFlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OA03Mq9f/TezmVKlapLdIPhytNm/vtl+yvCeaUIBYhi8ZkTM4AXaM42biiiETxqfh
         xgE/O3UvjOloBjY5JbIhU3Ir7sYG4noemwP1F2/4wPUDrHP3C9/8S5VfxT68SpOaXL
         GTg8U+OKaPTpgcJNwqi72NMqc5kOPmiIX62lryP0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2806140D0D; Fri, 27 Nov 2020 14:25:44 -0300 (-03)
Date:   Fri, 27 Nov 2020 14:25:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf diff: fix error return value in __cmd_diff()
Message-ID: <20201127172544.GM70905@kernel.org>
References: <20201124103652.438-1-thunder.leizhen@huawei.com>
 <CAM9d7cgKDMCst2jEmHMHT7MC0DaTg1naNTt3cZnRepiNkmF-VA@mail.gmail.com>
 <20201127172202.GL70905@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127172202.GL70905@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 27, 2020 at 02:22:02PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 27, 2020 at 10:35:37PM +0900, Namhyung Kim escreveu:
> > On Tue, Nov 24, 2020 at 7:37 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:

> > > An appropriate return value should be set on the failed path.

> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
 
> Thanks, applied.

I also added this:

Cc: Jin Yao <yao.jin@linux.intel.com>
Fixes: 2a09a84c720b436a ("perf diff: Support hot streams comparison")

Please add the fixes line and CC the author of the patch introducing the
bug next time,

Thanks

- Arnaldo
