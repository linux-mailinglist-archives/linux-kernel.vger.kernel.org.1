Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EFF2A13AD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 06:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgJaFff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 01:35:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:49550 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgJaFff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 01:35:35 -0400
IronPort-SDR: eVA3ugYyzbc3a5u+4lLEGVEyBNG+eBOcwVrRkztEXWrf+vtGD3P1u+OPoPiVwpDI8MXzyovele
 S81hWS4vFbig==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="155682602"
X-IronPort-AV: E=Sophos;i="5.77,436,1596524400"; 
   d="scan'208";a="155682602"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 22:35:35 -0700
IronPort-SDR: U5bRWSPpt7PazgIvMbxn8rpwvlIK2ii/K5o5TQti6RRGiXVEfcsJZvA0r7Qnv//7RhpdH0qanK
 Y0tJc3gaIC6g==
X-IronPort-AV: E=Sophos;i="5.77,436,1596524400"; 
   d="scan'208";a="362054785"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.254.214.42]) ([10.254.214.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 22:35:32 -0700
Subject: Re: [PATCH 0/3] Fix kernfs node reference count leak issues
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "willemb@google.com" <willemb@google.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>
References: <1604084530-31048-1-git-send-email-xiaochen.shen@intel.com>
 <79ccbc0b-32b4-2d02-2790-62350c917d67@intel.com>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
Message-ID: <c2708b32-e7f5-dae9-63d5-a35c97f25ea7@intel.com>
Date:   Sat, 31 Oct 2020 13:35:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <79ccbc0b-32b4-2d02-2790-62350c917d67@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

Thank you for correcting this!

The subject of this "cover letter" should be:
x86/resctrl: Fix kernfs node reference count leak issues

On 10/31/2020 5:18, Reinette Chatre wrote:
> Apologies, the Subject intended to have a "x86/resctrl:" prefix.
>
> On 10/30/2020 12:02 PM, Xiaochen Shen wrote:
>> Fix several kernfs node reference count leak issues:
>> (1) Remove superfluous kernfs_get() calls to prevent refcount leak
>> (2) Add necessary kernfs_put() calls to prevent refcount leak
>> (3) Follow-up cleanup for the change in previous patch.
>>
>> Xiaochen Shen (3):
>>     x86/resctrl: Remove superfluous kernfs_get() calls to prevent refcount
>>       leak
>>     x86/resctrl: Add necessary kernfs_put() calls to prevent refcount leak
>>     x86/resctrl: Clean up unused function parameter in rmdir path
>>
>>    arch/x86/kernel/cpu/resctrl/rdtgroup.c | 82 ++++++++++++++--------------------
>>    1 file changed, 33 insertions(+), 49 deletions(-)
>>

-- 
Best regards,
Xiaochen

