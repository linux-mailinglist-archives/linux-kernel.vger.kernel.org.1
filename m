Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171262943EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 22:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409465AbgJTU3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 16:29:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:63437 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgJTU3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 16:29:15 -0400
IronPort-SDR: fEUDugv1nyYhPtYS6tusqzkj92W8+9ImKPJb1yhwCDUQE1S8jNenRLd9jIGd47SNgp1SXziBWF
 ivPCVYx9N6CA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="155058814"
X-IronPort-AV: E=Sophos;i="5.77,398,1596524400"; 
   d="scan'208";a="155058814"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 13:29:14 -0700
IronPort-SDR: 8UlM6QoB4Cha/TQLxBcu+GBUwJpDUcClXtoLykjmGNpdtIBzSvsS1eU2RYPL6M7vH76YujtI7q
 c+loA2epoNqg==
X-IronPort-AV: E=Sophos;i="5.77,398,1596524400"; 
   d="scan'208";a="392498035"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 13:29:14 -0700
Date:   Tue, 20 Oct 2020 13:29:13 -0700
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
Message-ID: <20201020202913.GN466880@tassilo.jf.intel.com>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <87e2050b-37e6-8ed8-e1e0-cfa074b030fa@linux.intel.com>
 <20201012160144.GA466880@tassilo.jf.intel.com>
 <42d5395a-71f5-63e1-f7c9-fd76e2b8bee4@linux.intel.com>
 <a1c21077-0383-aa29-cc79-a8921916c63f@linux.intel.com>
 <19dd0fa0-c236-6042-8ba6-48b4696e66bb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19dd0fa0-c236-6042-8ba6-48b4696e66bb@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > After brief evaluation it still doesn't look easy. The simplest thing
> > I could imagine is to probably combine file_path and file_offset at a
> > struct object on stack and then pass the object by the reference along
> > function calls. I expect it will roughly cause the same amount of changes
> > in the code and saves one argument (GP register). It is not that much
> > but still. However I don't see issues with passing even 6 args on stack.
> 
> Sorry - "passing 6 args to a function call"

Ah it wasn't about code efficiency, just maintainability. Function calls
with too many arguments are generally hard to maintain, and typically
at some point have to be refactored anyways because they tend to grow
even more over time.

But if it's too difficult, ok.

-Andi
