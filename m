Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB4295F39
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506557AbgJVNBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440897AbgJVNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603371710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9nEBR+qeF7fzxxldRzsSqweMrfINbQ5X0/47IOTMlA=;
        b=Nmbs5l5K6dfRXLWvo8RcRCIX7BB9bvbX247yilV+/bQGKSxcIHcdgOvF/4YJptwiAfr1+x
        F2J8xFn18c0XK9iOYcdeMlDgIanjvGWNRUCVCtm6PDFeOxQbJu/fkfySKMPqqPeOiJ0KUi
        HnH42guRygZWbKvSvULT++hj9Rkhi6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-HGiqRxD6PgGmMOvgBilEIQ-1; Thu, 22 Oct 2020 09:01:48 -0400
X-MC-Unique: HGiqRxD6PgGmMOvgBilEIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1B909CC06;
        Thu, 22 Oct 2020 13:01:46 +0000 (UTC)
Received: from [10.36.113.152] (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46F0C60C15;
        Thu, 22 Oct 2020 13:01:45 +0000 (UTC)
Subject: Re: [RFC PATCH 0/3] Allocate memmap from hotadded memory (per device)
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201022125835.26396-1-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3c18e078-25df-3fd4-9988-1b7677d8e05f@redhat.com>
Date:   Thu, 22 Oct 2020 15:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022125835.26396-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This does not go without saying that the patchset is not 100% complete.
> It is missing:
> 
>  - a way to disable memmap_on_memory (either sysfs or boot_time cmd)
>  - atm, arch_add_memory for s390 screams if an altmap is passed.
>    I am still thinking of a way to nicely drop handle that.
>    Maybe a function in s390 that sets memmap_on_memory false and
>    stuff that check in support_memmap_on_memory function.

Or simply implement altmap support ... shouldn't be too hard :)


-- 
Thanks,

David / dhildenb

