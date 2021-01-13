Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3032F4EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbhAMPfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:35:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbhAMPfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610552054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=99Kv47P8Md/c/Sq3Lue6GRbaUcZvLDNFfpTUMeiuEkE=;
        b=VttnT5xXpCMVNUU72G26519610ztF4uzZJchBNf8LO/JJwpej5NXUnjCVH9XsUCklzSYTw
        tWBW8RQ80cCqnR3UPrse7N6+pExzItrQrS9v8oZp4B+Ofr7S4f355hE8yG87N6wwl2CINO
        z4E77nU+CotZ8yplRCmuIg5YVd1lBUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-WlnM_tJ8Ov2tlae2VO9mrw-1; Wed, 13 Jan 2021 10:34:12 -0500
X-MC-Unique: WlnM_tJ8Ov2tlae2VO9mrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9CA0873085;
        Wed, 13 Jan 2021 15:34:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.122])
        by smtp.corp.redhat.com (Postfix) with SMTP id CDE7260D08;
        Wed, 13 Jan 2021 15:34:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Jan 2021 16:34:10 +0100 (CET)
Date:   Wed, 13 Jan 2021 16:34:08 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Marcus Huewe <suse-tux@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: Remove redundant code in ptrace_attach
Message-ID: <20210113153408.GA26690@redhat.com>
References: <53924ce0d6f0c15575b5d7dbef2a8038bc27b4ed.1610544906.git.suse-tux@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53924ce0d6f0c15575b5d7dbef2a8038bc27b4ed.1610544906.git.suse-tux@gmx.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Oleg Nesterov <oleg@redhat.com>


On 01/13, Marcus Huewe wrote:
>
> In case of a PTRACE_SEIZE request, the PT_SEIZED flag is always set
> at the beginning of ptrace_attach. Hence, there is no need to set
> it again (neither "flags" nor "seize" are modified in between/after
> the initial assignment).
> 
> Signed-off-by: Marcus Huewe <suse-tux@gmx.de>
> ---
>  kernel/ptrace.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 61db50f7ca86..059fce2ad53c 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -402,8 +402,6 @@ static int ptrace_attach(struct task_struct *task, long request,
>  	if (task->ptrace)
>  		goto unlock_tasklist;
> 
> -	if (seize)
> -		flags |= PT_SEIZED;
>  	task->ptrace = flags;
> 
>  	ptrace_link(task, current);
> --
> 2.29.2
> 

