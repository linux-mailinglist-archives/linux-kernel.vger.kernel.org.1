Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA352ECC15
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbhAGIzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:55:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbhAGIzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610009635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VnMdV8KJMJ17J1dCjQPgPbu7cJhRA01SnsrY34SOH7c=;
        b=BYubCQ3yNvObpFrgUfnHZ0TpXNzujZ/mztG+x28ES5zKHm2rn9095EsY39XTxrhyomLLvP
        axz9AgQ+PKpcarzWHll++t0wC2IAxFTIFAKwxjZja6LXljid4QatOzydoWvTTuBC5Pl4W5
        d0+GEDa4KcL5OXQi/nAlxew220kXrYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-clAEW5aGPXGlyysB1gR9YA-1; Thu, 07 Jan 2021 03:53:53 -0500
X-MC-Unique: clAEW5aGPXGlyysB1gR9YA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4F1B801817;
        Thu,  7 Jan 2021 08:53:50 +0000 (UTC)
Received: from [10.36.114.161] (ovpn-114-161.ams2.redhat.com [10.36.114.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DE7D5C8AA;
        Thu,  7 Jan 2021 08:53:44 +0000 (UTC)
Subject: Re: [PATCH 3/6] hugetlb: add free page reporting support
To:     Liang Li <liliang324@gmail.com>, Michal Hocko <mhocko@suse.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
References: <20210106034918.GA1154@open-light-1.localdomain>
 <20210106160827.GO13207@dhcp22.suse.cz>
 <CA+2MQi-pxRkaftawN=tMxDT7wWyXuS6ZjofcqK+2fwQ9LHvwfQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f711ff53-4ba2-9474-73e8-48363a5157d7@redhat.com>
Date:   Thu, 7 Jan 2021 09:53:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+2MQi-pxRkaftawN=tMxDT7wWyXuS6ZjofcqK+2fwQ9LHvwfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.01.21 04:38, Liang Li wrote:
> On Thu, Jan 7, 2021 at 12:08 AM Michal Hocko <mhocko@suse.com> wrote:
>>
>> On Tue 05-01-21 22:49:21, Liang Li wrote:
>>> hugetlb manages its page in hstate's free page list, not in buddy
>>> system, this patch try to make it works for hugetlbfs. It canbe
>>> used for memory overcommit in virtualization and hugetlb pre zero
>>> out.
>>
>> David has layed down some more fundamental questions in the reply to the
>> cover letter (btw. can you fix your scripts to send patches and make all
>> the patches to be in reply to the cover letter please?). But I would
> 
> Do you mean attach the patches in the email for the cover letter ?

You should be using "git format-patch --cover-letter . .." followed by
"git send-email ...", so the end result is a nicely structured thread.

-- 
Thanks,

David / dhildenb

