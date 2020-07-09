Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C060E21A651
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 19:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgGIRvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 13:51:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:59069 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgGIRvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:51:00 -0400
IronPort-SDR: I99NEnhRfh65Jl+myeq0YMNq4oUsdg5GGrXSg2aSZviAe0BFS77R3NHbvNp3+lPhu5WT9GdmRd
 IdNUnaySSfhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="135526757"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="135526757"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:50:46 -0700
IronPort-SDR: Q1cbkn/oy6GDcFfbk9aYyq3XvQKjy5SttoHDUZ/DIbBjDWN+UDS6Hc56JoHiJvsQdRQvU51lGW
 bcGMRVRky6wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="484363701"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jul 2020 10:50:46 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1C992301B2A; Thu,  9 Jul 2020 10:50:46 -0700 (PDT)
Date:   Thu, 9 Jul 2020 10:50:46 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] perf intel-pt: Use itrace error flags to suppress
 some errors
Message-ID: <20200709175046.GA1126680@tassilo.jf.intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
 <20200709173628.5613-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709173628.5613-6-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 08:36:22PM +0300, Adrian Hunter wrote:
> The itrace "e" option may be followed by a number which has the
> following effect for Intel PT:
> 	1	Suppress overflow events
> 	2	Suppress trace data lost events
> The values may be combined by bitwise OR'ing them.
> 
> Suppressing those errors can be useful for testing and debugging
> because they are not due to decoding.

I suspect it will be useful to more than just decoding and debugging.

But the number is not a nice user interface.

How about e[....] 

like e[ol] 

Also it's a bit unusual that this disables instead of enables, but ok.

-Andi
