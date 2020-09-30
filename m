Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8054B27E517
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgI3J0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbgI3J0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:26:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601457976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9vVuELWON6ObFrpLL5iNAXnSyN8gJXQZDJNjgnaJQc=;
        b=ekxomFJ4fcwT8UaZiAskhOmg7GbRpAeUv0BLLNuF4qBHQiMqYFcBzm/pGNW/zrS0XJnP8W
        9AHti1pmZpwqB/y8TnR1pu5tOj65UHn7nm7nixCW4X9YZFTtKSFSmZ61bYqnVqskXMzyC4
        iWWIWGzdLMm7MOmw80w/FViZzyS4VkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-URvqACt_PQ-g1dWGTwONVw-1; Wed, 30 Sep 2020 05:26:11 -0400
X-MC-Unique: URvqACt_PQ-g1dWGTwONVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 200C0190A3E1;
        Wed, 30 Sep 2020 09:26:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E89F719D61;
        Wed, 30 Sep 2020 09:26:02 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
To:     Alexander Egorenkov <egorenar@linux.ibm.com>, dyoung@redhat.com,
        bhe@redhat.com, vgoyal@redhat.com
Cc:     ebiederm@xmission.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com, keescook@chromium.org,
        christian.brauner@ubuntu.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200924124647.300080-1-egorenar@linux.ibm.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <9c96aed0-866d-c108-c8f3-a7e846828d30@redhat.com>
Date:   Wed, 30 Sep 2020 17:25:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200924124647.300080-1-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexander

在 2020年09月24日 20:46, Alexander Egorenkov 写道:
> The offset of the field 'init_uts_ns.name' has changed
> since
> 
> commit 9a56493f6942c0e2df1579986128721da96e00d8
> Author: Kirill Tkhai <ktkhai@virtuozzo.com>
> Date:   Mon Aug 3 13:16:21 2020 +0300
> 
>     uts: Use generic ns_common::count
> 
> Link: https://lore.kernel.org/r/159644978167.604812.1773586504374412107.stgit@localhost.localdomain
> 
> Make the offset of the field 'uts_namespace.name' available
> in VMCOREINFO because tools like 'crash-utility' and
> 'makedumpfile' must be able to read it from crash dumps.
> 
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 106e4500fd53..173fdc261882 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
>  
>  	VMCOREINFO_SYMBOL(init_uts_ns);
> +	VMCOREINFO_OFFSET(uts_namespace, name);

Since the new symbol is exported, would you mind adding it to Documentation/kdump/vmcoreinfo.txt ?

Thanks.
Lianbo
>  	VMCOREINFO_SYMBOL(node_online_map);
>  #ifdef CONFIG_MMU
>  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
> 

