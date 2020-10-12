Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B71B28BD1F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390130AbgJLQBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:01:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:59729 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389562AbgJLQBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:01:51 -0400
IronPort-SDR: uAj1jFW6sx1q/C7flGeGNjSIwh37YbyS3DEapkf/wIIZgIRA81oNSYGZ+kc+fzI8LvsI/xa921
 tdnBMCefdg/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="162294887"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="162294887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 09:01:50 -0700
IronPort-SDR: i3U8DHjXh/yBEJFOCr5LqII2KTjE24KOAFjbSVcqwBuULDFxKnHJtSf1zU97ffz0AQiK3v387Z
 h2RNmFWjsG8A==
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="520734047"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 09:01:49 -0700
Date:   Mon, 12 Oct 2020 09:01:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 02/15] perf report: output trace file name in raw
 trace dump
Message-ID: <20201012160144.GA466880@tassilo.jf.intel.com>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <87e2050b-37e6-8ed8-e1e0-cfa074b030fa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e2050b-37e6-8ed8-e1e0-cfa074b030fa@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:54:24AM +0300, Alexey Budankov wrote:
> @@ -180,7 +183,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
>  						    ordered_events);
>  
>  	return perf_session__deliver_event(session, event->event,
> -					   session->tool, event->file_offset);
> +					   session->tool, event->file_offset,
> +					   event->file_path);

Wouldn't it be better to pass "event" around now, which would contain at least
four of the arguments.

These functions are getting entirely too many arguments.

-Andi

