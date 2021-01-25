Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6A303295
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 04:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbhAYJdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:33:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbhAYJYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611566582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LURDbhPMlaLAAv0P/xes5PlKkHhtwQp/MfE6yM3gAVM=;
        b=cnyz8eRyAhkOMpgE7ca1vX3cn81Lk9mqDeMSMuQkdjijvADU3dyZPdHgWCncTk2eS29uH5
        HxbJJl7/u5vihXaHQetFFzFsqpZ4Ba3D22ZnhnnySjW6oPCdmC94+/04rH0lQ+btu7ICCt
        F9mLjvwRZZPxlJ6GkK9nMHgK8wJmBm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-jU330OIAMzWrudZ_RPgGXg-1; Mon, 25 Jan 2021 03:54:53 -0500
X-MC-Unique: jU330OIAMzWrudZ_RPgGXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 204818144E0;
        Mon, 25 Jan 2021 08:54:52 +0000 (UTC)
Received: from [10.36.115.13] (ovpn-115-13.ams2.redhat.com [10.36.115.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E34660C5F;
        Mon, 25 Jan 2021 08:54:50 +0000 (UTC)
Subject: Re: [PATCH] mm/memory_hotplug: Rename all existing 'memhp' into 'mhp'
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1611554093-27316-1-git-send-email-anshuman.khandual@arm.com>
 <YA6AqupAWINtNckx@kroah.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <557ea028-6b6f-6f32-7602-70a62050a3e3@redhat.com>
Date:   Mon, 25 Jan 2021 09:54:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YA6AqupAWINtNckx@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.21 09:26, Greg Kroah-Hartman wrote:
> On Mon, Jan 25, 2021 at 11:24:53AM +0530, Anshuman Khandual wrote:
>> This renames all 'memhp' instances to 'mhp' except for memhp_default_state
>> for being a kernel command line option. This is just a clean up and should
>> not cause a functional change.
> 
> THat says _what_ you are doing, but I have no idea _why_ this is needed
> for anything...
> 

Let's add something like

"Let's make it consistent, especially preparing for more users of the
'mhp' terminology."


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

