Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9BA2A23A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 04:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgKBDwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 22:52:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:54948 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbgKBDwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 22:52:40 -0500
IronPort-SDR: I6tvaO1szkz/GXnNCmND6EnzE/ZfZ5HYflKFk7ETEy2vQ9l9xaRQ2htxxX2DMefJQMlPMLL6xe
 UcbMu4KoaqDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="253539030"
X-IronPort-AV: E=Sophos;i="5.77,443,1596524400"; 
   d="scan'208";a="253539030"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 19:52:39 -0800
IronPort-SDR: 7XYA97HlNl4tMaJ3/eXsZlzsLztgnXXxYypIuVBtjHh4owLf4H38/u5g55MQujnzTG5vk8GpqF
 nE9yq4yNsa5g==
X-IronPort-AV: E=Sophos;i="5.77,443,1596524400"; 
   d="scan'208";a="537860747"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 19:52:39 -0800
Date:   Sun, 1 Nov 2020 19:52:38 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: [PATCH v2 0/4] perf: Fix perf_event_attr::exclusive rotation
Message-ID: <20201102035238.GI466880@tassilo.jf.intel.com>
References: <20201029162719.519685265@infradead.org>
 <20201031234418.GE3380099@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031234418.GE3380099@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> hm, it's too late for me to check ;-) but should I be able to do
> this with exclusive event.. running both command at the same time:

Yes. The exclusive part only applies during a given context,
but the two commands are different contexts.

You would only see a difference when in the same context,
and you have multiple groups (or events) that could in theory schedule
in parallel

e.g. something like

perf stat -e '{cycles,cycles},{cycles,cycles}'  ...

The main motivation is actually that the "multiple groups" algorithm
in perf doesn't work all that great: it has quite a few cases where it
starves groups or makes the wrong decisions. That is because it is very
difficult (likely NP complete) problem and the kernel takes a lot
of short cuts to avoid spending too much time on it.

With exclusive it will be possible for a tool to generate "perfect groups"
in user space and assume the kernel schedules it dumbly, but at least
without any starvation.

-Andi
