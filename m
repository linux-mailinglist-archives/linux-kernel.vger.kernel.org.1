Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57052D509A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgLJCG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:06:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727662AbgLJCGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607565918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bMTsarmZ3rdaAqV3OBcsA5tbkP+r5zT+YS2adqptF7A=;
        b=izhlQsTRhuB10B9/QSGB3uSBrCzfOOL+zVFdX6ckrXcg+YI44a1jcUiaQg3pwRZPmVfYwQ
        /lGydVeXszmT9Uni68gXI+GKNK2VNxVJrGa+/Ui518AE3H+6KvGJB/hT1y45klQ1TmvgWM
        Zkn7GgpXRGnYDK9jktVZmYHHC5g2xk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-5XKOH-0oPaCiEVTgP1yXkw-1; Wed, 09 Dec 2020 21:05:16 -0500
X-MC-Unique: 5XKOH-0oPaCiEVTgP1yXkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C336B858183;
        Thu, 10 Dec 2020 02:05:14 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-57.pek2.redhat.com [10.72.13.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57C305C1C4;
        Thu, 10 Dec 2020 02:05:11 +0000 (UTC)
Date:   Thu, 10 Dec 2020 10:05:08 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kexec: Fix error code in kexec_calculate_store_digests()
Message-ID: <20201210020508.GB2950@dhcp-128-65.nay.redhat.com>
References: <X9B03LFICh/QykQ6@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9B03LFICh/QykQ6@mwanda>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/20 at 10:55pm, Dan Carpenter wrote:
> Return -ENOMEM on allocation failure instead of returning success.
> 
> Fixes: a43cac0d9dc2 ("kexec: split kexec_file syscall code to kexec_file.c")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  kernel/kexec_file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b02086d70492..9570f380a825 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -735,8 +735,10 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  	sha_region_sz = KEXEC_SEGMENT_MAX * sizeof(struct kexec_sha_region);
>  	sha_regions = vzalloc(sha_region_sz);
> -	if (!sha_regions)
> +	if (!sha_regions) {
> +		ret = -ENOMEM;
>  		goto out_free_desc;
> +	}
>  
>  	desc->tfm   = tfm;
>  
> -- 
> 2.29.2
> 

Good catch, thanks!

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

