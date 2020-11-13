Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3EC2B13D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKMBaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:30:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:51884 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgKMBaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:30:39 -0500
IronPort-SDR: ihf3dvVSbI1AI7Ue4Z4I4ArCKH3PAOso3lEXbapnapGc5wDKuyi79YXMEld4x8Llqau2dN+Mdr
 XuDdGv8vtvCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="169627198"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="169627198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 17:30:38 -0800
IronPort-SDR: AJf5rkZSeMBbMQfn3OsMTor6bEcGswjIml/HoDjxLgcBK5LSEwGq3SNYN8saGLJNI4Rz5TSTzG
 YLHa7WKr7SiA==
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="542477697"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 17:30:35 -0800
Date:   Fri, 13 Nov 2020 09:33:06 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH][RFC] x86/microcode/intel: check cpu stepping and
 processor flag before saving microcode
Message-ID: <20201113013306.GA13261@chenyu-office.sh.intel.com>
References: <20201110135247.422-1-yu.c.chen@intel.com>
 <20201112215442.GA40035@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112215442.GA40035@otc-nc-03>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashok,
On Thu, Nov 12, 2020 at 01:54:42PM -0800, Raj, Ashok wrote:
> Hi ChenYu
> 
> I think you can drop the RFC tag.
> 
> I suppose you can add Cc stable as well. Boris should return next week to
> take a look.
>
Ok, I'll do and send another version out.
> 
> On Tue, Nov 10, 2020 at 09:52:47PM +0800, Chen Yu wrote:
> > Currently scan_microcode() leverages microcode_matches() to check if the
> > microcode matches the CPU by comparing the family and model. However before
> > saving the microcode in scan_microcode(), the processor stepping and flag
> > of the microcode signature should also be considered in order to avoid
> > incompatible update and caused the failure of microcode update.
> > 
> > 
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208535
> > Fixes: 06b8534cb728 ("x86/microcode: Rework microcode loading")
> > Suggested-by: "Raj, Ashok" <ashok.raj@intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: "Raj, Ashok" <ashok.raj@intel.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > --
> 
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> 
Thanks!

Best,
Chenyu
> Cheers,
> Ashok
