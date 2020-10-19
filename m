Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0080F292B29
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgJSQJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:09:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:38817 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730442AbgJSQJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:09:46 -0400
IronPort-SDR: TPtn23TwsKulshaFPj9KtL7mwwGF99OL/iVsjZWxf0eb9s1drndQPkvweV1/UH+krsx7iPF92E
 ktwXT0SNo04w==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="146350758"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="146350758"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 09:09:45 -0700
IronPort-SDR: Bcndka2HtJgDXafrszWHZbcU6LRa6XYXixd73yf7qHmoyuo4d28JxlyJeaZLLl4ic05TAIpGqt
 hpi9xxoYHvMQ==
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="465579187"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 09:09:45 -0700
Date:   Mon, 19 Oct 2020 09:09:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Add event constraint for
 CYCLE_ACTIVITY.STALLS_MEM_ANY
Message-ID: <20201019160944.GK466880@tassilo.jf.intel.com>
References: <20201019150158.31635-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019150158.31635-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 08:01:58AM -0700, kan.liang@linux.intel.com wrote:
> Add a line for the CYCLE_ACTIVITY.STALLS_MEM_ANY event in the ICL
> constraint table.
> Correct the comments for the CYCLE_ACTIVITY.CYCLES_MEM_ANY event.

Thanks Kan.

> 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

I guess this should have a Fixes: tag and also be proposed for
stable.

-Andi

