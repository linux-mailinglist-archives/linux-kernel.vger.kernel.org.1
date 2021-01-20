Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032962FC9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbhATEHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:07:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728536AbhATEHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611115558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AywvAsEXQ6QfOLvyJDQnLT2m8SbrEucZASIOkJ5VmEo=;
        b=b56NOf/CVUFZ4mERJqJVJCaJOjXnbIIJH0A0Of1oeFKyCTorTQQ4vM0CJFMN/lcFaWNpg4
        XEaGP7wZuFQX8xAPLmlhMVQQACw39SaWSeLOQAvmDSvqtbEFM6+ftSKqpMEcYIphjWDCl8
        v4F/W5txKxnePb/uc7dX/XmTalTHU8o=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-pWITx6e6NEi6OF3VxbFVCw-1; Tue, 19 Jan 2021 23:05:56 -0500
X-MC-Unique: pWITx6e6NEi6OF3VxbFVCw-1
Received: by mail-pl1-f199.google.com with SMTP id c5so15558741plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 20:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AywvAsEXQ6QfOLvyJDQnLT2m8SbrEucZASIOkJ5VmEo=;
        b=r0P2ozEPCvVlI410GNSVU4YIH1xQNoYQH+HNOkuu+pbxQloQaMO49IuX2lQOd9SxPB
         1rLijCMF7yCplBIVWNtKFSRQvBOiI3P6tkZg2CNwqkIkdXKIJAM4mVg2eysZUgzROqP2
         5LQJD0/Fsn+BQJB9fQuzk8brAO3ie4NaKFU9Z9BqotB+Iceh/8qCnMm2yo9ofiJnBgr4
         QXObm+zKi9zWRgIYfB0C0ZvydP56Iry3ljGGVTfhXknsQ8DOwpF9rxSlKTdp9ZXgRA5V
         yo1504HZWTRYJ6YW9LoJT5hOVPaG/cIsKUdCaONb2OnVu7WjlBtBI6XUm4t93Pdif5oA
         fXOA==
X-Gm-Message-State: AOAM533JBC0g/ya2aJUw1v6CB8FzEqV0mqiDXjXJM1giLtp5qGhKdbaC
        Np05fw7QwueH0iIUJg4CLU4d8/Jw5qM4lUfMJC3227YcT5vCCfAkpjwhM99EdgxJKij6f1IwB+T
        corFlEdGGbmi6/qzL/jhtQcMu
X-Received: by 2002:a17:90b:e15:: with SMTP id ge21mr3208218pjb.185.1611115555707;
        Tue, 19 Jan 2021 20:05:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5B+6ZbSBY1zlOxNMrxAtroVhw7sy9A1mX+YBi99MEWpF7mf2MGUtrtchq7Pagy87yB/CGug==
X-Received: by 2002:a17:90b:e15:: with SMTP id ge21mr3208199pjb.185.1611115555492;
        Tue, 19 Jan 2021 20:05:55 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id kr9sm454363pjb.0.2021.01.19.20.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 20:05:55 -0800 (PST)
Date:   Wed, 20 Jan 2021 12:05:44 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 31/37] eros: use bio_init_fields in data
Message-ID: <20210120040544.GC2601261@xiangao.remote.csb>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
 <20210119050631.57073-32-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119050631.57073-32-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chaitanya,

(drop in-person Cc..)

On Mon, Jan 18, 2021 at 09:06:25PM -0800, Chaitanya Kulkarni wrote:

...it would be nice if you could update the subject line to
"erofs: use bio_init_fields xxxx"

The same to the following patch [RFC PATCH 32/37]... Also, IMHO,
these two patches could be merged as one patch if possible,
although just my own thoughts.

Thanks,
Gao Xiang

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  fs/erofs/data.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index ea4f693bee22..15f3a3f01fa3 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -220,10 +220,8 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>  
>  		bio = bio_alloc(GFP_NOIO, nblocks);
>  
> -		bio->bi_end_io = erofs_readendio;
> -		bio_set_dev(bio, sb->s_bdev);
> -		bio->bi_iter.bi_sector = (sector_t)blknr <<
> -			LOG_SECTORS_PER_BLOCK;
> +		bio_init_fields(bio, sb->s_bdev, (sector_t)blknr <<
> +			LOG_SECTORS_PER_BLOCK, NULL, erofs_readendio, 0, 0);
>  		bio->bi_opf = REQ_OP_READ | (ra ? REQ_RAHEAD : 0);
>  	}
>  
> -- 
> 2.22.1
> 

