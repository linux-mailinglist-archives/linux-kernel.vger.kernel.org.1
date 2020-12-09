Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3842D4806
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbgLIRfF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Dec 2020 12:35:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33615 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgLIRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:35:05 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kn3M6-000612-JN
        for linux-kernel@vger.kernel.org; Wed, 09 Dec 2020 17:34:22 +0000
Received: by mail-pf1-f198.google.com with SMTP id f3so1508019pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 09:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+gPKRugdm71QnmWaeU7WUMU+tuEzJUxN9TQyRCaiSac=;
        b=AdzOGDVZLh33B4fsNPYxWFmmK1npbt3yZzIq5IHacKDDU0Q1ZXhzYJpVBhIJ/I8F8j
         80dIc3offgLmJ2CuGl+abSWs06m3LxCvkEH2Si570iWDZJB0mtV50+st0q/V7ajYltQ5
         /Rskx4gvq4BShDcRHzW4SA+aSQPst/Y29JAl+lZyt7mrW5DH1btoQOox1TCaaRXvF3nC
         WWXM/hEuKwuARtQW+HCBSBSPraiiBwfBm86/senPs1WaA4D9YraIXD7GwyjDkpomIrgD
         ACByka5xcthitDTIYHPTsV1GwnFqpvsNxi8N6GDjkEBtQJiAUso5JWKiVAe0RkYrivsK
         46Zw==
X-Gm-Message-State: AOAM532Zw2eltW6TMpWmyr0yjKJnY83EwAI66d82IW1TzQoI5oYfahgP
        O9WdNdRYPzTOpJoRUjfkiqWCFaQFLSFGRIWVrKQSYrL+ashKoKPHIMwmqZUANZqcRBA6J78pB1y
        NCTP4hkHpSMsyA/8J5h3A5peyty0JRgNPzPfVG25Z2A==
X-Received: by 2002:a17:902:7606:b029:da:246c:5bd8 with SMTP id k6-20020a1709027606b02900da246c5bd8mr3127784pll.27.1607535261053;
        Wed, 09 Dec 2020 09:34:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz58EauBrALh6R+Sji7FCL62IXSQrfiUaCgkaopANqGC9jgUCDSMkb4Vyi7oK9amueBmSx37A==
X-Received: by 2002:a17:902:7606:b029:da:246c:5bd8 with SMTP id k6-20020a1709027606b02900da246c5bd8mr3127751pll.27.1607535260705;
        Wed, 09 Dec 2020 09:34:20 -0800 (PST)
Received: from [192.168.1.104] (36-229-231-79.dynamic-ip.hinet.net. [36.229.231.79])
        by smtp.gmail.com with ESMTPSA id w11sm3364558pfi.162.2020.12.09.09.34.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 09:34:19 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH 1/2] PCI/ASPM: Store disabled ASPM states
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <4212dca6-233b-4d6c-0182-1e7912a05b3f@gmail.com>
Date:   Thu, 10 Dec 2020 01:34:15 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <54178B64-25A7-48AA-8836-D48900A4DA2F@canonical.com>
References: <20201208082534.2460215-1-kai.heng.feng@canonical.com>
 <4212dca6-233b-4d6c-0182-1e7912a05b3f@gmail.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 9, 2020, at 01:11, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
> Am 08.12.2020 um 09:25 schrieb Kai-Heng Feng:
>> If we use sysfs to disable L1 ASPM, then enable one L1 ASPM substate
>> again, all other substates will also be enabled too:
>> 
>> link# grep . *
>> clkpm:1
>> l0s_aspm:1
>> l1_1_aspm:1
>> l1_1_pcipm:1
>> l1_2_aspm:1
>> l1_2_pcipm:1
>> l1_aspm:1
>> 
>> link# echo 0 > l1_aspm
>> 
>> link# grep . *
>> clkpm:1
>> l0s_aspm:1
>> l1_1_aspm:0
>> l1_1_pcipm:0
>> l1_2_aspm:0
>> l1_2_pcipm:0
>> l1_aspm:0
>> 
>> link# echo 1 > l1_2_aspm
>> 
>> link# grep . *
>> clkpm:1
>> l0s_aspm:1
>> l1_1_aspm:1
>> l1_1_pcipm:1
>> l1_2_aspm:1
>> l1_2_pcipm:1
>> l1_aspm:1
>> 
>> This is because disabled ASPM states weren't saved, so enable any of the
>> substate will also enable others.
>> 
>> So store the disabled ASPM states for consistency.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/pci/pcie/aspm.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index ac0557a305af..2ea9fddadfad 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -658,6 +658,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>> 	/* Setup initial capable state. Will be updated later */
>> 	link->aspm_capable = link->aspm_support;
>> 
>> +	link->aspm_disable = link->aspm_capable & ~link->aspm_default;
>> +
> 
> This makes sense only in combination with patch 2. However I think patch 1
> should be independent of patch 2. Especially if we consider patch 1 a fix
> that is applied to stable whilst patch 2 is an improvement for next.
> 
>> 	/* Get and check endpoint acceptable latencies */
>> 	list_for_each_entry(child, &linkbus->devices, bus_list) {
>> 		u32 reg32, encoding;
>> @@ -1226,11 +1228,15 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>> 	mutex_lock(&aspm_lock);
>> 
>> 	if (state_enable) {
>> -		link->aspm_disable &= ~state;
>> 		/* need to enable L1 for substates */
>> 		if (state & ASPM_STATE_L1SS)
>> -			link->aspm_disable &= ~ASPM_STATE_L1;
>> +			state |= ASPM_STATE_L1;
>> +
>> +		link->aspm_disable &= ~state;
> 
> I don't see what this part of the patch changes. Can you elaborate on why
> this is needed?

No this is just a cosmetic change. Of course "cosmetic" is really subjective.
I'll drop this part in v2.

> 
>> 	} else {
>> +		if (state == ASPM_STATE_L1)
>> +			state |= ASPM_STATE_L1SS;
>> +
> 
> I think this part should be sufficient to fix the behavior. because what
> I think currently happens:
> 
> 1. original status: policy powersupersave, nothing disabled -> L1 + L1SS active
> 2. disable L1: L1 disabled, pcie_config_aspm_link() disabled L1 and L1SS
>   w/o adding L1SS to link-> aspm_disabled
> 3. enable one L1SS state: aspm_attr_store_common() removes L1 from
>   link->aspm_disabled -> link->aspm_disabled is empty, resulting in
>   L1 + L1SS being active

Yes. This is the case the patch solves.

Kai-Heng

> 
>> 		link->aspm_disable |= state;
>> 	}

