Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0626F2C6A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbgK0RAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:00:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730675AbgK0RAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606496454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EhEV+wsKeWCLvw5Za69I3r2D9GX7zL+Z/rQpU2ehWsk=;
        b=KwpPuXVD3ay0MS0/9P9yy3yW8iioTbYpzfekVbNVn4oGAB5FGQ80cz+oAllAkzmICFpmC9
        2RJcd8v5hXDoLCGmo7bfbR/RTBL8WCLOV+NXa6pM82G3xnfTIWNYxom2d3vf47Cwwk9IlY
        h8z/ufhaR7lIIzfBmL8MSqPQXrToPXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-Dfa3FLZZOq6u9dtbDTGfLQ-1; Fri, 27 Nov 2020 12:00:51 -0500
X-MC-Unique: Dfa3FLZZOq6u9dtbDTGfLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75A9A8145E5;
        Fri, 27 Nov 2020 17:00:49 +0000 (UTC)
Received: from [10.36.114.118] (ovpn-114-118.ams2.redhat.com [10.36.114.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E5605B4A0;
        Fri, 27 Nov 2020 17:00:44 +0000 (UTC)
Subject: Re: [PATCH] mm: Don't fault around userfaultfd-registered regions on
 reads
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20201126222359.8120-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a240da04-1446-9282-c250-00507b745744@redhat.com>
Date:   Fri, 27 Nov 2020 18:00:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201126222359.8120-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.11.20 23:23, Peter Xu wrote:
> Faulting around for reads are in most cases helpful for the performance so that
> continuous memory accesses may avoid another trip of page fault.  However it
> may not always work as expected.
> 
> For example, userfaultfd registered regions may not be the best candidate for
> pre-faults around the reads.

Are we getting uffd faults even though no-one actually accessed it? So
in case I would track what some part of my program actually reads, I
would get wrong notifications?

-- 
Thanks,

David / dhildenb

