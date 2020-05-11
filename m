Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE031CDB8D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 15:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgEKNn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 09:43:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729279AbgEKNn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589204606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2B7uPape2I014WfjGR+zUrOyLplbfNy3rAyirYvotDU=;
        b=BFToSqLl4bXIvCnlbtGGUXNabFio9BKuEWz5nPBWiewMcrI/RUnvT2UWLUJjwnL0V1C6OH
        QIvPJEzV8p7Wo6LX1kCUH6/3fKxp9KGXb5xQvW8pIpK35RpJVlaAAkFykfCliCe/NUnkiO
        iDPKv6CK8rz9tAb5wEYy659Y2QoSs3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-SgIWMMZ0NyOVZPUX71462A-1; Mon, 11 May 2020 09:43:15 -0400
X-MC-Unique: SgIWMMZ0NyOVZPUX71462A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A95B107ACF3;
        Mon, 11 May 2020 13:43:14 +0000 (UTC)
Received: from [10.3.128.27] (unknown [10.3.128.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 156965C1D3;
        Mon, 11 May 2020 13:43:11 +0000 (UTC)
Subject: Re: Failure to shutdown/reboot with intel_iommu=on
To:     Joerg Roedel <jroedel@suse.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Cc:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, x86@kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
References: <20200506144558.GA4019@taurus.defre.kleine-koenig.org>
 <20200508150734.GP8135@suse.de>
From:   Lenny Szubowicz <lszubowi@redhat.com>
Message-ID: <ff5eb4e2-89a3-57a5-c6d6-42bf743e5d16@redhat.com>
Date:   Mon, 11 May 2020 09:43:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508150734.GP8135@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 11:07 AM, Joerg Roedel wrote:
> + Baolu, Maintainer of Intel IOMMU
> 
> Baolu, does that ring any bells?
> 
> On Wed, May 06, 2020 at 04:46:02PM +0200, Uwe Kleine-König wrote:
>> Hello,
>>
>> On my Lenovo T460p I cannot shutdown and reboot when the iommu is
>> enabled. This is using linux 5.2.7 as provided by Debian, 5.6.4 has the
>> same problem. Suspend/resume also fails; I suspect this is the same
>> issue.
>>
>> When requesting power off the kernel messages just end with:
>>
>> 	sd 0:0:0:0: [sda] Synchronizing SCSI cache
>> 	sd 0:0:0:0: [sda] Stopping disk
>> 	e1000e: EEE TX LPI TIMER: 00000011
>> 	ACPI: Preparing to enter system sleep state S5
>> 	reboot: Power down
>> 	acpi_power_off called
>>
>> (photo at https://www.kleine-koenig.org/tmp/uklsiommu.jpg in case I
>> mistyped something. Full dmesg and lspci -vvv at
>> https://www.kleine-koenig.org/tmp/uklsiommu.tar.gz with and without
>> iommu enabled.)
>>
>> With the iommu disabled (CONFIG_INTEL_IOMMU_DEFAULT_ON unset or
>> intel_iommu=off on cmdline) the machine just works as expected
>> (including working suspend/resume).
>>
>> I already talked to tglx on irc but unfortunately no new insights
>> resulted from that.
>>> Any ideas how to fix or continue debugging the issue?
>>
>> Best regards
>> Uwe
> 
> 

I suspect that you have TPM 2.x functionality enabled in the BIOS/firmware.

Unless you are actually using the TPM, try setting it to TPM 1.2 mode.
I've seen an incompatiblity on other Lenovo laptops between using the
IOMMU, TPM 2.x implementation in firmware, and shutdown/suspend.

                        -Lenny.

