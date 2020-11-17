Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05CA2B691E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgKQPxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:53:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgKQPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605628427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45NpE8HlxjJaBCusr1AgP66M2rQRdJBOzgIqToWUpzE=;
        b=SONFfHnAx/IusAICcP2ph4A4Z2MvqS/2na0ePm4wByWcEZGgT1nKCo10kvfBeP4vTXA0/I
        zOeQiHUiUXr+2zuCDdlJYXbCPowrkhNwlOuj/Ha55Lf2sjQ7QTzyb6qB47VPqTuhyAPGuD
        d+A9Gy5zcbOECGuFjqDUdaiYwDMT/Q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-Mk5rumDnMzelMMXlOPFPBw-1; Tue, 17 Nov 2020 10:53:45 -0500
X-MC-Unique: Mk5rumDnMzelMMXlOPFPBw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 526A4CF94A;
        Tue, 17 Nov 2020 15:53:35 +0000 (UTC)
Received: from [10.36.114.99] (ovpn-114-99.ams2.redhat.com [10.36.114.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C553E19D6C;
        Tue, 17 Nov 2020 15:53:32 +0000 (UTC)
Subject: Re: [PATCH v2 7/8] powerpc/mm: remove linear mapping if __add_pages()
 fails in arch_add_memory()
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201111145322.15793-1-david@redhat.com>
 <20201111145322.15793-8-david@redhat.com> <20201117155125.GF15987@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <dac16bcc-8e37-8cb2-ac61-912a17ab5985@redhat.com>
Date:   Tue, 17 Nov 2020 16:53:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201117155125.GF15987@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.20 16:51, Oscar Salvador wrote:
> On Wed, Nov 11, 2020 at 03:53:21PM +0100, David Hildenbrand wrote:
>> Let's revert what we did in case seomthing goes wrong and we return an
> "something" :-)

Thanks! :)

@Michael, I assume if I don't have to resend, this can be fixed up?

-- 
Thanks,

David / dhildenb

