Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8092DA6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 04:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLODGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 22:06:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:59812 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgLODGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 22:06:24 -0500
IronPort-SDR: 8tuSL5WBaqMMDsB6QK95dBTDqU5EmSUn37lTrv1kelGjyp7zZPwGKLJ4pEIPl93VfFLhZseDYq
 deYF98z2Z9tA==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="154624703"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="154624703"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 19:04:37 -0800
IronPort-SDR: OBx9BH69m3buB8B65e+f+nLR2l0HRicswvCjMZ8hHOAm4x9V/TmNgfJr5uiC3fGsUGk32FP4FO
 767boOWhdxlQ==
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="450169499"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 19:04:37 -0800
Date:   Mon, 14 Dec 2020 19:04:30 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, mingo@redhat.com, peterz@infradead.org,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 0/5] perf stat: Introduce --iiostat mode to provide I/O
 performance metrics
Message-ID: <20201215030430.GA1538637@tassilo.jf.intel.com>
References: <20201210090340.14358-1-alexander.antonov@linux.intel.com>
 <20201214132828.GD238399@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214132828.GD238399@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> My first thought was: Why not have a 'perf iiostat' subcommand?

Same would apply to a lot of options in perf stat.

I guess you could add some aliases to "perf" that give shortcuts
for common perf stat command lines.

-Andi
