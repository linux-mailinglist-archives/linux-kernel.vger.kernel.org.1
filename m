Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616032688FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgINKJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:09:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59827 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726239AbgINKJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600078180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BkR2wFIeHykLu1I53wtenqdg5Hq76Lrpn7XVwBMj+gs=;
        b=h/AlI4EQszCp+b7HA8ATV2XKtMiFsEkYEVPUf3XaoV4+7LQ03yHPDXTTc8dC5soXR0iZZ0
        E6i15n5FzQkUotdxW7WN4yHPxB3kfTLwdICqNfjN6qvZoPbiyBLCqV82fu5X/6YdbfR+OV
        dDBKa9Nnhx8DUdATcIFT6/GwOWZBIF4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-wsmwvYclNBSL7S_s5WwbkQ-1; Mon, 14 Sep 2020 06:09:39 -0400
X-MC-Unique: wsmwvYclNBSL7S_s5WwbkQ-1
Received: by mail-wr1-f70.google.com with SMTP id a12so6710380wrg.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BkR2wFIeHykLu1I53wtenqdg5Hq76Lrpn7XVwBMj+gs=;
        b=aBRsTuYNg84IhaD559ItVyav6z2c7yq3Kn+UJRdhf+9EXwN6DLWZs5cK8ebAx4ELxA
         ZpYHLS9l6KkixzAyFuxFNUVcQNnJT5AJBjQaUW9dsPe/ddw0Ae0EqHzVehFKiUc5M1K8
         PT4NfvQp003FqR9B0GEHbodOmpMVPrq+tiJXts3YAhx7UReCVDn3DUyc1BMD0d0neecZ
         wGD3tEiYzBsBH+eeTSpby2H0FmByBjiorDVXhyzaP5urn3+7DdvGecQnqcQo3CVkZ7+h
         oD3xYedikXcKkzC1uxHNmbOeNilADDcnuZRjj4VY0A4JhVXa1510l90KqqebOkqlVQTA
         ogQQ==
X-Gm-Message-State: AOAM530/XpRhXumRETtNVlayM7ONiJ5FdavZ9hfJKc8eMK6Ku4msGYy8
        IJ4G3IA8PHy6PqeT9MXVCG5+jJWFIJ3FQVRxkWOQs3eIMC1t/C8F/UtSeXlVgOpAz5ORLIe5zAH
        hKuL/J9jtVZkDLCwcipVSovaq
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr14987100wrs.274.1600078177976;
        Mon, 14 Sep 2020 03:09:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/ToRxQvrK1r21O6lGoGYyx4hT44wtlqfX0pqKBwFRdmqFFC82RD0AME4+CcGVMmoWPlEghg==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr14987077wrs.274.1600078177779;
        Mon, 14 Sep 2020 03:09:37 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 185sm19860640wma.18.2020.09.14.03.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 03:09:37 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: ** POTENTIAL FRAUD ALERT - RED HAT ** [PATCH 1/1] Drivers: hv: vmbus: Add timeout to vmbus_wait_for_unload
In-Reply-To: <1600026449-23651-1-git-send-email-mikelley@microsoft.com>
References: <1600026449-23651-1-git-send-email-mikelley@microsoft.com>
Date:   Mon, 14 Sep 2020 12:09:36 +0200
Message-ID: <87imcgllen.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> vmbus_wait_for_unload() looks for a CHANNELMSG_UNLOAD_RESPONSE message
> coming from Hyper-V.  But if the message isn't found for some reason,
> the panic path gets hung forever.  Add a timeout of 10 seconds to prevent
> this.

If I remember correctly, the problem I was observing back then was that
if CHANNELMSG_UNLOAD_RESPONSE is not delivered, Hyper-V won't respond to
the consequent CHANNELMSG_INITIATE_CONTACT/CHANNELMSG_REQUESTOFFERS
(don't remember exactly) so we either hang here or crash in the kdump
kernel because we can't find any devices. Maybe the problem was only
with some ancient Hyper-V versions or it was fixed.

>
> Fixes: 415719160de3 ("Drivers: hv: vmbus: avoid scheduling in interrupt context in vmbus_initiate_unload()")
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 591106c..1d44bb6 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -731,7 +731,7 @@ static void vmbus_wait_for_unload(void)
>  	void *page_addr;
>  	struct hv_message *msg;
>  	struct vmbus_channel_message_header *hdr;
> -	u32 message_type;
> +	u32 message_type, i;
>  
>  	/*
>  	 * CHANNELMSG_UNLOAD_RESPONSE is always delivered to the CPU which was
> @@ -741,8 +741,11 @@ static void vmbus_wait_for_unload(void)
>  	 * functional and vmbus_unload_response() will complete
>  	 * vmbus_connection.unload_event. If not, the last thing we can do is
>  	 * read message pages for all CPUs directly.
> +	 *
> +	 * Wait no more than 10 seconds so that the panic path can't get
> +	 * hung forever in case the response message isn't seen.
>  	 */
> -	while (1) {
> +	for (i = 0; i < 1000; i++) {
>  		if (completion_done(&vmbus_connection.unload_event))
>  			break;

LGTM,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

