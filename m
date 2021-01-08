Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6078A2EEBE0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 04:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbhAHDe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 22:34:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbhAHDe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 22:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610076781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9r4Pdy09qEYXjuml8aWm+l9qvq4G6oNjWDZjtL93/QY=;
        b=OSp1KCiFex2Ym/ljABuIc74nX+t9Xh2MkSlxIspqNgKSgtZ5oER970tl0aZZB11uP23Xda
        m44Hn2UvRfYeWKeXoxbvpg/vVoeR0YRPt2Qv2KnJVzXMMDoWiLVfl/8OTGfmpVYK7V19ZZ
        KauH0nsowJ7+anHPs9uvOaRjpp1eW54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-7ka37owhPUyz3pdAnJvUdQ-1; Thu, 07 Jan 2021 22:32:57 -0500
X-MC-Unique: 7ka37owhPUyz3pdAnJvUdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97D0A10054FF;
        Fri,  8 Jan 2021 03:32:55 +0000 (UTC)
Received: from localhost (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 316855D9DE;
        Fri,  8 Jan 2021 03:32:50 +0000 (UTC)
Date:   Fri, 8 Jan 2021 11:32:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     gregkh@linuxfoundation.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     dyoung@redhat.com, vgoyal@redhat.com, lijiang@redhat.com,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com, keescook@chromium.org,
        christian.brauner@ubuntu.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <20210108033248.GA4959@MiWiFi-R3L-srv>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930102328.396488-1-egorenar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/20 at 12:23pm, Alexander Egorenkov wrote:
> The offset of the field 'init_uts_ns.name' has changed
> since commit 9a56493f6942 ("uts: Use generic ns_common::count").

This patch is merged into 5.11-rc1, but we met the makedumpfile failure
of kdump test case in 5.10.0 kernel. Should affect 5.9 too since
commit 9a56493f6942 is merged into 5.9-rc2.

Below tag and CC should have been added into patch when posted. 

Fixes: commit 9a56493f6942 ("uts: Use generic ns_common::count")
Cc: <stable@vger.kernel.org>

Hi Greg,

Do we still have chance to make it added into stable?

Thanks
Baoquan

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
> -- 
> 2.26.2
> 

