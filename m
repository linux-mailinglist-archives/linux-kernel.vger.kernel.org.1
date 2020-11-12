Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC742B01F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgKLJb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:31:27 -0500
Received: from foss.arm.com ([217.140.110.172]:45154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgKLJb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:31:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1909B139F;
        Thu, 12 Nov 2020 01:31:26 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21CE13F73C;
        Thu, 12 Nov 2020 01:31:23 -0800 (PST)
Subject: Re: [RFC 10/11] coresgith: etm-perf: Connect TRBE sink with ETE
 source
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-11-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d409acab-f811-45f7-b00f-cd2f281d6112@arm.com>
Date:   Thu, 12 Nov 2020 09:31:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <1605012309-24812-11-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,
On 11/10/20 12:45 PM, Anshuman Khandual wrote:
> Unlike traditional sink devices, individual TRBE instances are not detected
> via DT or ACPI nodes. Instead TRBE instances are detected during CPU online
> process. Hence a path connecting ETE and TRBE on a given CPU would not have
> been established until then. This adds two coresight helpers that will help
> modify outward connections from a source device to establish and terminate
> path to a given sink device. But this method might not be optimal and would
> be reworked later.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Instead of this, could we come up something like a percpu_sink concept ? That
way, the TRBE driver could register the percpu_sink for the corresponding CPU
and we don't have to worry about the order in which the ETE will be probed
on a hotplugged CPU. (i.e, if the TRBE is probed before the ETE, the following
approach would fail to register the sink).

And the default sink can be initialized when the ETE instance first starts
looking for it.

Suzuki
