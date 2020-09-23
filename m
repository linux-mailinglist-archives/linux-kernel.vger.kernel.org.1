Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B135274EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgIWCKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:10:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726743AbgIWCKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600827001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8GcEVeOS7v7gEW8EEmjGvOVzfnPTOFo568Fr9tVaI8=;
        b=M+XB/cbvO273SXsFM/gHrslbep7spG8drEdWObHaQNiDOcjyF2sAjYlF7yVDrlD8hV/Ik7
        jTaHBz60/rNFf4yAtBj5p1m+5U+7e4smy07rlQqBXMgMUloWPV3M81n2xe5XA2Kgey26sI
        Gd/TABDekiNhTG0UL131CCKuznabe+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-HSCSr3HpMXaLZxSxWpXXjw-1; Tue, 22 Sep 2020 22:09:45 -0400
X-MC-Unique: HSCSr3HpMXaLZxSxWpXXjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49CEF87309E;
        Wed, 23 Sep 2020 02:09:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 047415576A;
        Wed, 23 Sep 2020 02:09:41 +0000 (UTC)
Subject: Re: [PATCH] docs: admin-guide: update kdump documentation due to
 change of crash URL
From:   lijiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhe@redhat.com, corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, vgoyal@redhat.com
References: <20200918080958.19841-1-lijiang@redhat.com>
Message-ID: <e07a5f8a-0f9c-c1c3-61fc-3fc0602e6e37@redhat.com>
Date:   Wed, 23 Sep 2020 10:09:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200918080958.19841-1-lijiang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020年09月18日 16:09, Lianbo Jiang 写道:
> Since crash utility has moved to github, the original URL is no longer
                       ^
                      has been moved to github

Because of the above mistake, I'd like to correct it and reply it with the v2.

Thanks.

> available. Let's update it accordingly.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 2da65fef2a1c..75a9dd98e76e 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -509,9 +509,12 @@ ELF32-format headers using the --elf32-core-headers kernel option on the
>  dump kernel.
>  
>  You can also use the Crash utility to analyze dump files in Kdump
> -format. Crash is available on Dave Anderson's site at the following URL:
> +format. Crash is available at the following URL:
>  
> -   http://people.redhat.com/~anderson/
> +   https://github.com/crash-utility/crash
> +
> +Crash document can be found at:
> +   https://crash-utility.github.io/
>  
>  Trigger Kdump on WARN()
>  =======================
> 

