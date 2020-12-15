Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76F2DAE3E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgLONoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:44:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgLONoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608039762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGrSzYbdNZZ1+G29igFKQHJ2u19ucKb6OhDvDyYMVwc=;
        b=H0r2KAgEdlBXd3bqniUIuFZNtiSTj0RwWwE6KIOozRpoGW3CP9t2FG7lirGVTnTpuk0sxe
        dNVkQy/KMEfwHUHBGvnJf5v2anWEV3+JiW9gHCRJic6ZlmHo68t9sj1q9+5RWlxNTovLDw
        t9eog94fCnj7JBPRJMxTB/+v8Ju/bk8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-kDEzAUWtP6WYK6hKB3MZtA-1; Tue, 15 Dec 2020 08:42:41 -0500
X-MC-Unique: kDEzAUWtP6WYK6hKB3MZtA-1
Received: by mail-ed1-f70.google.com with SMTP id u18so9998394edy.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 05:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pGrSzYbdNZZ1+G29igFKQHJ2u19ucKb6OhDvDyYMVwc=;
        b=Did26HAlgRgCy5huJOclmWmmo1wZ507dJDuaFBarrKHtd5CRXbCed3WLTQxW7XHTBV
         KEpvOXKvufk/GBdkMWJcFXdQtwc0U7GkHxwAsenZdNJI+hbDcmftZ3WU5T5wbJLuFRnO
         2jXDLoL0EKmwLKIi9m51lTdF08tOstJqCrZiwi2UJO4u2/7FUPdqRwiQtjHStEF2b98U
         OnSN0P6M63Jql0O8ywsfF6zm2Z4d86XJthEhqcWoDSrMnZWgQbxZvGp15WJ1bOaQoqUN
         knhaSZKL1kFcFuaK2RSVYjFEQs5hFauNlt/wCgZAaqCQ1eluMUPsqkXuIVvFQNW2KlH8
         onmg==
X-Gm-Message-State: AOAM531EwS//aLAclTW3pz4/JzFxKUACGuUcAAcoQzvWARCwyxlf6PSF
        gqVoUJV/7EP/qZkk78/o4EA8Tvy3YoOVaNmnKOB4hgutVZyaG2jqaWcqOofZXxcaoW2HLJkI0bb
        8UnnRSFF/RRTOtgGgseeqvKok
X-Received: by 2002:a50:9b58:: with SMTP id a24mr2431651edj.22.1608039759908;
        Tue, 15 Dec 2020 05:42:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzh0pkhjxlNYWjeE1lMCU0uFaNcSBzxclbFbiJ5wJjUGJnr+bwASuGoLApDJ8DpPqWxam0KJg==
X-Received: by 2002:a50:9b58:: with SMTP id a24mr2431636edj.22.1608039759679;
        Tue, 15 Dec 2020 05:42:39 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id h16sm1378289eji.110.2020.12.15.05.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 05:42:38 -0800 (PST)
Subject: Re: [PATCH v2 2/9] platform/surface: aggregator: Add control packet
 allocation caching
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastn?= =?UTF-8?Q?ik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201203212640.663931-3-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <879bdec2-3efd-8eac-c19e-cd8282367bef@redhat.com>
Date:   Tue, 15 Dec 2020 14:42:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203212640.663931-3-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/3/20 10:26 PM, Maximilian Luz wrote:
> Surface Serial Hub communication is, in its core, packet based. Each
> sequenced packet requires to be acknowledged, via an ACK-type control
> packet. In case invalid data has been received by the driver, a NAK-type
> (not-acknowledge/negative acknowledge) control packet is sent,
> triggering retransmission.
> 
> Control packets are therefore a core communication primitive and used
> frequently enough (with every sequenced packet transmission sent by the
> embedded controller, including events and request responses) that it may
> warrant caching their allocations to reduce possible memory
> fragmentation.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/platform/surface/aggregator/core.c    | 27 ++++++++++-
>  .../surface/aggregator/ssh_packet_layer.c     | 47 +++++++++++++++----
>  .../surface/aggregator/ssh_packet_layer.h     |  3 ++
>  3 files changed, 67 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
> index ec6c7f40ad36..77bc4c87541b 100644
> --- a/drivers/platform/surface/aggregator/core.c
> +++ b/drivers/platform/surface/aggregator/core.c
> @@ -774,7 +774,32 @@ static struct serdev_device_driver ssam_serial_hub = {
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
> -module_serdev_device_driver(ssam_serial_hub);
> +
> +
> +/* -- Module setup. --------------------------------------------------------- */
> +
> +static int __init ssam_core_init(void)
> +{
> +	int status;
> +
> +	status = ssh_ctrl_packet_cache_init();
> +	if (status)
> +		return status;
> +
> +	status = serdev_device_driver_register(&ssam_serial_hub);
> +	if (status)
> +		ssh_ctrl_packet_cache_destroy();
> +
> +	return status;
> +}
> +module_init(ssam_core_init);
> +
> +static void __exit ssam_core_exit(void)
> +{
> +	serdev_device_driver_unregister(&ssam_serial_hub);
> +	ssh_ctrl_packet_cache_destroy();
> +}
> +module_exit(ssam_core_exit);
> 
>  MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
>  MODULE_DESCRIPTION("Subsystem and Surface Serial Hub driver for Surface System Aggregator Module");
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> index 237d28c90e4b..8bc19837cde0 100644
> --- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> @@ -302,24 +302,53 @@ void ssh_packet_init(struct ssh_packet *packet, unsigned long type,
>  	packet->ops = ops;
>  }
> 
> +static struct kmem_cache *ssh_ctrl_packet_cache;
> +
> +/**
> + * ssh_ctrl_packet_cache_init() - Initialize the control packet cache.
> + */
> +int ssh_ctrl_packet_cache_init(void)
> +{
> +	const unsigned int size = sizeof(struct ssh_packet) + SSH_MSG_LEN_CTRL;
> +	const unsigned int align = __alignof__(struct ssh_packet);
> +	struct kmem_cache *cache;
> +
> +	cache = kmem_cache_create("ssam_ctrl_packet", size, align, 0, NULL);
> +	if (!cache)
> +		return -ENOMEM;
> +
> +	ssh_ctrl_packet_cache = cache;
> +	return 0;
> +}
> +
> +/**
> + * ssh_ctrl_packet_cache_destroy() - Deinitialize the control packet cache.
> + */
> +void ssh_ctrl_packet_cache_destroy(void)
> +{
> +	kmem_cache_destroy(ssh_ctrl_packet_cache);
> +	ssh_ctrl_packet_cache = NULL;
> +}
> +
>  /**
> - * ssh_ctrl_packet_alloc() - Allocate control packet.
> + * ssh_ctrl_packet_alloc() - Allocate packet from control packet cache.
>   * @packet: Where the pointer to the newly allocated packet should be stored.
>   * @buffer: The buffer corresponding to this packet.
>   * @flags:  Flags used for allocation.
>   *
> - * Allocates a packet and corresponding transport buffer. Sets the packet's
> - * buffer reference to the allocated buffer. The packet must be freed via
> - * ssh_ctrl_packet_free(), which will also free the corresponding buffer. The
> - * corresponding buffer must not be freed separately. Intended to be used with
> - * %ssh_ptl_ctrl_packet_ops as packet operations.
> + * Allocates a packet and corresponding transport buffer from the control
> + * packet cache. Sets the packet's buffer reference to the allocated buffer.
> + * The packet must be freed via ssh_ctrl_packet_free(), which will also free
> + * the corresponding buffer. The corresponding buffer must not be freed
> + * separately. Intended to be used with %ssh_ptl_ctrl_packet_ops as packet
> + * operations.
>   *
>   * Return: Returns zero on success, %-ENOMEM if the allocation failed.
>   */
>  static int ssh_ctrl_packet_alloc(struct ssh_packet **packet,
>  				 struct ssam_span *buffer, gfp_t flags)
>  {
> -	*packet = kzalloc(sizeof(**packet) + SSH_MSG_LEN_CTRL, flags);
> +	*packet = kmem_cache_alloc(ssh_ctrl_packet_cache, flags);
>  	if (!*packet)
>  		return -ENOMEM;
> 
> @@ -330,12 +359,12 @@ static int ssh_ctrl_packet_alloc(struct ssh_packet **packet,
>  }
> 
>  /**
> - * ssh_ctrl_packet_free() - Free control packet.
> + * ssh_ctrl_packet_free() - Free packet allocated from control packet cache.
>   * @p: The packet to free.
>   */
>  static void ssh_ctrl_packet_free(struct ssh_packet *p)
>  {
> -	kfree(p);
> +	kmem_cache_free(ssh_ctrl_packet_cache, p);
>  }
> 
>  static const struct ssh_packet_ops ssh_ptl_ctrl_packet_ops = {
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.h b/drivers/platform/surface/aggregator/ssh_packet_layer.h
> index 058f111292ca..e8757d03f279 100644
> --- a/drivers/platform/surface/aggregator/ssh_packet_layer.h
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.h
> @@ -184,4 +184,7 @@ static inline void ssh_ptl_tx_wakeup_transfer(struct ssh_ptl *ptl)
>  void ssh_packet_init(struct ssh_packet *packet, unsigned long type,
>  		     u8 priority, const struct ssh_packet_ops *ops);
> 
> +int ssh_ctrl_packet_cache_init(void);
> +void ssh_ctrl_packet_cache_destroy(void);
> +
>  #endif /* _SURFACE_AGGREGATOR_SSH_PACKET_LAYER_H */
> --
> 2.29.2
> 

