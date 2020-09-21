Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20BB27295A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgIUPDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:03:44 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:53376 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIUPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:03:43 -0400
X-Greylist: delayed 1617 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 11:03:43 EDT
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1kKMvp-0001Ev-QO; Mon, 21 Sep 2020 14:36:43 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1kKMvm-00006j-J2; Mon, 21 Sep 2020 15:36:41 +0100
Subject: Re: [PATCH] um: vector: Use GFP_ATOMIC under spin lock
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <1592544007-2751-1-git-send-email-yangtiezhu@loongson.cn>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <04be37fc-c8cb-f506-20a5-97467b638069@cambridgegreys.com>
Date:   Mon, 21 Sep 2020 15:36:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1592544007-2751-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/06/2020 06:20, Tiezhu Yang wrote:
> Use GFP_ATOMIC instead of GFP_KERNEL under spin lock to fix possible
> sleep-in-atomic-context bugs.
> 
> Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/um/drivers/vector_kern.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 8735c46..555203e 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1403,7 +1403,7 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
>   		kfree(vp->bpf->filter);
>   		vp->bpf->filter = NULL;
>   	} else {
> -		vp->bpf = kmalloc(sizeof(struct sock_fprog), GFP_KERNEL);
> +		vp->bpf = kmalloc(sizeof(struct sock_fprog), GFP_ATOMIC);
>   		if (vp->bpf == NULL) {
>   			netdev_err(dev, "failed to allocate memory for firmware\n");
>   			goto flash_fail;
> @@ -1415,7 +1415,7 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
>   	if (request_firmware(&fw, efl->data, &vdevice->pdev.dev))
>   		goto flash_fail;
>   
> -	vp->bpf->filter = kmemdup(fw->data, fw->size, GFP_KERNEL);
> +	vp->bpf->filter = kmemdup(fw->data, fw->size, GFP_ATOMIC);
>   	if (!vp->bpf->filter)
>   		goto free_buffer;
>   
> 
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
