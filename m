Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104EC3039FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbhAZKQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:16:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:17108 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731886AbhAYT2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:28:31 -0500
IronPort-SDR: E0S/L088wpaQDHr8xejtgOXJ2on+/h57dFOmCmW3RlYhR/4es6Eju/LvDA6wxSPANeflXnyNlo
 IyuA4Rq2ZFwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="166887774"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="166887774"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:27:22 -0800
IronPort-SDR: gt5bCqkFvpOJIyD5upjIDvSjKDgoU6b0fhMMJY4ahjnOUHDeVC7QaUbBaSDERLo4yx8yS8ExMu
 BtCEWiae8IGg==
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="361646283"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:27:21 -0800
Date:   Mon, 25 Jan 2021 19:27:14 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 0/4] x86/bus_lock: Enable bus lock detection
Message-ID: <YA8bkmYjShKwmyXx@otcwcpicx3.sc.intel.com>
References: <20201124205245.4164633-1-fenghua.yu@intel.com>
 <X/NvodZcfmcgn/44@otcwcpicx6.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/NvodZcfmcgn/44@otcwcpicx6.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dear X86 Maintainers,

>On Mon, Jan 04, 2021 at 07:42:28PM +0000, Fenghua Yu wrote:
> 
> On Tue, Nov 24, 2020 at 08:52:41PM +0000, Fenghua Yu wrote:
> > A bus lock [1] is acquired through either split locked access to
> > writeback (WB) memory or any locked access to non-WB memory. This is
> > typically >1000 cycles slower than an atomic operation within
> > a cache line. It also disrupts performance on other cores.
 
Just a friendly reminder. Any comment on this series? There hasn't been
any comment since it was posted.

This series can be applied cleanly to v5.11-rc5 and pass all of our
tests. If you want me to repost this series, I can do that too.

Thanks!

-Fenghua
