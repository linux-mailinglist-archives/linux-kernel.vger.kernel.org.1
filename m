Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4002686E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgINIMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:12:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:26862 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgINIJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:09:05 -0400
IronPort-SDR: HHVcVZbpZy0ZOCJyWvkMk6D6xXm7mzqD8erW1fhBcCpQZmeqy7vc2v1QLSrTtFRPbb2DbreGxo
 4hxP/WfMZk0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="146780957"
X-IronPort-AV: E=Sophos;i="5.76,425,1592895600"; 
   d="scan'208";a="146780957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 01:08:42 -0700
IronPort-SDR: ibFpH2XMJyKrwM93Dd8zZBRyDTabJLqYves4nwbbb4NnK4QnfUgU0Y+vj60iG4uU9gltQs46Zw
 Wc4RxdFivM8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,425,1592895600"; 
   d="scan'208";a="408790526"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by fmsmga001.fm.intel.com with ESMTP; 14 Sep 2020 01:08:40 -0700
Subject: Re: [RFC PATCH V3 13/21] mmc: sdhci: UHS-II support, skip
 signal_voltage_switch()
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111104.29616-1-benchuanggli@gmail.com>
 <9ab64a9d-cd78-785c-b48f-561048cfe2ed@intel.com>
 <20200914064001.GA2743583@laputa>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a0000661-a0e1-8813-0672-c0eb73184079@intel.com>
Date:   Mon, 14 Sep 2020 11:08:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914064001.GA2743583@laputa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/20 9:40 am, AKASHI Takahiro wrote:
> Adrian,
> 
> On Fri, Aug 21, 2020 at 05:09:01PM +0300, Adrian Hunter wrote:
>> On 10/07/20 2:11 pm, Ben Chuang wrote:
>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>
>>> sdhci_start_signal_voltage_switch() should be called only in UHS-I mode,
>>> and not for UHS-II mode.
>>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 5511649946b9..7f2537648a08 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2623,8 +2623,13 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>>  	/*
>>>  	 * Signal Voltage Switching is only applicable for Host Controllers
>>>  	 * v3.00 and above.
>>> +	 * But for UHS2, the signal voltage is supplied by vdd2 which is
>>> +	 * already 1.8v so no voltage switch required.
>>>  	 */
>>> -	if (host->version < SDHCI_SPEC_300)
>>> +	if (host->version < SDHCI_SPEC_300 ||
>>> +	    (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
>>> +	     host->version >= SDHCI_SPEC_400 &&
>>> +	     host->mmc->flags & MMC_UHS2_SUPPORT))
>>
>> Please look at hooking ->start_signal_voltage_switch() instead
> 
> Do you mean that you want every platform driver who wants to support UHS-II
> to set NULL to start_signal_voltage_switch hook even if this hack is
> platform agnostic?

No, I see UHS-II as a separate layer i.e.

 UHS-II host controller driver
  |   |
  |   v
  |   sdhci-uhs2 e.g. sdhci_uhs2_start_signal_voltage_switch
  |   |
  v   v
  sdhci e.g. sdhci_start_signal_voltage_switch

Most things should go through sdhci-uhs2 but not nessarily everything.
