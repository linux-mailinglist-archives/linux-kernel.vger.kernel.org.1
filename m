Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B322BBBB0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 02:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgKUBzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 20:55:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:29458 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgKUBzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 20:55:12 -0500
IronPort-SDR: aCMKIaS9hFtYuylGtNBm9SjZYmiHycLDr5PfLth6RHbJPRHQ/gpzEP53zb0UWMfQG9LU8ah8to
 Us/y0IfVGQdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="189675474"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="189675474"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 17:55:11 -0800
IronPort-SDR: bgJfTOWxlCgV4CIvdgq7z8DIzdPLtB12sb0MmAahztHzRolqb2ydz8KEVjAJwwy8EXJILEo+yw
 x9kkt51+5HOw==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="369367575"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.254.215.103]) ([10.254.215.103])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 17:55:08 -0800
Subject: Re: [PATCH 1/3] x86/resctrl: Remove superfluous kernfs_get() calls to
 prevent refcount leak
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, willemb@google.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        Xiaochen Shen <xiaochen.shen@intel.com>
References: <1604084530-31048-1-git-send-email-xiaochen.shen>
 <1604084638-31197-1-git-send-email-xiaochen.shen@intel.com>
 <20201120161351.GC712@zn.tnic>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
Message-ID: <cf46b633-79b8-4124-450f-09f4e23189d9@intel.com>
Date:   Sat, 21 Nov 2020 09:55:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201120161351.GC712@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Thank you very much for code review. More comments are inline.

But I am sorry that I sent this thread by mistake (--in-reply-to a wrong
Message-ID). Please ignore this thread and help review from following
threads:

The link of correct version of this patch [PATCH 1/3]:
https://lkml.kernel.org/r/1604085053-31639-1-git-send-email-xiaochen.shen@intel.com

The link of the patch series with 3 patches:
https://lkml.kernel.org/r/1604084530-31048-1-git-send-email-xiaochen.shen@intel.com

I am so sorry for the inconvenience.


On 11/21/2020 0:13, Borislav Petkov wrote:
> On Sat, Oct 31, 2020 at 03:03:58AM +0800, Xiaochen Shen wrote:
>> Willem reported growing of kernfs_node_cache entries in slabtop when
>> repeatedly creating and removing resctrl subdirectories as well as when
>> repeatedly mounting and unmounting resctrl filesystem.
>>
>> On resource group (control as well as monitoring) creation via a mkdir
>> an extra kernfs_node reference is obtained to ensure that the rdtgroup
>> structure remains accessible for the rdtgroup_kn_unlock() calls where it
>> is removed on deletion. The kernfs_node reference count is dropped by
>> kernfs_put() in rdtgroup_kn_unlock().
>>
>> With the above explaining the need for one kernfs_get()/kernfs_put()
>> pair in resctrl there are more places where a kernfs_node reference is
>> obtained without a corresponding release. The excessive amount of
>> reference count on kernfs nodes will never be dropped to 0 and the
>> kernfs nodes will never be freed in the call paths of rmdir and umount.
>> It leads to reference count leak and kernfs_node_cache memory leak.
>>
>> Remove the superfluous kernfs_get() calls and expand the existing
>> comments surrounding the remaining kernfs_get()/kernfs_put() pair that
>> remains in use.
>>
>> Superfluous kernfs_get() calls are removed from two areas:
>>
>>    (1) In call paths of mount and mkdir, when kernfs nodes for "info",
>>    "mon_groups" and "mon_data" directories and sub-directories are
>>    created, the reference count of newly created kernfs node is set to 1.
>>    But after kernfs_create_dir() returns, superfluous kernfs_get() are
>>    called to take an additional reference.
>>
>>    (2) kernfs_get() calls in rmdir call paths.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 17eafd076291 ("x86/intel_rdt: Split resource group removal in two")
>> Fixes: 4af4a88e0c92 ("x86/intel_rdt/cqm: Add mount,umount support")
>> Fixes: f3cbeacaa06e ("x86/intel_rdt/cqm: Add rmdir support")
>> Fixes: d89b7379015f ("x86/intel_rdt/cqm: Add mon_data")
>> Fixes: c7d9aac61311 ("x86/intel_rdt/cqm: Add mkdir support for RDT monitoring")
>> Fixes: 5dc1d5c6bac2 ("x86/intel_rdt: Simplify info and base file lists")
>> Fixes: 60cf5e101fd4 ("x86/intel_rdt: Add mkdir to resctrl file system")
>> Fixes: 4e978d06dedb ("x86/intel_rdt: Add "info" files to resctrl file system")
> Are those 8(!) Fixes tags supposed to list *all* commits which add those
> wrong kernfs_get() calls?

Yes. Thank you.

-- 
Best regards,
Xiaochen

