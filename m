Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D60219BE0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgGIJRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 05:17:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:53048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgGIJRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:17:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 411ABADE5;
        Thu,  9 Jul 2020 09:17:45 +0000 (UTC)
Subject: Re: [PATCH] efi: avoid error message when booting under Xen
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20200610141052.13258-1-jgross@suse.com>
 <094be567-2c82-7d5b-e432-288286c6c3fb@suse.com>
Message-ID: <ec21b883-dc5c-f3fe-e989-7fa13875a4c4@suse.com>
Date:   Thu, 9 Jul 2020 11:17:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <094be567-2c82-7d5b-e432-288286c6c3fb@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.20 10:50, Jürgen Groß wrote:
> Ping?
> 
> On 10.06.20 16:10, Juergen Gross wrote:
>> efifb_probe() will issue an error message in case the kernel is booted
>> as Xen dom0 from UEFI as EFI_MEMMAP won't be set in this case. Avoid
>> that message by calling efi_mem_desc_lookup() only if EFI_PARAVIRT
>> isn't set.
>>
>> Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes 
>> when mapping the FB")
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   drivers/video/fbdev/efifb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
>> index 65491ae74808..f5eccd1373e9 100644
>> --- a/drivers/video/fbdev/efifb.c
>> +++ b/drivers/video/fbdev/efifb.c
>> @@ -453,7 +453,7 @@ static int efifb_probe(struct platform_device *dev)
>>       info->apertures->ranges[0].base = efifb_fix.smem_start;
>>       info->apertures->ranges[0].size = size_remap;
>> -    if (efi_enabled(EFI_BOOT) &&
>> +    if (efi_enabled(EFI_BOOT) && !efi_enabled(EFI_PARAVIRT) &&
>>           !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
>>           if ((efifb_fix.smem_start + efifb_fix.smem_len) >
>>               (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
>>
> 

In case I see no reaction from the maintainer for another week I'll take
this patch through the Xen tree.


Juergen
