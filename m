Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473AF1E623E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 15:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbgE1N3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 09:29:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:51113 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390268AbgE1N31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:29:27 -0400
IronPort-SDR: UPqMpgb3Vzkft9vUwQBNQv7QqQXab5qwWPC98lOChVx96dZRE9CP27EWXMvK6ZwrrqDppX6XLt
 Avgm3j4zIFIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 06:29:08 -0700
IronPort-SDR: MozizEa8xAPoZoFX9CZ+NW/XPcsd+925xotRcz12t/DE4MVoSwuXmtTFz2rCXO/PPJ9l2gb4qQ
 vrZvQpRZrMZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="376367141"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2020 06:29:08 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 23E06301C5F; Thu, 28 May 2020 06:29:08 -0700 (PDT)
Date:   Thu, 28 May 2020 06:29:08 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, David.Laight@aculab.com
Subject: Re: [PATCH V2 2/3] perf/x86/intel/uncore: Record the size of mapped
 area
Message-ID: <20200528132908.GG611145@tassilo.jf.intel.com>
References: <1590671727-99311-1-git-send-email-kan.liang@linux.intel.com>
 <1590671727-99311-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590671727-99311-2-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 06:15:26AM -0700, kan.liang@linux.intel.com wrote:
> -	box->io_addr = ioremap(addr, SNB_UNCORE_PCI_IMC_MAP_SIZE);
> +	if (!type->mmio_map_size) {
> +		pr_warn("perf uncore: Cannot ioremap for %s. Size of map area is 0.\n",
> +			type->name);
> +		return;
> +	}

Is that likely that the size is 0?

In any case you have to test the return value of ioremap. So I would rather
test the address for 0 than the size.

Similar in other code below.

I thought you were going to add a range check based on the size to the
actual access. Did I miss it in the patch?

-Andi
