Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1A72ABEEF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgKIOlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731266AbgKIOlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:41:45 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE92C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 06:41:45 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v11so5695289qtq.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 06:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-cmu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rj45Fl4knXg7ZqbCRRGb045rlO8nSTYXXc/C/d/ncxQ=;
        b=L/nh18t98ay/tyYAxJGHlg0yLJnzRTaMN7PcW/qnFEOetP0w7neEhlvPNinGRuyOtZ
         qyPNwHl+vy9PpwYCCImYH4N8ShuV6Na3LdBh7ZkahRJUUDRKmkYLulZxmzkQJkDbQ0h5
         4F6IXrgO0kBgV7GQUZ2z8almkINFW8D/5TEKzuj8USDEKp7okU2fUKlLVX5TifB39iqK
         BUOdrN8qO255MnjzFd/iuQBT8nt3yNRjgGXDAUX3lRRxP1wMLcjpAsVqOsRZjgARphKf
         RCH+Eb2ZZV3A/U4sFEYak6ME/NWur3d+na6OVzq6W6plrGo5TxYe5W86b/6F81dkgZHE
         GfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rj45Fl4knXg7ZqbCRRGb045rlO8nSTYXXc/C/d/ncxQ=;
        b=B14HXNFf8J+tQrWuO8ZZPftD6I84mJZePX9ZYRlxs6tQKLJvmfUPnQmCcayti+s6jw
         5ScNAGCLSEyI4wCuDQaNRCCSHmYV4W5ZTE3MxQHroIY7V2aIFYPJX8V+YRocYkOILwlm
         nCchE0yShB9ohXOBcDQdimsuayiIu/v1nRvxJS3T60uabKtOPpT20gbHqErvGcecI3DV
         yAmdH1vMnT9bjPVjsIeCFL2u5oh0ZfYKLJFl7t+hNfZ7JBxhaSZmSdM9oRN+rG9JCKoG
         iBz66IIAmEoBeL7W8QGEsYOd93+5lGjlc0uuKxIsH7cnHdpNOiAJqWDJxVP+PR09g4Bj
         SdwA==
X-Gm-Message-State: AOAM531/+EpiydMZZQ2hkUM9EzrEJXyiEqNxrQMNku3n1Y8fGMrF/jNn
        zd9dFX6pPUaM7GaIFaSRFIkLfv+SdIlCAg==
X-Google-Smtp-Source: ABdhPJwHFl4OQZruGUcXIv4cB5VZ4kXoaMBeL9hGOnabcMHi3XgUiLUKt2NEm9bYudDMbAQGRzTjsg==
X-Received: by 2002:aed:2d02:: with SMTP id h2mr12765610qtd.96.1604932904723;
        Mon, 09 Nov 2020 06:41:44 -0800 (PST)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id l3sm4303441qkj.114.2020.11.09.06.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 06:41:43 -0800 (PST)
Date:   Mon, 9 Nov 2020 09:41:41 -0500
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/coda: remove useless varible 'err'
Message-ID: <20201109144141.63uvxmjs2sokrqt2@cs.cmu.edu>
References: <1604674628-52464-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1604674628-52464-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:57:08PM +0800, Alex Shi wrote:
> The variable is unused and cause gcc warning:
> fs/coda/file.c:241:6: warning: variable ‘err’ set but not used
> [-Wunused-but-set-variable]
> So let's remove it.
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Jan Harkes <jaharkes@cs.cmu.edu> 
> Cc: coda@cs.cmu.edu 
> Cc: codalist@coda.cs.cmu.edu 
> Cc: linux-kernel@vger.kernel.org 

Looks good to me.

Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>

> ---
>  fs/coda/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/coda/file.c b/fs/coda/file.c
> index 128d63df5bfb..31a7ba383cb2 100644
> --- a/fs/coda/file.c
> +++ b/fs/coda/file.c
> @@ -238,11 +238,10 @@ int coda_release(struct inode *coda_inode, struct file *coda_file)
>  	struct coda_file_info *cfi;
>  	struct coda_inode_info *cii;
>  	struct inode *host_inode;
> -	int err;
>  
>  	cfi = coda_ftoc(coda_file);
>  
> -	err = venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
> +	venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
>  			  coda_flags, coda_file->f_cred->fsuid);
>  
>  	host_inode = file_inode(cfi->cfi_container);
> -- 
> 1.8.3.1
> 
> 
