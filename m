Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A782BFFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 06:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgKWFhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 00:37:22 -0500
Received: from foss.arm.com ([217.140.110.172]:58352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgKWFhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 00:37:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06E4B101E;
        Sun, 22 Nov 2020 21:37:22 -0800 (PST)
Received: from [10.163.82.200] (unknown [10.163.82.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 249C13F71F;
        Sun, 22 Nov 2020 21:37:19 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC 10/11] coresgith: etm-perf: Connect TRBE sink with ETE
 source
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-11-git-send-email-anshuman.khandual@arm.com>
 <d409acab-f811-45f7-b00f-cd2f281d6112@arm.com>
Message-ID: <e86aab46-ed7d-5634-cae5-8289974dd52d@arm.com>
Date:   Mon, 23 Nov 2020 11:07:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d409acab-f811-45f7-b00f-cd2f281d6112@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/20 3:01 PM, Suzuki K Poulose wrote:
> Hi Anshuman,
> On 11/10/20 12:45 PM, Anshuman Khandual wrote:
>> Unlike traditional sink devices, individual TRBE instances are not detected
>> via DT or ACPI nodes. Instead TRBE instances are detected during CPU online
>> process. Hence a path connecting ETE and TRBE on a given CPU would not have
>> been established until then. This adds two coresight helpers that will help
>> modify outward connections from a source device to establish and terminate
>> path to a given sink device. But this method might not be optimal and would
>> be reworked later.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Instead of this, could we come up something like a percpu_sink concept ? That
> way, the TRBE driver could register the percpu_sink for the corresponding CPU
> and we don't have to worry about the order in which the ETE will be probed
> on a hotplugged CPU. (i.e, if the TRBE is probed before the ETE, the following
> approach would fail to register the sink).

Right, it wont work.

We already have a per cpu csdev sink. The current mechanism expects all ETEs
to have been established and the TRBEs just get plugged in during their init
while probing each individual cpus. During cpu hotplug in or out, a TRBE-ETE
link either gets created and destroyed. But it assumes that an ETE is always
present for TRBE to get plugged into or teared down from. csdev for TRBE sink
too gets released during cpu hot remove path.

Are you suggesting that there should be a percpu static csdev array defined
for potential all TRBEs so that the ETE-TRBE links be permanently established
given that the ETEs are permanent and never really go away with cpu hot remove
event (my assumption). TRBE csdevs should just get enabled or disabled without
really being destroyed during cpu hotplug, so that the corresponding TRBE-ETE
connection remains in place.

> 
> And the default sink can be initialized when the ETE instance first starts
> looking for it.

IIUC def_sink is the sink which will be selected by default for a source device
while creating a path, in case there is no clear preference from the user. ETE's
default sink should be fixed (TRBE) to be on the easy side and hence assigning
that during connection expansion procedure, does make sense. But then it can be
more complex where the 'default' sink for an ETE can be scenario specific and
may not be always be its TRBE.

The expanding connections fits into a scenario where the ETE is present with
all it's other traditional sinks and TRBE is the one which comes in or goes out
with the cpu.

If ETE also comes in and goes out with individual cpu hotplug which is preferred
ideally, we would need to also

1. Co-ordinate with TRBE bring up and connection creation to avoid race
2. Rediscover traditional sinks which were attached to the ETE before -
   go back, rescan the DT/ACPI entries for sinks with whom a path can
   be established etc.

Basically there are three choices we have here

1. ETE is permanent, TRBE and ETE-TRBE path gets created or destroyed with hotplug (current proposal)
2. ETE/TRBE/ETE-TRBE path are all permanent, ETE and TRBE get enabled or disabled with hotplug
3. ETE, TRBE and ETE-TRBE path, all get created, enabled and destroyed with hotplug in sync

- Anshuman
