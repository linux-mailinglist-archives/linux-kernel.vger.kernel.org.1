Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B402273133
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgIURwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:52:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:57221 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgIURwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:52:37 -0400
IronPort-SDR: Xal236EDjLkYh/NDXNV9jxLyX6lfxSZ9OJHljSQgnSQVczTvYs9Et5ktye7gwu00nM5PJ4TNKN
 QV3ZV9WeWc7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="159738645"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="159738645"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 10:52:18 -0700
IronPort-SDR: IQe7WI3svWsh72nnG1TsE/uGiF8he4oyZ3e3KvluVPioQwQZe4jbkClr6T4PkngPjWGjG86UQG
 c3VXnvSSLyEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="510820834"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2020 10:52:18 -0700
Received: from [10.249.227.226] (abudanko-mobl.ccr.corp.intel.com [10.249.227.226])
        by linux.intel.com (Postfix) with ESMTP id 1A0E858058B;
        Mon, 21 Sep 2020 10:52:15 -0700 (PDT)
Subject: Re: [PATCH 3/3] platform/x86: Intel PMT Crashlog capability driver
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, dvhart@infradead.org,
        Andy Shevchenko <andy@infradead.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-4-david.e.box@linux.intel.com>
 <0ec64bdc-66fd-4be1-03cf-561a7c42de68@linux.intel.com>
 <CAKgT0UdiXLhok1WOq9RoZKKi+f43xUoSBwX2LTYMpUUTU3HRwA@mail.gmail.com>
 <69a7e595-1b5c-bfb3-f3e6-16cf5fcc9999@linux.intel.com>
 <CAKgT0UfkV-Sofk9BO_KqnB83VEMcAqN_9p3BeQQp5Ew4oOCwRw@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e64c75aa-0cb5-2851-12b8-c8992e7f7b8e@linux.intel.com>
Date:   Mon, 21 Sep 2020 20:52:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfkV-Sofk9BO_KqnB83VEMcAqN_9p3BeQQp5Ew4oOCwRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21.09.2020 20:33, Alexander Duyck wrote:
> On Mon, Sep 21, 2020 at 9:07 AM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
>>
>> On 21.09.2020 16:36, Alexander Duyck wrote:
>>> On Sat, Sep 19, 2020 at 1:01 AM Alexey Budankov
>>> <alexey.budankov@linux.intel.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> Thanks for the patches.
>>>>
>>>> On 11.09.2020 22:45, David E. Box wrote:
>>>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>
>>>>> Add support for the Intel Platform Monitoring Technology crashlog
>>>>> interface.  This interface provides a few sysfs values to allow for
>>>>> controlling the crashlog telemetry interface as well as a character driver
>>>>> to allow for mapping the crashlog memory region so that it can be accessed
>>>>> after a crashlog has been recorded.
>>>>>
>>>>> This driver is meant to only support the server version of the crashlog
>>>>> which is identified as crash_type 1 with a version of zero. Currently no
>>>>> other types are supported.
>>>>>
>>>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>>>>> ---
>>>>>  .../ABI/testing/sysfs-class-pmt_crashlog      |  66 ++
>>>>>  drivers/platform/x86/Kconfig                  |  10 +
>>>>>  drivers/platform/x86/Makefile                 |   1 +
>>>>>  drivers/platform/x86/intel_pmt_crashlog.c     | 588 ++++++++++++++++++
>>>>>  4 files changed, 665 insertions(+)
>>>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_crashlog
>>>>>  create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c
>>>>
>>>> <SNIP>
>>>>
>>>>> +
>>>>> +/*
>>>>> + * devfs
>>>>> + */
>>>>> +static int pmt_crashlog_open(struct inode *inode, struct file *filp)
>>>>> +{
>>>>> +     struct crashlog_entry *entry;
>>>>> +     struct pci_driver *pci_drv;
>>>>> +     struct pmt_crashlog_priv *priv;
>>>>> +
>>>>> +     if (!capable(CAP_SYS_ADMIN))
>>>>> +             return -EPERM;
>>>>
>>>> Will not this above still block access to /dev/crashlogX for admin_group users
>>>> in case root configured access e.g. similar to this:
>>>>
>>>> ls -alh /dev/
>>>> crw-rw----.  1 root admin_group      1,   9 Sep 15 18:28 crashlogX
>>>>
>>>> If yes then that capable() check is probably superfluous and
>>>> should be avoided in order not to block access to PMT data.
>>>>
>>>> Could you please clarify or comment?
>>>>
>>>> Thanks,
>>>> Alexei
>>>
>>> Actually this should probably be updated to "if (!perfmon_capable())"
>>> instead. The telemetry driver code originally had the CAP_SYS_ADMIN
>>> check and it probably makes more sense to limit this user-wise to the
>>> same users who have access to performon.
>>
>> Indeed, it is currently perfmon_capable() for performance part but it is unclear
>> if it should be the same for crashlog since it's more like a debugging thing.
>> It appears it all depends on usage models implemented in a user space tools e.g. Perf.
>>
>> However there is an important use case that is not covered
>> neither by perfmon_capable() nor by capable(CAP_SYS_ADMIN).
>>
>> It is access and usage of PMT features in cluster or cloud environments by
>> unprivileged users that don't have root credentials. The users however can run
>> software tools (Perf, VTune etc.) once installed and configured by root.
>>
>> Even though Perf tool can be configured to use use CAP_PERFMON [1] the tool binary
>> should still reside on a file system supporting xattr to convey capabilities
>> into processes implementing monitoring.
>>
>> Unfortunately NFSv3 which is quite popular to be used for storing and sharing
>> software tooling in large production systems doesn't support capabilities yet.
>>
>> Thus, capabilities approach still has limitation in HPC clusters and cloud environments
>> and for PMT support this limitation has a chance to be lifted if
>> suitable access control mechanism would be designed from the very beggining.
>>
>> Actually I tried to change group ownership of /dev and /sys directories and files, being root,
>> and it appeared that for dev file it is possible:
>> ls -alh /dev/
>> crw-rw----.  1 root admin_group      1,   9 Sep 15 18:28 telem<X>
>>
>> So if e.g. perf tool having CAP_PERFMON and configured like:
>>
>> -rwxr-x---.  1 root admin_group  24M Mar  5  2020 perf.cap
>>
>> would mmap /dev/telem<X> to provide uncore performance insights
>> to admin_group users only access control based on user/group/others ownership
>> would suffice without capabilities requirement.
>>
>> Still haven't had chance to verify it for memory mapped PMT dev files and
>> that is why I am asking you guys here.
>>
>> Alexei
>>
>> [1] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html#privileged-perf-users-groups
> 
> We will have to see. There is a high likelihood this code will go away
> if we switch over to binary sysfs attributes for the data. I'm still
> working on the rewrite and hope to have something we can review as an
> RFC in the next few days.

Fair enough. Would appreciate to be CCed on the PMT topic patches.

Thanks,
Alexei

