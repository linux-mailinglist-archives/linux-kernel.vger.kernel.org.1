Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9665C2B7053
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgKQUlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:41:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgKQUle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605645693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Di4tTbh8MPzsggNHAaxtebSNsI/DCl4fPbQAE9tQwoo=;
        b=Q0AH+dmLIml4JkgbkkopRdl2popj6uM42d/6Y/kvtQTjz98VDyAUMw2sKqpYE79d5Skp+P
        Pcuh/IpsMv5uHqnRsl3fa5ljupT+rzUR3dDyeAwV6GDSanR+TJEcOA97OjNNajoIXWTtH1
        ZgjB1Z0SWAPLLKLq9BrkimEgYD1pH2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-GI0dqaQ1O1CFcS8cv966qg-1; Tue, 17 Nov 2020 15:41:31 -0500
X-MC-Unique: GI0dqaQ1O1CFcS8cv966qg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAD97100748B;
        Tue, 17 Nov 2020 20:41:30 +0000 (UTC)
Received: from [10.10.112.190] (ovpn-112-190.rdu2.redhat.com [10.10.112.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48B1B1759F;
        Tue, 17 Nov 2020 20:41:30 +0000 (UTC)
Subject: Re: [PATCH] print_req_error: Use dev_err_ratelimited
From:   Tony Asleson <tasleson@redhat.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201026160515.542586-1-tasleson@redhat.com>
Organization: Red Hat
Message-ID: <24d6bc43-d50a-7845-6fcc-ed65b779242e@redhat.com>
Date:   Tue, 17 Nov 2020 14:41:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026160515.542586-1-tasleson@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any thoughts on this?

Getting all the error paths to go through dev_printk is
quite useful.


On 10/26/20 11:05 AM, Tony Asleson wrote:
> Replace printk_ratelimited with dev_err_ratelimited which
> adds dev_printk meta data. This is used by journald to
> add disk ID information to the journal entry.
> 
> Signed-off-by: Tony Asleson <tasleson@redhat.com>
> ---
>  block/blk-core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 10c08ac50697..ee5d63e54a11 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -216,16 +216,18 @@ EXPORT_SYMBOL_GPL(blk_status_to_errno);
>  static void print_req_error(struct request *req, blk_status_t status,
>  		const char *caller)
>  {
> +	struct device *dev;
>  	int idx = (__force int)status;
>  
>  	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
>  		return;
>  
> -	printk_ratelimited(KERN_ERR
> -		"%s: %s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
> +	dev = req->rq_disk ? disk_to_dev(req->rq_disk) : NULL;
> +
> +	dev_err_ratelimited(dev,
> +		"%s: %s error, sector %llu op 0x%x:(%s) flags 0x%x "
>  		"phys_seg %u prio class %u\n",
>  		caller, blk_errors[idx].name,
> -		req->rq_disk ? req->rq_disk->disk_name : "?",
>  		blk_rq_pos(req), req_op(req), blk_op_str(req_op(req)),
>  		req->cmd_flags & ~REQ_OP_MASK,
>  		req->nr_phys_segments,
> 
> base-commit: bbf5c979011a099af5dc76498918ed7df445635b
> 

