Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0E41B2F35
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 20:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgDUSgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 14:36:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:46292 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDUSgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:36:15 -0400
IronPort-SDR: scvtaxEkEngtdjnBdaN6kHmNvCqceikiJP4GD7vEYgf4AMdvtrdyz429rhtp46ep+h22R2fd3r
 I8H42nMWZJxQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 11:36:15 -0700
IronPort-SDR: htjAKHyunl6st7EPXfAJmsqzIZ/0M/Kh4zbkR26LdWAaQerXxhJ8Cef19+An/ZUDAks4TOdXPc
 7DtBkWX+G4lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="273617738"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2020 11:36:15 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 325D63019B6; Tue, 21 Apr 2020 11:36:15 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:36:15 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 3/3] perf stat: Add --metrics-file option
Message-ID: <20200421183615.GD608746@tassilo.jf.intel.com>
References: <20200421181337.988681-1-jolsa@kernel.org>
 <20200421181337.988681-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421181337.988681-4-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +--metrics-file file::
> +Read metrics definitions from file in addition to compiled in metrics.
> +

You would need to define the syntax and format. Perhaps in a separate
man page.

Also there are some asserts that can be triggered by expressions. I think
you should fix those too and convert them to errors.

-Andi
