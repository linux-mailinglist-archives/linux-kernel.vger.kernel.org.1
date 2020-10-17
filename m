Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7825A291108
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 11:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437798AbgJQJgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 05:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437763AbgJQJgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 05:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602927407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56DeDJ546FnlLJEUXisq/vRqsIQGDX0v5Ga48J4Hjlg=;
        b=MgYxuAxRHGzGmwr5gMH9BKBBcSM1Vy1DjJqd3F+OH7+vl/s0XXxTj7H9m6u1XJuK59A4BS
        b00wsOWw4UHby05AoppA1Vbsk3JjBiiwZnM7nhTOJIkTiUug1j/2r6mnkAD4u2ONSjBNgN
        jvHhtqcejClOm5sV/RnC1kQqGXHy3Bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-NdvBizmWN6O4WjHIbSM9Pw-1; Sat, 17 Oct 2020 05:36:43 -0400
X-MC-Unique: NdvBizmWN6O4WjHIbSM9Pw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A0B757053;
        Sat, 17 Oct 2020 09:36:42 +0000 (UTC)
Received: from [10.36.112.50] (ovpn-112-50.ams2.redhat.com [10.36.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F34E81002C00;
        Sat, 17 Oct 2020 09:36:39 +0000 (UTC)
Subject: Re: [PATCH 1/2] mm/memory_hotplug: allow marking of memory sections
 as hotpluggable
To:     Mike Rapoport <rppt@kernel.org>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <cover.1602899443.git.sudaraja@codeaurora.org>
 <2cba881c51e42cfe5ba213e09273642136e8ef93.1602899443.git.sudaraja@codeaurora.org>
 <20201017082600.GB16395@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <51333360-bcf6-0d21-923c-ce8aca4c8719@redhat.com>
Date:   Sat, 17 Oct 2020 11:36:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201017082600.GB16395@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.20 10:26, Mike Rapoport wrote:
> On Fri, Oct 16, 2020 at 07:02:23PM -0700, Sudarshan Rajagopalan wrote:
>> Certain architectures such as arm64 doesn't allow boot memory to be
>> offlined and removed. Distinguish certain memory sections as
>> "hotpluggable" which can be marked by module drivers stating to memory
>> hotplug layer that these sections can be offlined and then removed.
> 
> I don't quite follow why marking sections as hotpluggable or not should
> be done by a device driver. Can you describe in more details your
> use-case and why there is a need to add a flag to the memory map?
> 

This seems to be related to

https://lkml.kernel.org/r/de8388df2fbc5a6a33aab95831ba7db4@codeaurora.org

After reading how the driver is trying to abuse memory hot(un)plug
infrastructure, my tentative

Nacked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

