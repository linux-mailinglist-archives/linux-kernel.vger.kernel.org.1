Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2942A0BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgJ3Qv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:51:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:51243 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgJ3Qv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:51:26 -0400
IronPort-SDR: ShDNe3xdIuZALRB15BsRRKxU6HaYIGGNZmtl7kqewSonxR8eKiWa7/c2NECr8sYRfPcUhfB+vn
 hrwJZfhkFA4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="166049719"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="166049719"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 09:51:26 -0700
IronPort-SDR: wv0X7bNvWdLe5bJkg147nXN3mkAZoJFZCPDp1E4cPBxsuXWPVbfmBPj427HfUjBsuFvjn/Re4/
 lHerylMRUBIw==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="527169387"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 09:51:25 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kYXdb-002QZ6-RP; Fri, 30 Oct 2020 18:52:27 +0200
Date:   Fri, 30 Oct 2020 18:52:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     john.p.donnelly@oracle.com
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com
Subject: Re: [PATCH 4.14 v2 ] platform/x86: Corrects warning: missing braces
 around initializer
Message-ID: <20201030165227.GR4077@smile.fi.intel.com>
References: <20201030155501.7491-1-john.p.donnelly@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030155501.7491-1-john.p.donnelly@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 08:55:01AM -0700, john.p.donnelly@oracle.com wrote:
> From: John Donnelly <john.p.donnelly@oracle.com>
> 
> The assignment statement of a local variable "struct tp_nvram_state s[2] = {0};
> is not valid for all versions of compilers.

I don't get the subject. IS it backport of existing change to v4.14, or you are
trying to fix v4.14? If the latter is the case, it's not correct order. Try
latest vanilla first (v5.10-rc1 as of today) and if there is still an issue,
submit a patch.

> Fixes: 515ded02bc4b ("platform/x86: thinkpad_acpi: initialize tp_nvram_state variable")
> 
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>

Should not be blank line in between.

-- 
With Best Regards,
Andy Shevchenko


