Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3812D7982
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390295AbgLKPfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:35:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729222AbgLKPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607700813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GN/jGqY3PNLZJDIbdHFFWelqF/aTkIMzuDGfs5vRac=;
        b=gEzCuFrKWvqVaGYgtVACLQN/OLR1JbzxiU5SjdtuXs8zmPXQGJyJ6Tz+B3mq+2DNeyY3vm
        tq8sQ4KSiFA6mrZA9dyypDPQDiFwrLhfQtC5+AX+cEQUO13Bzf6Z3buPnjCFEGwN5UofND
        aEkb54EeVBb6QDBjuNRNNiWef9K++CI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-prSWP4lWO5ucgmhTvm7usA-1; Fri, 11 Dec 2020 10:33:32 -0500
X-MC-Unique: prSWP4lWO5ucgmhTvm7usA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A70211006C80;
        Fri, 11 Dec 2020 15:33:30 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B82E310023B2;
        Fri, 11 Dec 2020 15:33:23 +0000 (UTC)
Date:   Fri, 11 Dec 2020 10:33:21 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     paul@paul-moore.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] kernel/audit: convert comma to semicolon
Message-ID: <20201211153321.GF2015948@madcap2.tricolour.ca>
References: <20201211084254.2038-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211084254.2038-1-zhengyongjun3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-11 16:42, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 68cee3bc8cfe..c8497115be35 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2282,7 +2282,7 @@ static void audit_log_set_loginuid(kuid_t koldloginuid, kuid_t kloginuid,
>  
>  	uid = from_kuid(&init_user_ns, task_uid(current));
>  	oldloginuid = from_kuid(&init_user_ns, koldloginuid);
> -	loginuid = from_kuid(&init_user_ns, kloginuid),
> +	loginuid = from_kuid(&init_user_ns, kloginuid);

Nice catch.  That went unnoticed through 3 patches, the last two mine...
Not quite sure why no compiler complained about it...

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

>  	tty = audit_get_tty();
>  
>  	audit_log_format(ab, "pid=%d uid=%u", task_tgid_nr(current), uid);

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

