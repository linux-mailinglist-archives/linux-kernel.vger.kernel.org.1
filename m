Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619E62D49E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbgLITON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:14:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387579AbgLITOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607541156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qu+X+CU3l3H2nboXtsm0ks4Jayrw6j8ysSQm3Vmo8QQ=;
        b=FI12E+VIHhmj1ykSGSUnFpVxy7TTl2Qyat1o5nnBnwnj0fGW2GYwUWojjA3WzkKEZBkQlV
        +JoFIz4kVOzDsGMdaDtyq05tMRor+GjJSQmh8X6FQf9t3/ZAAqg87RSIvynRNYHCCNrYa3
        HVEimdH7iW34YBT8qDhf6jH3PU7gs0o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-FHdsyY6CPRmS0j_4ekbpyA-1; Wed, 09 Dec 2020 14:12:34 -0500
X-MC-Unique: FHdsyY6CPRmS0j_4ekbpyA-1
Received: by mail-qv1-f72.google.com with SMTP id m8so1932817qvk.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 11:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=qu+X+CU3l3H2nboXtsm0ks4Jayrw6j8ysSQm3Vmo8QQ=;
        b=KEbFn9fe2fSQRRdK/ufRZ9kaE9pJYwHvrqSkyjnQPndF9Cmk27konBClLatEgD705M
         k6trgmzkxPG9KAuKm9IyjUoib6borSm15nNuqVX2m2frKmKIRef3OQbY+Z/T+zphL4Ii
         pMweDUHlrYmrHd/1gDSD07Or6MgHj/SBcgSrKpiC9jDjfnSUbaHlS3usnz2EvRKufZbF
         0Y0mXwsDjdTU+9wHGs45cOW9dm6BCYl8IPqPr6JsJpnsfZcv6IWIFDYZ14V+c3/kckq0
         zGkUpSchc4IC+r0RawcdKLWSElfg1a6jqDxA92GACka+vB2BhikMRPprojIFDIzCSzz2
         8eZw==
X-Gm-Message-State: AOAM5313HlHVeEXOX+Qq4E572P0/o//dIV5YSC+lTUMk/f9HtmelpJsY
        ke4kbh7zscx5KmMn+D1TCM2/j5CmOZfIsD59bLPf5h4etzbY+OPB56N+35BuHMmy0VpZ7RFHHY7
        CtvFDnH7ubKm0nKP4+mVoQgVW
X-Received: by 2002:aed:3865:: with SMTP id j92mr4525992qte.318.1607541153515;
        Wed, 09 Dec 2020 11:12:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyD5VkRlGtdmY9MNkqm989yDI1f88xyqMGWR0Ad7zHxikNoNxEdgjy2+C5NrghMgOUe2XDj0Q==
X-Received: by 2002:aed:3865:: with SMTP id j92mr4525974qte.318.1607541153320;
        Wed, 09 Dec 2020 11:12:33 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id y6sm1703316qki.115.2020.12.09.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:12:32 -0800 (PST)
References: <20201209141237.GA8092@willie-the-truck>
 <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
 <20201209185020.GC8778@willie-the-truck>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
In-reply-to: <20201209185020.GC8778@willie-the-truck>
Date:   Wed, 09 Dec 2020 12:12:31 -0700
Message-ID: <87tusulrog.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Will Deacon @ 2020-12-09 11:50 MST:

> On Wed, Dec 09, 2020 at 10:07:46AM -0800, Linus Torvalds wrote:
>> On Wed, Dec 9, 2020 at 6:12 AM Will Deacon <will@kernel.org> wrote:
>> >
>> > Please pull this one-liner AMD IOMMU fix for 5.10. It's actually a fix
>> > for a fix, where the size of the interrupt remapping table was increased
>> > but a related constant for the size of the interrupt table was forgotten.
>> 
>> Pulled.
>
> Thanks.
>
>> However, why didn't this then add some sanity checking for the two
>> different #defines to be in sync?
>> 
>> IOW, something like
>> 
>>    #define AMD_IOMMU_IRQ_TABLE_SHIFT 9
>> 
>>    #define MAX_IRQS_PER_TABLE (1 << AMD_IOMMU_IRQ_TABLE_SHIFT)
>>    #define DTE_IRQ_TABLE_LEN ((u64)AMD_IOMMU_IRQ_TABLE_SHIFT << 1)

Since the field in the device table entry format expects it to be n
where there are 2^n entries in the table I guess it should be:

#define DTE_IRQ_TABLE_LEN 9
#define MAX_IRQS_PER_TABLE (1 << DTE_IRQ_TABLE_LEN)

>> 
>> or whatever. Hmm?
>
> This looks like a worthwhile change to me, but I don't have any hardware
> so I've been very reluctant to make even "obvious" driver changes here.
>
> Suravee -- please can you post a patch implementing the above?
>
>> That way this won't happen again, but perhaps equally importantly the
>> linkage will be more clear, and there won't be those random constants.
>> 
>> Naming above is probably garbage - I assume there's some actual
>> architectural name for that irq table length field in the DTE?
>
> The one in the spec is even better: "IntTabLen".
>
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

