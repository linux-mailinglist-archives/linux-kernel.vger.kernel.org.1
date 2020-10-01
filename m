Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39C228090F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbgJAVEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgJAVEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:04:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79CEC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 14:04:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so5001963pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=qMDdCoXmVxPGL1MIQRMRxSzQilrBeZApA2UrgN5504U=;
        b=Laol488fCirweoFUf+rIXyFRLdXl0N/2TH+PXIZw0FKrGU1FDY8c7PVavF2CC6zdoG
         mLqqZau+JOG2bfwR65S1rsrrKJfQH7jKixEAVovfZUoprc30bx0NzeCYE2yF+8q2srXh
         LVXdxVJksfHTjXKwccCVVjJFz5pGdPscost7380YlOOq8WwR/BBBBQLe7J/yl6qIhxIM
         fvtxtci+BcLekH0FrAGR3SDPy6Ypb+hl2xlCYGA03rgWau/8VSSuHJb6rA0+2g88Hc8o
         2H7UwFTFCc1Ena/mumD/yZIjRCrv/qf3pUSxuY20AdWrGzDYeaZnxUkPnFZcFfw/+YpL
         ru/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=qMDdCoXmVxPGL1MIQRMRxSzQilrBeZApA2UrgN5504U=;
        b=eyYhaX/ocpcCDPtF1yDAPWMwgD/BalAKqIlbUWRfcL25dJuKDeMAGzWNpeK4Ck+C6O
         Vi6yhsVJlLTM1DkN6GN1qVqxIt6ZKttD6hsEPVez1gh4d9W9+t2g5MQ4ywREYWGg+J/N
         +mz8GWhFmY/STggo68uQ4CfKwhnbIAQxhFjO9LoCld6nPoSPZTxX4byL+mLnCLlSB0ry
         AddcSDa4tkNPfyU7c68IKgKGH6lopw+MT4tzNLywBjOwremADmj9BV2pD/I2jzZgRsBF
         AwojEcblyB97jAsNjbLf610FrHoBlj1VBH4rEf5nJg1RZIvM2D8ZLBcgPBYpDTCwwPrG
         7lJg==
X-Gm-Message-State: AOAM532caQBf8wsL7yv1HPyU5yfJfW8SWkvmprKnFT9XhTGKwIqAd7Gg
        mQSc4fY2TVhHauiWN+5sH/ku6w==
X-Google-Smtp-Source: ABdhPJxy/DP9oylD7puOjIdkHkVFZDCHq6dgmXp/1cIzmglNVSIA3cOJyoNmPyzTJLibFOsygBiJGg==
X-Received: by 2002:a62:7fcf:0:b029:151:15e0:ab82 with SMTP id a198-20020a627fcf0000b029015115e0ab82mr4534380pfd.80.1601586291427;
        Thu, 01 Oct 2020 14:04:51 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id q81sm1810186pfc.36.2020.10.01.14.04.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 14:04:50 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/13] PCI/ERR: Use "bridge" for clarity in
 pcie_do_recovery()
Date:   Thu, 01 Oct 2020 14:04:49 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <42394E6B-6BD6-4628-BF1F-E1F14F6A86F1@intel.com>
In-Reply-To: <20201001090657.00003fe4@Huawei.com>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
 <20200930215820.1113353-6-seanvk.dev@oregontracks.org>
 <20201001090657.00003fe4@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Oct 2020, at 2:06, Jonathan Cameron wrote:

> On Wed, 30 Sep 2020 14:58:12 -0700
> Sean V Kelley <seanvk.dev@oregontracks.org> wrote:
>
>> From: Sean V Kelley <sean.v.kelley@intel.com>
>>
>> The term "dev" is being applied to root ports, switch
>> upstream ports, switch downstream ports, and the upstream
>> ports on endpoints. While endpoint upstream ports don't have
>> subordinate buses, a generic term such as "bridge" may be used
>
> This sentence is a bit confusing.  The bit before the comma
> seems only slightly connected. Perhaps 2 sentences?

I agree.  Will reword.
>
>> for something with a subordinate bus. The current conditional
>> logic in pcie_do_recovery() would also benefit from some
>> simplification with use of pci_upstream_bridge() in place of
>> dev->bus->self. Reverse the pcie_do_recovery() conditional logic
>> and replace use of "dev" with "bridge" for greater clarity.
>>
>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Sean

>
>> ---
>>  drivers/pci/pcie/err.c | 20 +++++++++++++-------
>>  1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 950612342f1c..c6922c099c76 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -152,16 +152,22 @@ pci_ers_result_t pcie_do_recovery(struct 
>> pci_dev *dev,
>>  {
>>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>>  	struct pci_bus *bus;
>> +	struct pci_dev *bridge;
>> +	int type;
>>
>>  	/*
>> -	 * Error recovery runs on all subordinates of the first downstream 
>> port.
>> -	 * If the downstream port detected the error, it is cleared at the 
>> end.
>> +	 * Error recovery runs on all subordinates of the first downstream
>> +	 * bridge. If the downstream bridge detected the error, it is
>> +	 * cleared at the end.
>>  	 */
>> -	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>> -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
>> -		dev = dev->bus->self;
>> -	bus = dev->subordinate;
>> -
>> +	type = pci_pcie_type(dev);
>> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>> +	    type == PCI_EXP_TYPE_DOWNSTREAM)
>> +		bridge = dev;
>> +	else
>> +		bridge = pci_upstream_bridge(dev);
>> +
>> +	bus = bridge->subordinate;
>>  	pci_dbg(dev, "broadcast error_detected message\n");
>>  	if (state == pci_channel_io_frozen) {
>>  		pci_walk_bus(bus, report_frozen_detected, &status);
