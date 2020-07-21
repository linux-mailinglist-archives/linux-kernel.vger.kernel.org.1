Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCFC228433
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgGUPu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 11:50:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726029AbgGUPu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595346627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1eqkdT+65WSXffQEgvHX8BA45HzVx3nhgyMOFl0KCM=;
        b=UP7zCLnnpowVd6qJFEsLetQAX3K9eAXa2xNxOktoGGz4vv9a5TKhepCADUcl2fy3UIp3lp
        P8Dr3wfQst4Vh5DpmCAjzxAbWGIn0TZn6ZBJSYTgUA3MCci96srkwom2LIXzfqDifh1/pL
        QMfZ2UTEQtyEgqB6ynjpg6FQBXIUN/s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-7uoDVYEiMIudxce89YgGvw-1; Tue, 21 Jul 2020 11:50:23 -0400
X-MC-Unique: 7uoDVYEiMIudxce89YgGvw-1
Received: by mail-qv1-f71.google.com with SMTP id u1so12606745qvu.18
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=T1eqkdT+65WSXffQEgvHX8BA45HzVx3nhgyMOFl0KCM=;
        b=TQ7JiQw9gGmZscfqau25hVPP062xvD/Ea5980v2FXhJMlatXxkL+7abaFb0Wel54dv
         FMKU6PdXlpkvTivz6L/vOfW0YMH0hIOSgcz7s3Y1V5W4R24lLlUxMFR0sWdB5ubQhyCq
         khUuMEP/vLYV9/QwqyQD+g2aE28R1FuMzB8W1LhvVzF3eg+a03XdcocXlyjLXlB+BKP7
         SyqdZPGODUOczNRzKGh7j3ijEGyEBZlE68JkE5VPcvVNOHLEpJkUqXVF/eerQ1aIjwME
         5+eZsu3c6Po8+pMPxm8FrHcyZ6bJPy/DN0wScjP1SLpN6SAvF6gHDnzmh4t6Mgvl7zOU
         SClw==
X-Gm-Message-State: AOAM532CYQPJnWhK6p/CQE2XHXXChBH/DEWrXVGeL+th3LDG2KfYsRRm
        M3vY7m5CZFAVhZJLYPgadc31L4JiNVoamip9uVxS1v0UZ5ykXcKjBYb+mAkKfjcWxxBP7L/kNXW
        cevTV5KhSjgktqpkiZn5oqUnm
X-Received: by 2002:aed:2f46:: with SMTP id l64mr29601840qtd.1.1595346622841;
        Tue, 21 Jul 2020 08:50:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRfxmS1vh9brmkhzM4t8kBfNgHEn/slIPecHCsCE4ib2gN5E/VVud9VW0vl+hQQ4YSUuRZ2Q==
X-Received: by 2002:aed:2f46:: with SMTP id l64mr29601827qtd.1.1595346622609;
        Tue, 21 Jul 2020 08:50:22 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id m17sm202763qtm.92.2020.07.21.08.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:50:21 -0700 (PDT)
Message-ID: <4e90a54c61e3ecb19802d7ea811c58a51ac457ed.camel@redhat.com>
Subject: Re: [PATCH -next] drm/nouveau/kms/nvd9-: Fix file release memory
 leak
From:   Lyude Paul <lyude@redhat.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Date:   Tue, 21 Jul 2020 11:50:20 -0400
In-Reply-To: <20200721151701.51412-1-weiyongjun1@huawei.com>
References: <20200721151701.51412-1-weiyongjun1@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks!

On Tue, 2020-07-21 at 15:17 +0000, Wei Yongjun wrote:
> When using single_open() for opening, single_release() should be
> used instead of seq_release(), otherwise there is a memory leak.
> 
> Fixes: 12885ecbfe62 ("drm/nouveau/kms/nvd9-: Add CRC support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/crc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.c
> b/drivers/gpu/drm/nouveau/dispnv50/crc.c
> index f17fb6d56757..4971a1042415 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/crc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/crc.c
> @@ -706,6 +706,7 @@ static const struct file_operations
> nv50_crc_flip_threshold_fops = {
>  	.open = nv50_crc_debugfs_flip_threshold_open,
>  	.read = seq_read,
>  	.write = nv50_crc_debugfs_flip_threshold_set,
> +	.release = single_release,
>  };
>  
>  int nv50_head_crc_late_register(struct nv50_head *head)
> 
> 
> 
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

