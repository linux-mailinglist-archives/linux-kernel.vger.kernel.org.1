Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26012D4857
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgLIRvM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Dec 2020 12:51:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34089 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgLIRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:51:12 -0500
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kn3bh-0007iU-De
        for linux-kernel@vger.kernel.org; Wed, 09 Dec 2020 17:50:29 +0000
Received: by mail-pj1-f69.google.com with SMTP id hg11so1246785pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 09:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WOZeix5vvOQuXdsJGlu4vfA3jFYuqZ94agmcIqxRVFU=;
        b=iehlgCpTGKNqxdQlNnUCPVKu3IkGSSR3MQgOBi1j1mXbFeeGRJsKVMfcSqld5e7j69
         79Ie1/uFlsIf8OBgCTtvZSEaSbNF6Oh5w/A0Jh7Bxq6wswcnVaVvymdeS4Zu6LRtLrzL
         rmsVy5MQ5OZhPSnZ2ui0ZwFr7OCWeve8u7cYtEu+mRKJGTtp1wzB6ckDgA9uGWVaX7yn
         0DDwMw2X3S7su+5pKZDMCoe68Hh7Fb2iF210ihflML7DBdkpNxaCmvjmh3Q0rqRv9ncm
         DI/qg+8S9XeEGpif0ngUm2z93vdszcH7kygOIE7LzUg0ctYghfB2kLyImkcZrxNZG2kR
         w38g==
X-Gm-Message-State: AOAM530EhUF+l2k8ODw83qF9AhVO0ttFFenox6cOzcf5HEJ/Rv2gRLiK
        1Sxzi8kEKGpmm2SMhO9IiaWDoGmVo1SNBLIbVbWuutSo8JCnodd5Dy1MRPt12iCHKVo1ub7wU2A
        bg6XUBHJWy/+hgF7iaidfVdlJiZRRt+mcZvM+/247Uw==
X-Received: by 2002:a17:90a:4606:: with SMTP id w6mr3270205pjg.10.1607536228056;
        Wed, 09 Dec 2020 09:50:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz34otOSKLC+yozh4uJrqTPVGFLz9S5cc+kJIyEW3ahDVXVzCsbgQkM99FpSo3ULeNg3c6Mvg==
X-Received: by 2002:a17:90a:4606:: with SMTP id w6mr3270185pjg.10.1607536227740;
        Wed, 09 Dec 2020 09:50:27 -0800 (PST)
Received: from [192.168.1.104] (36-229-231-79.dynamic-ip.hinet.net. [36.229.231.79])
        by smtp.gmail.com with ESMTPSA id z65sm3525325pfz.126.2020.12.09.09.50.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 09:50:27 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH 2/2] PCI/ASPM: Use capability to override ASPM via sysfs
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <d47544b3-b9a0-609c-fc97-527c9416f9a0@gmail.com>
Date:   Thu, 10 Dec 2020 01:50:23 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F3AF37E2-AC64-470D-B489-7FE16AC4C943@canonical.com>
References: <20201208082534.2460215-1-kai.heng.feng@canonical.com>
 <20201208082534.2460215-2-kai.heng.feng@canonical.com>
 <d47544b3-b9a0-609c-fc97-527c9416f9a0@gmail.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 9, 2020, at 01:18, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
> Am 08.12.2020 um 09:25 schrieb Kai-Heng Feng:
>> If we are to use sysfs to change ASPM settings, we may want to override
>> the default ASPM policy.
>> 
>> So use ASPM capability, instead of default policy, to be able to use all
>> possible ASPM states.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/pci/pcie/aspm.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 2ea9fddadfad..326da7bbc84d 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1239,8 +1239,7 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>> 
>> 		link->aspm_disable |= state;
>> 	}
>> -
>> -	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>> +	pcie_config_aspm_link(link, link->aspm_capable);
>> 
> I like the idea, because the policy can be changed by the user anyway.
> Therefore I don't see it as a hard system limit.
> 
> However I think this change is not sufficient. Each call to
> pcie_config_aspm_link(link, policy_to_aspm_state(link)), e.g. in path
> pcie_aspm_pm_state_change -> pcie_config_aspm_path will reset the
> enabled states to the policy.

That's right, let me work this in v2.

Kai-Heng

> 
>> 	mutex_unlock(&aspm_lock);
>> 	up_read(&pci_bus_sem);
>> 
> 

