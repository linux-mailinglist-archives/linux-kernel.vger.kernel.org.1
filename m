Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05B32509B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 22:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHXUAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 16:00:18 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52834 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:00:15 -0400
Received: by mail-pj1-f68.google.com with SMTP id z18so1669pjr.2;
        Mon, 24 Aug 2020 13:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oLMQNel22K0XPYFA+YJ2r/SjoNNOFVt/AXP7lcsHH6E=;
        b=QBwKwdf3vDcZM4RwiZqx+hCx9YXWINCwPZgpwzLH6Qo8wX+v9VMunMqLfJ+yXQD8L6
         4rJiQXV3qH6PZ47pMWB19y7yEz5U9xCablAz/tX1m/4nlab41/R3jSaYr30MHWamGfEy
         zeybrj+GsofiGSy3K+KND8TGOeyS+1FKp1QNMlBae/YXUXO+gml7/jaGjhNRq+KChJES
         S/PF8wXeVfWToflwcmem31EW2JHZK9xIyEFvF3EmZRH3mxBn466e6AtyptCIKe2sZlfn
         SNKut+gtgU1p2l/qpXaTjI62Tg7jhAYgABvK6mXlKHkSMEF/HoPA1zfDHbgx9DbX2KRL
         LBNw==
X-Gm-Message-State: AOAM531ZV/OMElb9UTEtbwbXxzXcBDOBBPC1Otvx0PYshQoSSekqLa8f
        pSrUtsk9VEPYecvFpFbHM+C2IksWqOZxAw==
X-Google-Smtp-Source: ABdhPJxkXtPnQIfoqZclGU1KUvAU1SWFGHzEauVD8GGFzTLF4PgIbdKtItlflQtR0lu+x3wVtk9pGg==
X-Received: by 2002:a17:90a:fe82:: with SMTP id co2mr755235pjb.216.1598299213590;
        Mon, 24 Aug 2020 13:00:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d? ([2601:647:4802:9070:cda6:bf68:c972:645d])
        by smtp.gmail.com with ESMTPSA id r186sm13677304pfr.162.2020.08.24.13.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 13:00:12 -0700 (PDT)
Subject: Re: [PATCH] nvmet-fc: Fix a missed _irqsave version of spin_lock in
 'nvmet_fc_fod_op_done()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        james.smart@broadcom.com, hch@lst.de, chaitanya.kulkarni@wdc.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <823cd0d7-1688-7d11-1e9b-2de29b6065a6@grimberg.me>
Date:   Mon, 24 Aug 2020 13:00:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The way 'spin_lock()' and 'spin_lock_irqsave()' are used is not consistent
> in this function.
> 
> Use 'spin_lock_irqsave()' also here, as there is no guarantee that
> interruptions are disabled at that point, according to surrounding code.
> 
> Fixes: a97ec51b37ef ("nvmet_fc: Rework target side abort handling")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not tested, only based on what looks logical to me according to
> surrounding code
> ---
>   drivers/nvme/target/fc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 55bafd56166a..e6861cc10e7d 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -2342,9 +2342,9 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
>   			return;
>   		if (fcpreq->fcp_error ||
>   		    fcpreq->transferred_length != fcpreq->transfer_length) {
> -			spin_lock(&fod->flock);
> +			spin_lock_irqsave(&fod->flock, flags);
>   			fod->abort = true;
> -			spin_unlock(&fod->flock);
> +			spin_unlock_irqrestore(&fod->flock, flags);
>   
>   			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
>   			return;
> 

James, can I get a reviewed-by from you on this?
