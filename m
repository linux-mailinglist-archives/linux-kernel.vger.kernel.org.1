Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE812C331E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbgKXVhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:37:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:45944 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731491AbgKXVhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:37:39 -0500
IronPort-SDR: XbUG9s8DDjWI/JpQVd6x9QEqMFxwT7weet3dgxVJe+L3VKtOmLmjETry0Fy5ydYElltVAyBQ29
 2Dt+/fmwsJWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="256728752"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="256728752"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 13:37:39 -0800
IronPort-SDR: wP8XKtPDD5ZuKLgcgDmE1bgLNH5hSOD+FkANNhDBVgki6uzUaccMUkmjgl3TBCF8flJwhr2GFf
 0gOH0Bv/+DUQ==
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="332704026"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.252.136.150]) ([10.252.136.150])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 13:37:38 -0800
Subject: Re: [PATCH v2 0/3] x86/intel_rdt: task_work vs task_struct
 rmid/closid write race
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, James Morse <James.Morse@arm.com>
References: <20201123022433.17905-1-valentin.schneider@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <87be8915-21b0-5214-9742-ccc7515c298b@intel.com>
Date:   Tue, 24 Nov 2020 13:37:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123022433.17905-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 11/22/2020 6:24 PM, Valentin Schneider wrote:
> This is a small cleanup + a fix for a race I stumbled upon while staring at
> resctrl stuff.
> 
> Briefly tested on a Xeon Gold 5120 (m2.xlarge.x86 on Equinix) by bouncing
> a few tasks around control groups.
> 

...

Thank you very much for taking this on. Unfortunately this race is one 
of a few issues with the way in which tasks moving to a new resource 
group is handled.

Other issues are:

1.
Until the queued work is run, the moved task runs with old (and even
invalid in the case when its original resource group has been removed)
closid and rmid.

2.
Work to update the PQR_ASSOC register is queued every time the user 
writes a task id to the "tasks" file, even if the task already belongs 
to the resource group and in addition to any other pending work for that 
task. This could result in multiple pending work items associated with a 
single task even if they are all identical and even though only a single 
update with most recent values is needed. This could result in 
significant system resource waste, especially on tasks sleeping for a 
long time.

Fenghua solved these issues by replacing the callback with a synchronous 
update, similar to how tasks are currently moved when a resource group 
is deleted. We plan to submit this work next week.

This new solution will make patch 1 and 2 of this series unnecessary. As 
I understand it patch 3 would still be a welcome addition but would 
require changes. As you prefer you could either submit patch 3 on its 
own for the code as it is now and we will rework the task related 
changes on top of that, or you could wait for the task related changes 
to land first?

> 
> Valentin Schneider (3):
>    x86/intel_rdt: Check monitor group vs control group membership earlier
>    x86/intel_rdt: Plug task_work vs task_struct {rmid,closid} update race
>    x86/intel_rdt: Apply READ_ONCE/WRITE_ONCE to task_struct .rmid &
>      .closid
> 

Thank you very much

Reinette

