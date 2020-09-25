Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B95277E79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgIYDTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbgIYDTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:19:04 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601003943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFCYn9N90PrDLOK0sv1WWaDoOs0D72bQvhucjYa8Jj4=;
        b=MM6XXhdfrKhyFrvyaCa0bIpPZ1TepFaz4hRThIzC0h5pb/HRJbS9EqrY41kBsilsYD2UOY
        E/sxSmY651ZrYfkV8V1mo8WslJdSdqvABdbsTYItv4vSM6omBCwTcSizg1qftRs0lPJZcI
        vdMh7HkixmR0egztsIykZvYxaWccE2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-hhyyg20tNdyAKxvTjXz9KA-1; Thu, 24 Sep 2020 23:18:58 -0400
X-MC-Unique: hhyyg20tNdyAKxvTjXz9KA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2629A1084C80;
        Fri, 25 Sep 2020 03:18:57 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 837935D9DD;
        Fri, 25 Sep 2020 03:18:53 +0000 (UTC)
Date:   Fri, 25 Sep 2020 11:18:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ktkhai@virtuozzo.com,
        keescook@chromium.org, christian.brauner@ubuntu.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <20200925031850.GO25604@MiWiFi-R3L-srv>
References: <20200924124647.300080-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924124647.300080-1-egorenar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/20 at 02:46pm, Alexander Egorenkov wrote:
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

Seems there's some argument about the generic ns_common::count in the
thread of above link. While except of it, the adding the offset of
uts_namespace.name looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>


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
>  	VMCOREINFO_SYMBOL(node_online_map);
>  #ifdef CONFIG_MMU
>  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
> -- 
> 2.26.2
> 

