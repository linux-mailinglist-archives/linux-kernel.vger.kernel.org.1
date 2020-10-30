Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A712A0C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgJ3RlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:41:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:4222 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgJ3RlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:41:24 -0400
IronPort-SDR: 8GxfsxPCptwncNyAQlJIyjLW/LrtZY+pDZvAhG8bYnapIafCQzDuCeUd7TVR/sm7o3cZAq6rb0
 DYym9Lmn2m1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="168772037"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="168772037"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 10:41:24 -0700
IronPort-SDR: b0Be4jzYegO/3UdojYyXUzVC1mCg86JQfLYNogtyFuZB8dxAUuctMGpHI1SUv/wHEbchSzqDv1
 dNUceV9qqFtQ==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537141281"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 10:41:23 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kYYPx-002R9t-WC; Fri, 30 Oct 2020 19:42:25 +0200
Date:   Fri, 30 Oct 2020 19:42:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     John Donnelly <john.p.donnelly@oracle.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com
Subject: Re: [PATCH 4.14 v2 ] platform/x86: Corrects warning: missing braces
 around initializer
Message-ID: <20201030174225.GS4077@smile.fi.intel.com>
References: <20201030155501.7491-1-john.p.donnelly@oracle.com>
 <20201030165227.GR4077@smile.fi.intel.com>
 <105E5DC2-1B23-40BF-95A1-1B8443575AF6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105E5DC2-1B23-40BF-95A1-1B8443575AF6@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 12:18:44PM -0500, John Donnelly wrote:
> > On Oct 30, 2020, at 11:52 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > On Fri, Oct 30, 2020 at 08:55:01AM -0700, john.p.donnelly@oracle.com wrote:
> >> From: John Donnelly <john.p.donnelly@oracle.com>
> >> 
> >> The assignment statement of a local variable "struct tp_nvram_state s[2] = {0};
> >> is not valid for all versions of compilers.
> > 
> > I don't get the subject. IS it backport of existing change to v4.14, or you are
> > trying to fix v4.14? If the latter is the case, it's not correct order. Try
> > latest vanilla first (v5.10-rc1 as of today) and if there is still an issue,
> > submit a patch.
> 
> Hi,
> 
>  It is only intended for 4.14. Why would you back port  a commit  to a stable tree that emits warnings ?

So, if this is for stable, what is the current commit in the kernel of this?

> >> Fixes: 515ded02bc4b ("platform/x86: thinkpad_acpi: initialize tp_nvram_state variable")
> >> 
> >> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> > 
> > Should not be blank line in between.

-- 
With Best Regards,
Andy Shevchenko


