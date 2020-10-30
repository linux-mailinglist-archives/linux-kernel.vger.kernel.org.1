Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA54F2A100E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 22:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgJ3VSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 17:18:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:43848 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgJ3VSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 17:18:24 -0400
IronPort-SDR: g9UNoPbOUyipBQQMHaNvd8vF39IXkL4YPoNb0O0ykwX2B0UDGyeGmpmGhg93CtO4vaWiaDdjfs
 sjP7hMz9qzAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="156441123"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="156441123"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 14:18:18 -0700
IronPort-SDR: x1CMf7tda0CkhegdditzFojF91wvC2FBMxdyEDmtdBF0cJVR+gTa+ewQy/QhXol8SvwpeoMFhP
 aQmQRwyv4kfw==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="526009529"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.87.224]) ([10.212.87.224])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 14:18:18 -0700
Subject: Re: [PATCH 0/3] Fix kernfs node reference count leak issues
To:     Xiaochen Shen <xiaochen.shen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tony.luck@intel.com,
        fenghua.yu@intel.com, willemb@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com
References: <1604084530-31048-1-git-send-email-xiaochen.shen@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <79ccbc0b-32b4-2d02-2790-62350c917d67@intel.com>
Date:   Fri, 30 Oct 2020 14:18:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604084530-31048-1-git-send-email-xiaochen.shen@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, the Subject intended to have a "x86/resctrl:" prefix.

On 10/30/2020 12:02 PM, Xiaochen Shen wrote:
> Fix several kernfs node reference count leak issues:
> (1) Remove superfluous kernfs_get() calls to prevent refcount leak
> (2) Add necessary kernfs_put() calls to prevent refcount leak
> (3) Follow-up cleanup for the change in previous patch.
> 
> Xiaochen Shen (3):
>    x86/resctrl: Remove superfluous kernfs_get() calls to prevent refcount
>      leak
>    x86/resctrl: Add necessary kernfs_put() calls to prevent refcount leak
>    x86/resctrl: Clean up unused function parameter in rmdir path
> 
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 82 ++++++++++++++--------------------
>   1 file changed, 33 insertions(+), 49 deletions(-)
> 
