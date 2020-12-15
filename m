Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C99E2DB032
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgLOPhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgLOPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:37:20 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDBEC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:36:40 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id r17so19554314ilo.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nwvzqg4DNCFbaTGtqZJz4eUDvbUI7tnGnDw1Mt8n1Hc=;
        b=SwKqC2JQIuA/AVz28p+N4Sa7h7QAnyjqh6FhXfhggD6F8yHWFs9M4tapegFiI+fK0a
         kXHgkIbbYan5zGhszMu8+lXo9NsDApQNWv7DNyTDIYrBJ+VmICdWYH8Gw4IOTf0LqjmO
         VDRTypyIfyMkua1h8lWC7ZpAjFxFVTw89c6Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nwvzqg4DNCFbaTGtqZJz4eUDvbUI7tnGnDw1Mt8n1Hc=;
        b=me2cHM5pnd6Ev6M4AYuiuz4isN7yTZUk/zSE5tfARLU43tSzaxxko6qI1f/L+V0A1I
         h0Qy4LqKDdIMs8//QHJ4Xn69VArByd/oCLBduiv2K3tVeYPH3Vy4UFty7FVpENrE4kES
         PTejj/x/oZQ0/edns708FzzuFNaE3biXMx4cookHSUCTJjpwpve9qihP7q7bX9Dlo/VB
         x+2mOOds/v9ZCFqq8IlnanIaa4mEc0BS7ptDn4eqbtb7Eydga/1rbVUAZ3/AsYOxPr40
         dsz8rc7MKdoFv3YhPdpCg+XGOGo1xzdCgyXhI+ynvhhK/6v/LwalfdsZlj5qvvwA8kR3
         onZA==
X-Gm-Message-State: AOAM531eWCdiLQHjLcVyivnMPgF/UqBit20L7l78relGy8zciJwBnSZ0
        wDzP87s4UjE2oO1FKnJtUkW47SiE2xcqyg==
X-Google-Smtp-Source: ABdhPJxf7307E7HadOZKYWoHMgHe3c7S7rXCUHjQ3tl1bQ8c0DQ5141glwS9FJRPfqg4/5TxiOagBA==
X-Received: by 2002:a05:6e02:1148:: with SMTP id o8mr42290880ill.174.1608046599165;
        Tue, 15 Dec 2020 07:36:39 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id t21sm14175564ild.86.2020.12.15.07.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 07:36:38 -0800 (PST)
Subject: Re: [PATCH] greybus: remove h from printk format specifier
To:     trix@redhat.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201215145306.1901598-1-trix@redhat.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <430f0e9b-f85d-f85d-d8ea-418794d82917@ieee.org>
Date:   Tue, 15 Dec 2020 09:36:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201215145306.1901598-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/20 8:53 AM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> See Documentation/core-api/printk-formats.rst.
> h should no longer be used in the format specifier for printk.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/greybus/greybus_trace.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/greybus/greybus_trace.h b/drivers/greybus/greybus_trace.h
> index 1bc9f1275c65..616a3bd61aa6 100644
> --- a/drivers/greybus/greybus_trace.h
> +++ b/drivers/greybus/greybus_trace.h
> @@ -40,7 +40,7 @@ DECLARE_EVENT_CLASS(gb_message,
>   		__entry->result = message->header->result;
>   	),
>   
> -	TP_printk("size=%hu operation_id=0x%04x type=0x%02x result=0x%02x",
> +	TP_printk("size=%u operation_id=0x%04x type=0x%02x result=0x%02x",
>   		  __entry->size, __entry->operation_id,
>   		  __entry->type, __entry->result)
>   );
> @@ -317,7 +317,7 @@ DECLARE_EVENT_CLASS(gb_interface,
>   		__entry->mode_switch = intf->mode_switch;
>   	),
>   
> -	TP_printk("intf_id=%hhu device_id=%hhu module_id=%hhu D=%d J=%d A=%d E=%d M=%d",
> +	TP_printk("intf_id=%u device_id=%u module_id=%u D=%d J=%d A=%d E=%d M=%d",
>   		__entry->id, __entry->device_id, __entry->module_id,
>   		__entry->disconnected, __entry->ejected, __entry->active,
>   		__entry->enabled, __entry->mode_switch)
> @@ -391,7 +391,7 @@ DECLARE_EVENT_CLASS(gb_module,
>   		__entry->disconnected = module->disconnected;
>   	),
>   
> -	TP_printk("hd_bus_id=%d module_id=%hhu num_interfaces=%zu disconnected=%d",
> +	TP_printk("hd_bus_id=%d module_id=%u num_interfaces=%zu disconnected=%d",
>   		__entry->hd_bus_id, __entry->module_id,
>   		__entry->num_interfaces, __entry->disconnected)
>   );
> 

