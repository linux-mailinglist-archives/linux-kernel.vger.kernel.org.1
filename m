Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45772B10AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgKLVyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:54:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:3358 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgKLVyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:54:44 -0500
IronPort-SDR: ZhNaBVOnEN+OzWUQiYMOSC0XPE9znLjb0fsscKvtHNyW4HRFoK/RUGDLwkuMNtCDJhiEnsaiCD
 hgKKSFuRsjVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="149657722"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="149657722"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 13:54:43 -0800
IronPort-SDR: bXhT6qBaEZfDW1oQovu5ykP34GJQAMF9D7Aesc95KCgiaoffnAH0e/cboIheMZfDlrnyQnY9IT
 Yfr2+KLuVDQg==
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="328647158"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 13:54:43 -0800
Date:   Thu, 12 Nov 2020 13:54:42 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH][RFC] x86/microcode/intel: check cpu stepping and
 processor flag before saving microcode
Message-ID: <20201112215442.GA40035@otc-nc-03>
References: <20201110135247.422-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110135247.422-1-yu.c.chen@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChenYu

I think you can drop the RFC tag.

I suppose you can add Cc stable as well. Boris should return next week to
take a look.


On Tue, Nov 10, 2020 at 09:52:47PM +0800, Chen Yu wrote:
> Currently scan_microcode() leverages microcode_matches() to check if the
> microcode matches the CPU by comparing the family and model. However before
> saving the microcode in scan_microcode(), the processor stepping and flag
> of the microcode signature should also be considered in order to avoid
> incompatible update and caused the failure of microcode update.
> 
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208535
> Fixes: 06b8534cb728 ("x86/microcode: Rework microcode loading")
> Suggested-by: "Raj, Ashok" <ashok.raj@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Len Brown <len.brown@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: "Raj, Ashok" <ashok.raj@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> --

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

Cheers,
Ashok
