Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B5C280C4F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 04:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbgJBCik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 22:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727780AbgJBCik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 22:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601606318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxlJZv7250vMcqPC75U7W1SFNvc/Tb2JnKg+PXp0UTA=;
        b=bL9OwdYzX85ajE3HtRD6JQ43+znGCqqkCDjFgdNeHZQtiMjngpltwpbnMQIN+eIYgpsBTH
        Q1IaVM6HUuxkMnDKAiCHBQ7gLi7wZIocNOiqI1A4tcCMO5Y0EjzZwr0PZ+KG6WpY6s6BhJ
        vwdX9dn9h9gkcliwq8pDtbdSTWVPFrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-1hUTvxLqMkSdmAJGzjDrFw-1; Thu, 01 Oct 2020 22:38:35 -0400
X-MC-Unique: 1hUTvxLqMkSdmAJGzjDrFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ED971074660;
        Fri,  2 Oct 2020 02:38:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B7995D9D3;
        Fri,  2 Oct 2020 02:38:26 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
To:     Alexander Egorenkov <egorenar@linux.ibm.com>, dyoung@redhat.com,
        bhe@redhat.com, vgoyal@redhat.com
Cc:     ebiederm@xmission.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com, keescook@chromium.org,
        christian.brauner@ubuntu.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <60526b10-35eb-b6ba-b08d-70ebfe5d07b5@redhat.com>
Date:   Fri, 2 Oct 2020 10:38:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200930102328.396488-1-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexander

在 2020年09月30日 18:23, Alexander Egorenkov 写道:
> The offset of the field 'init_uts_ns.name' has changed
> since commit 9a56493f6942 ("uts: Use generic ns_common::count").
> 
> Link: https://lore.kernel.org/r/159644978167.604812.1773586504374412107.stgit@localhost.localdomain
> 
> Make the offset of the field 'uts_namespace.name' available
> in VMCOREINFO because tools like 'crash-utility' and
> 'makedumpfile' must be able to read it from crash dumps.
> 
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
> 
> v2 -> v3:
>  * Added documentation to vmcoreinfo.rst
>  * Use the short form of the commit reference
> 
> v1 -> v2:
>  * Improved commit message
>  * Added link to the discussion of the uts namespace changes
> 
>  Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
>  kernel/crash_core.c                            | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index e44a6c01f336..3861a25faae1 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -39,6 +39,12 @@ call.
>  User-space tools can get the kernel name, host name, kernel release
>  number, kernel version, architecture name and OS type from it.
>  
> +(uts_namespace, name)
> +---------------------
> +
> +Offset of the name's member. Crash Utility and Makedumpfile get
> +the start address of the init_uts_ns.name from this.
> +

Thank you for the update. The v3 looks good to me.

>  node_online_map
>  ---------------
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
> 

