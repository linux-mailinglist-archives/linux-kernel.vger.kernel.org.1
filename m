Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E426663F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgIKRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgIKRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599845026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/o0YxxUXNU/wKu4OmvlwpD3hfIBQxLaL46/ODaoc/s=;
        b=WqNEak9DlJAFn9s21JXC2b1c+XAZIgMJba7TXTCecRu9ZqZ47RTICMxYp1YWCEFG3KVVrH
        s/zczoqIJoNZwbOFWLhmfsiHYmpvaP0suxL4o6mjXO1N035bFDt9Ce72CQ1nQ2F/yNvREy
        r+RWI9R+muHvk3+aAdv8jeU5TyJf+oI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-ylPRczOhNoegB1fNmLu_rA-1; Fri, 11 Sep 2020 13:23:44 -0400
X-MC-Unique: ylPRczOhNoegB1fNmLu_rA-1
Received: by mail-wm1-f69.google.com with SMTP id l26so1611833wmg.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6/o0YxxUXNU/wKu4OmvlwpD3hfIBQxLaL46/ODaoc/s=;
        b=cgbSNdIx5O/DqLCmnnCFJDP3k7UE4jppI8WpxsdO/9b4wRp7BLfRFP8ku/h8G05/vJ
         k3sPeD38B66tZo2ydBGDFKfb5JEt4qVo4vRzi1oZA+/c2iWL7X3IjvC+jLr0+c9DiWv5
         Kx9b9Xy2jWr0kNu0XHkBvhclrfeoLSd72DudG+hziwu9YUAy/1vFj0TIfzTdabNNNYLH
         EYk39UNGjtQNHnmIoUdEhndvg5wotW8AlWFQYTKZpU1jkgQKT6M2opJwJVeNhEYWByby
         GTPzgIy0s0j4JAuK3ffyzZouRE23dZI3jERbi1NP5my8PkCiUYzux8VzRLimVp4d1U+g
         NXWA==
X-Gm-Message-State: AOAM531d7jZvw7mIkuEU0/G5Xl2SZeLvnEQKzM5bZR960D4LofKoiEVz
        CN4x2PE+cjZQIAP40cq0Kf3qs0im3SxH94pLruTrVHUUOJ8PysplCJoEoRG7iPfZXwDI2h3TEH2
        GOtyFMKKK7zLg1yO40AQp+m+W
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr3243418wma.18.1599845022915;
        Fri, 11 Sep 2020 10:23:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvu60NsLfN4Uw7tAn/ZEYwhNh26zDKlFJq0QCEwb/uKMZajgERhJn044lBeKtqe43zjrt4OQ==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr3243405wma.18.1599845022676;
        Fri, 11 Sep 2020 10:23:42 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id v6sm5589531wrt.90.2020.09.11.10.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 10:23:42 -0700 (PDT)
Subject: Re: [PATCH] kvm/eventfd:do wildcard calculation before
 list_for_each_entry_safe
To:     Yi Li <yili@winhong.com>
Cc:     yilikernel@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20200911055652.3041762-1-yili@winhong.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20efe3ed-8efa-ed50-bd01-329db676ee86@redhat.com>
Date:   Fri, 11 Sep 2020 19:23:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911055652.3041762-1-yili@winhong.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/20 07:56, Yi Li wrote:
> There is no need to calculate wildcard in each loop
> since wildcard is not changed.
> 
> Signed-off-by: Yi Li <yili@winhong.com>
> ---
>  virt/kvm/eventfd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index d6408bb497dc..c2323c27a28b 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -853,15 +853,17 @@ kvm_deassign_ioeventfd_idx(struct kvm *kvm, enum kvm_bus bus_idx,
>  	struct eventfd_ctx       *eventfd;
>  	struct kvm_io_bus	 *bus;
>  	int                       ret = -ENOENT;
> +	bool                      wildcard;
>  
>  	eventfd = eventfd_ctx_fdget(args->fd);
>  	if (IS_ERR(eventfd))
>  		return PTR_ERR(eventfd);
>  
> +	wildcard = !(args->flags & KVM_IOEVENTFD_FLAG_DATAMATCH);
> +
>  	mutex_lock(&kvm->slots_lock);
>  
>  	list_for_each_entry_safe(p, tmp, &kvm->ioeventfds, list) {
> -		bool wildcard = !(args->flags & KVM_IOEVENTFD_FLAG_DATAMATCH);
>  
>  		if (p->bus_idx != bus_idx ||
>  		    p->eventfd != eventfd  ||
> 

Queued, thanks.

Paolo

