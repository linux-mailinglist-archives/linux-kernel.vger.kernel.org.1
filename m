Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE2B21A652
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 19:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgGIRvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 13:51:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:4045 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgGIRvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:51:47 -0400
IronPort-SDR: bxRGMU+AXvfevi/2P1PcYQ+XHz/ipOn7+82PgBKHvEu3UDmB+gAPOcP020tNOJ1ZJNAz9Xdixo
 9w94ytxB47Hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="136280781"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="136280781"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:51:46 -0700
IronPort-SDR: bqlNXW1kQoVTbPGVZv+XKMlEcLmwGYihMezZt7uXqgcadK2XgIoXFw1kVI2Xdf1vndK8sUSeRI
 ZTlWaX/KfT5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="484363876"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jul 2020 10:51:46 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 39165301B2A; Thu,  9 Jul 2020 10:51:46 -0700 (PDT)
Date:   Thu, 9 Jul 2020 10:51:46 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] perf auxtrace: Add optional log flags to the
 itrace 'd' option
Message-ID: <20200709175146.GB1126680@tassilo.jf.intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
 <20200709173628.5613-7-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709173628.5613-7-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	flags what kind of errors will or will not be reported.
> +
> +	If supported, The 'd' option may be followed by an architecture-specific
> +	number which flags what kind of debug messages will or will not be logged.

Would need documentation here.

Also in the include used by the command line help.

-Andi
