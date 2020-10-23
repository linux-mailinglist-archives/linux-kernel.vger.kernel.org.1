Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5900129765A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbgJWSBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:01:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54391 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754122AbgJWSBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:01:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id w23so1484173wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FOoNRIlK8tVk9G9mU4rHeaxRE409AWMqWNc43DoFZTI=;
        b=jHilHIUCvw8CgLC125N/NYOYDeS5fm093cRYdtosjc7l6BZEglg60w6IjOER0hBJnC
         a8eN7Wpmb1hu5ABYtLlGSUNCsMwtBGgeYvHrlQgrRzj4jaHtLXHkSKoaKYT2J3kK2BoR
         82OSo/jdNgs4Tb/BVJneWlRTmY6BFZO9ABeg5sYGc+tv5al6NlHsZx3rSupGEVNFRUnp
         3kHcmnv20IwajsQi9Uxk8+H1pgcYiIJTMLlF+EgJD1cHld9wRqSMbvQaZPPdnnqQoP4c
         iHdbTRCjL0qa+Bu1d1Os8ezMBDNETmc0ZjURbrFXnDm7HjoYIUABtA71XKww9is2g2jq
         zKQQ==
X-Gm-Message-State: AOAM532+p3g3aL50jDj6BqNmIVSw1QDj6HGYNiS2V7LBPLsTpryjyMVL
        Z1racAQc5G90h2ls861Fe3wVieOgi0U=
X-Google-Smtp-Source: ABdhPJznH3Ks3tjgn71i4pENBXnNM8JvrRyqwAx0NlW5n8cK5ihA/6xBD2I2jPlbzbwaXvfHerufMA==
X-Received: by 2002:a1c:1b46:: with SMTP id b67mr3681152wmb.82.1603476105288;
        Fri, 23 Oct 2020 11:01:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f912:ab69:c0c3:c2f7? ([2601:647:4802:9070:f912:ab69:c0c3:c2f7])
        by smtp.gmail.com with ESMTPSA id k203sm5045341wmb.37.2020.10.23.11.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 11:01:44 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-rdma: handle nvme completion data length
To:     zhenwei pi <pizhenwei@bytedance.com>, kbusch@kernel.org,
        hch@lst.de, axboe@fb.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201023065910.1358586-1-pizhenwei@bytedance.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d23e33e7-d545-2ad0-d163-5182dd5430b1@grimberg.me>
Date:   Fri, 23 Oct 2020 11:01:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023065910.1358586-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 9e378d0a0c01..2ecadd309f4a 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1767,6 +1767,21 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>   		return;
>   	}
>   
> +	/* received data length checking */
> +	if (unlikely(wc->byte_len < len)) {
> +		/* zero bytes message could be ignored */
> +		if (!wc->byte_len) {
> +			nvme_rdma_post_recv(queue, qe);
> +			return;
> +		}

Nothing in the spec defines zero-length messages, hence we cannot
support something that is not standard. If your array needs this,
please submit a TPAR to the NVMe TWG.
