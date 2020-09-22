Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E1F27429F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgIVNFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:05:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:31387 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgIVNFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:05:13 -0400
IronPort-SDR: ++hPNMZ3GdNTTM52hi2ilCC5wHqtJ1ECmLROuGCteZkCHzqKoYfe9I75oOFLE73Zeg8g9iEQw6
 gsnbOlD9kBpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="148344979"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="148344979"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 06:05:09 -0700
IronPort-SDR: Dg8t8sZuJOfc8zxrlqmZu3aT6U+/kd/zQJkt4gjAuIfQtJlE6VZL/dN2vdbNG6hxpV4s9i467x
 DOSNq+XWlNlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="322209560"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2020 06:05:09 -0700
Received: from [10.251.15.64] (kliang2-MOBL.ccr.corp.intel.com [10.251.15.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A61B1580784;
        Tue, 22 Sep 2020 06:05:08 -0700 (PDT)
Subject: Re: [RESEND PATCH V2 5/6] perf/x86/intel/uncore: Generic support for
 the PCI sub driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        eranian@google.com, ak@linux.intel.com
References: <20200921221926.GA2139384@bjorn-Precision-5520>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <fed2be1d-205c-ad45-3f29-dd85875ab9a2@linux.intel.com>
Date:   Tue, 22 Sep 2020 09:05:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921221926.GA2139384@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/2020 6:19 PM, Bjorn Helgaas wrote:
> On Mon, Sep 14, 2020 at 07:34:19AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Some uncore counters may be located in the configuration space of a PCI
>> device, which already has a bonded driver. Currently, the uncore driver
>> cannot register a PCI uncore PMU for these counters, because, to
>> register a PCI uncore PMU, the uncore driver must be bond to the device.
>> However, one device can only have one bonded driver.
>>
>> Add an uncore PCI sub driver to support such kind of devices.
>>
>> The sub driver doesn't own the device. In initialization, the sub
>> driver searches the device via pci_get_device(), and register the
>> corresponding PMU for the device. In the meantime, the sub driver
>> registeris a PCI bus notifier, which is used to notify the sub driver
>> once the device is removed. The sub driver can unregister the PMU
>> accordingly.
> 
> s/registeris/registers/
> 
> It looks like this only handles hot-remove of the device, not hot-add.
> Maybe that's OK for your use case, I dunno, so just pointing it out.
> 

Hi Bjorn,

Thanks for the review.

Yes, the patch only supports the hot-remove for now, because
- I didn't get any requests for the hot-add support. I doubt anyone 
hot-adds a Root Port device in practice.
- To be honest, I don't have a test case to verify the hot-add of a Root 
Port device.
   I used the command line below to test the hot-remove.
   sudo bash -c 'echo 1 > /sys/bus/pci/devices/0000\:14\:04.0/remove'
   Then the device is gone. I have no idea how to add it back.

So I only implemented the hot-remove in this patch. If anyone requires 
the hot-add, I can add it later separately.

Thanks,
Kan
