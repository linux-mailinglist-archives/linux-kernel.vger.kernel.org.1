Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D80A29330E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 04:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390579AbgJTC3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 22:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730427AbgJTC3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 22:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603160941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1KxxLVKoaWNk/UcWabDXog7LeDPLrAENYaxCZHkvRPc=;
        b=TiAmV6qJbVUIU19MaIYld4XbzGthK6FypR31LJpZwi/aGf5Thuny/2Bph7eqFkPEadU41M
        rHZBnAAL6T3kcElrnpFsz75vXcEni2G/HhPukCvpLPp2/R83c08bOSZL/Y5pZVKNZgzdHE
        IItGdJ6V3CcgRmu43tGUAbVaoGmPqkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-Y7qnAA4wMz2_zxMRqL709A-1; Mon, 19 Oct 2020 22:28:57 -0400
X-MC-Unique: Y7qnAA4wMz2_zxMRqL709A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A7351882FB5;
        Tue, 20 Oct 2020 02:28:55 +0000 (UTC)
Received: from localhost (ovpn-12-159.pek2.redhat.com [10.72.12.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07B0955798;
        Tue, 20 Oct 2020 02:28:51 +0000 (UTC)
Date:   Tue, 20 Oct 2020 10:28:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     dyoung@redhat.com, vgoyal@redhat.com, lijiang@redhat.com,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com, keescook@chromium.org,
        christian.brauner@ubuntu.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <20201020022849.GT25604@MiWiFi-R3L-srv>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930102328.396488-1-egorenar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/20 at 12:23pm, Alexander Egorenkov wrote:
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

Ack, thanks.

Acked-by: Baoquan He <bhe@redhat.com>

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

