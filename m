Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A102E9E45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 20:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbhADTnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 14:43:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:49852 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbhADTnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:43:06 -0500
IronPort-SDR: ow2+1eStsliJp/cR9vR6+P6js0/PlYV4hLt1l5E6OrgSvXnKOJeVkS35QRAnv+v99ZSzglUHhK
 LO0mGbAH05Yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156786006"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="156786006"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 11:42:26 -0800
IronPort-SDR: 8wSDOwWaVDcmpzynYVszdh249uHJ0FOW84ywLY0eWO94id7za+Ib2YKQ8NWWD1nl0W72PPCyrZ
 M7sTU7T6hv2g==
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="569458351"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 11:42:26 -0800
Date:   Mon, 4 Jan 2021 19:42:25 +0000
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
Message-ID: <X/NvodZcfmcgn/44@otcwcpicx6.sc.intel.com>
References: <20201124205245.4164633-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124205245.4164633-1-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dear X86 Maintainers,

On Tue, Nov 24, 2020 at 08:52:41PM +0000, Fenghua Yu wrote:
> A bus lock [1] is acquired through either split locked access to
> writeback (WB) memory or any locked access to non-WB memory. This is
> typically >1000 cycles slower than an atomic operation within
> a cache line. It also disrupts performance on other cores.

This is a friendly reminder. Any comment on this series?

Thanks.

-Fenghua
