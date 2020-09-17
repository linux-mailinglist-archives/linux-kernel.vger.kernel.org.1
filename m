Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E051A26E7BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 23:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgIQV54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 17:57:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:10823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgIQV5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 17:57:55 -0400
IronPort-SDR: 7BvUbw1Q5MD3AHG/CuVA+PGslcS+XD+uenvJxjNu1a7S/KyHsKn/flJi6n5tGPY4IUS5Ft4w3q
 uxLmSl4KSUyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="139303756"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="139303756"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:57:53 -0700
IronPort-SDR: EIe/0hKr2y5FSp4fiWeAt7OLBMgASLNesRw5HmNTru7WWYSTBnKcjDUsCkEk87O7iL5sCwiBC7
 wnd0NOGkYhYg==
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="483922278"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:57:52 -0700
Date:   Thu, 17 Sep 2020 14:57:51 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] x86/mce: Avoid tail copy when machine check
 terminated a copy from user
Message-ID: <20200917215751.GB16591@agluck-desk2.amr.corp.intel.com>
References: <20200908175519.14223-1-tony.luck@intel.com>
 <20200908175519.14223-6-tony.luck@intel.com>
 <20200916105336.GF2643@zn.tnic>
 <20200916192659.GA30252@agluck-desk2.amr.corp.intel.com>
 <20200917170406.GN31960@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917170406.GN31960@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 07:04:06PM +0200, Borislav Petkov wrote:
> So actually, I'm thinking:
> 
> .LMCE_during_user_access:
> 	mov $-ENODEV, %eax
> 	ASM_CLAC
> 	ret
> 
> I have no clue which error code we should put there but it should be an
> error code which tells you not to retry and to back off immediately.

That does look a lot easier to understand *at this point* in the code.

But the existing iterator code is not expecting an error code.  Just a
count of bytes not copied.

So doing this would mean some surgery on the maze of giant #defines that
is lib/iov_iter.c

-Tony
