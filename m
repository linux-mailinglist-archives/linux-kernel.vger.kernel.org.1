Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDEF2D87D7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437274AbgLLQOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 11:14:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436489AbgLLQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 11:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607789587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJHtWEAaq9mILAH7ZOu8et1GbzEeBq8r2vbaNO9BgGg=;
        b=D84HDMRw7Me/scjOnhXWwy8pH9jilqmsTE1iogvhaN/90GEhqqb53yoYqcSv3YjtgHA9zR
        XinrGP/vIgWxlKYVjjyvB0NzqdiELH2mwVf8D2AjEpGRBc7ffuavSVd0iO75jaylGFRQLq
        IZ9LFFp29dncPnaFjUobyJqAnClP+4w=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-2fe2pk4IOr6gaZoToaqNMQ-1; Sat, 12 Dec 2020 11:13:05 -0500
X-MC-Unique: 2fe2pk4IOr6gaZoToaqNMQ-1
Received: by mail-pl1-f200.google.com with SMTP id c8so6802359plo.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 08:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PJHtWEAaq9mILAH7ZOu8et1GbzEeBq8r2vbaNO9BgGg=;
        b=cZp3DhCJPYOvFMsvUkOfJPMQNvF4vtqSdxE1RIKYAp9BCnT41x+9ovFmFYxgDP4O2+
         j6lPkpyXOBVJgh7Amir1+fe8887TNQZ2k+vCs967HKxAe+jFp00VsTXdISJ4+unNaYLd
         0Juiw/avW/2ER5yiw22ctJtFG9NvEn+VZnBcu4rl4IVneTHb5IlLkJT5kQVMNOKtpnxJ
         3lyRyWiiM+7k2q5DMFExOyA7ns5Qc055Q3imV+MFnKB+JDoJQHhidn11xu9B98wdV1mZ
         z+90FJAKUt1QuItsd3s7hUwR+pS1U0grZmjwnjp9wAIyGQP0Ejoof8iEukuvHkdUvb9P
         B5RQ==
X-Gm-Message-State: AOAM5330UWj6G1xuznrKE64NZgWWNcjvGKdgqzMYZVCyw3DsAfgnv8dH
        BMIdYOQYA862LPOFPenl+K6U78ODdesxZ/g7wU8IpmGfJ0c0D+0iWdd2//avYiB/6I5kPRJqfgs
        GMxXi3/2AcZ/agOGJBAhaxNJb
X-Received: by 2002:a17:902:b496:b029:da:d356:be8c with SMTP id y22-20020a170902b496b02900dad356be8cmr15659234plr.56.1607789584335;
        Sat, 12 Dec 2020 08:13:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxh+RUJIV50IX1HR5B62wzsB/9XVzjJcLZ6EHjfG9xO+P+UCA20WZh1fLRq0/TdAH+2B+Z3cw==
X-Received: by 2002:a17:902:b496:b029:da:d356:be8c with SMTP id y22-20020a170902b496b02900dad356be8cmr15659214plr.56.1607789584018;
        Sat, 12 Dec 2020 08:13:04 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k14sm14479519pfp.132.2020.12.12.08.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:13:03 -0800 (PST)
Date:   Sun, 13 Dec 2020 00:12:53 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     chenlei0x@gmail.com
Cc:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lei Chen <lennychen@tencent.com>
Subject: Re: [PATCH] xfs: clean code for setting bma length in xfs_bmapi_write
Message-ID: <20201212161253.GA94979@xiangao.remote.csb>
References: <1607777297-22269-1-git-send-email-lennychen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1607777297-22269-1-git-send-email-lennychen@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 08:48:17PM +0800, chenlei0x@gmail.com wrote:
> From: Lei Chen <lennychen@tencent.com>
> 
> xfs_bmapi_write may need alloc blocks when it encounters a hole
> or delay extent. When setting bma.length, it does not need comparing
> MAXEXTLEN and the length that the caller wants, because
> xfs_bmapi_allocate will handle every thing properly for bma.length.
> 
> Signed-off-by: Lei Chen <lennychen@tencent.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index dcf56bc..e1b6ac6 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -4417,18 +4417,7 @@ struct xfs_iread_state {
>  			bma.wasdel = wasdelay;
>  			bma.offset = bno;
>  			bma.flags = flags;
> -
> -			/*
> -			 * There's a 32/64 bit type mismatch between the
> -			 * allocation length request (which can be 64 bits in
> -			 * length) and the bma length request, which is
> -			 * xfs_extlen_t and therefore 32 bits. Hence we have to
> -			 * check for 32-bit overflows and handle them here.
> -			 */
> -			if (len > (xfs_filblks_t)MAXEXTLEN)
> -				bma.length = MAXEXTLEN;
> -			else
> -				bma.length = len;
> +			bma.length = len;

After refering to the definition of struct xfs_bmalloca, so I think
bma.length is still a xfs_extlen_t ===> uint32_t, so I'm afraid the commit
a99ebf43f49f ("xfs: fix allocation length overflow in xfs_bmapi_write()")

and the reason for adding this is still valid for now?

Thanks,
Gao Xiang

