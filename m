Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66929808B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 06:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767078AbgJYFas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 01:30:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:57204 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390332AbgJYFar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 01:30:47 -0400
IronPort-SDR: roVLaPsccHjPrP0y/OFFQ8FdQOHw0HklyDmpaVtJbpYHVodY1jMfE0BT9FvvvB0sDxrUMr127C
 I6uby+z1rPsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9784"; a="147103834"
X-IronPort-AV: E=Sophos;i="5.77,414,1596524400"; 
   d="scan'208";a="147103834"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2020 22:30:46 -0700
IronPort-SDR: UqOdMLpqeaOJGRdmFtchIX7fm31n+hGQHCbX4LZQi8RbkzJGrpwKZeKY8xGIIc1SlqSSAiA39G
 fMPzU6lzAXWQ==
X-IronPort-AV: E=Sophos;i="5.77,414,1596524400"; 
   d="scan'208";a="317516426"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2020 22:30:46 -0700
Date:   Sat, 24 Oct 2020 22:30:45 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf test: Use generic event for
 expand_libpfm_events()
Message-ID: <20201025053045.GV466880@tassilo.jf.intel.com>
References: <20201024025918.453431-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024025918.453431-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 11:59:17AM +0900, Namhyung Kim wrote:
> I found that the UNHALTED_CORE_CYCLES event is only available in the
> Intel machines and it makes other vendors/archs fail on the test.  As
> libpfm4 can parse the generic events like cycles, let's use them.
> 
> Fixes: 40b74c30ffb9 ("perf test: Add expand cgroup event test")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

So would the test still fail when libpfm is not compiled in?

-Andi
