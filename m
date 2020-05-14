Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A521D351A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 17:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgENP3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 11:29:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:39332 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgENP3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:29:51 -0400
IronPort-SDR: b4iUlTtT6bDNbXGeyk8NK755cOZmaW9Z7k6o26Yi9S2eTtEYSoOj96Du/EC3xt05z09Q1z9Q04
 pMwBHWwFQ9wQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 08:29:50 -0700
IronPort-SDR: 3uiV/wEn+3vMZXN2iNc6MZ2p2ixmNfK1JgzkPylJxfDEbijZBkkO+AP4Xx8YEprXLayci0Hn5w
 MMzixJsO0oPQ==
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="280892639"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.66.120]) ([10.254.66.120])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 08:29:48 -0700
Subject: Re: [PATCH v2 00/10] x86/resctrl: Misc cleanup
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20200430170400.21501-1-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <893fb221-1ec9-7fc0-c25d-299c0222c52a@intel.com>
Date:   Thu, 14 May 2020 08:29:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200430170400.21501-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/30/2020 10:03 AM, James Morse wrote:
> Hello!
> 
> These are the miscellaneous cleanup patches that floated to the top of
> the MPAM tree.
> 
> The only interesting thing are the patches to make the AMD/Intel
> differences something resctrl understands, instead of just 'happening'
> because of the different function pointers.
> This will become more important once MPAM support is added. parse_bw()
> and friends are what enforces resctrl's ABI resctrl. Allowing an
> architecture/platform to provide a subtly different function here would
> be bad for user-space.
> 
> MPAM would set arch_has_sparse_bitmaps, but not arch_needs_linear.
> 
> Since [v1], I've picked up all the review feedback and collected the
> tags.
> 
> Nothing in this series should change any behaviour.
> This series is based on v5.7-rc3.

Please note that there are currently some resctrl changes in branch
x86/cache of the tip repo that are queued for inclusion into v5.8 that
have a few conflicts with this series. When you resubmit it may be
helpful if this series is based on that instead.

Reinette




