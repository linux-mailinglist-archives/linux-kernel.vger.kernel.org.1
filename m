Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE2D1C8C79
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 15:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEGNgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 09:36:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:44669 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgEGNgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:36:08 -0400
IronPort-SDR: L5CnpK4QsITrNNZJOnHTkQKTuE5ZUQdG1D0+q/36HjR+1nWJyfDd5ba3PSRSG+ahx1crdwMeOc
 JwIzEcljPSUQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 06:36:07 -0700
IronPort-SDR: 4D9yhjnF2nW6Y3BL3kWuHnrvdfW8DzzsX/kZnk451XCMyQ1n9KmGJB5KoAScE6dr3xb8vfufHw
 UENGE2wDJ0Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="305121240"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 07 May 2020 06:36:05 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jWgh6-005DkF-Vr; Thu, 07 May 2020 16:36:08 +0300
Date:   Thu, 7 May 2020 16:36:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        peterz@infradead.org, gpiccoli@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] kernel.h: remove duplicate headers
Message-ID: <20200507133608.GV185537@smile.fi.intel.com>
References: <20200507131608.63373-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507131608.63373-1-chenzhou10@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 09:16:08PM +0800, Chen Zhou wrote:
> Remove duplicate headers which are included twice.

Thanks, this is included in my patch set to split out some parts of this header
to new headers.

(It basically removes all occurrences of div64.h)

-- 
With Best Regards,
Andy Shevchenko


