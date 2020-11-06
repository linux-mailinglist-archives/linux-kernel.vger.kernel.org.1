Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119032A94F1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgKFLAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:00:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgKFLAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604660448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZtZT7itrVpNRfBlr3Cazy0HWs7zXJS+GGQb2VbmhUxk=;
        b=Uj+6QUxNBm0P0iXvq7onhHJrK8+OfAG/0pFmW20p+x/CI63ArQ+Gde/FZe/pkQMA66MqDY
        MH/AusmohfLYvG4Hm9Qx74GF8pzt7ikcIIlF6rXbeOUolB1oRgq1rrE34vPwsXFS0H94k8
        YwrtoSugQcFfGftH8oW/Qr/5KmW+kmY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-V632puqaPOOAtjHWuSLJLg-1; Fri, 06 Nov 2020 06:00:47 -0500
X-MC-Unique: V632puqaPOOAtjHWuSLJLg-1
Received: by mail-wm1-f71.google.com with SMTP id l16so294088wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 03:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZtZT7itrVpNRfBlr3Cazy0HWs7zXJS+GGQb2VbmhUxk=;
        b=bwP4mTRjiz4sLIAUruUGPcsLRUgesvbSF+w+l8fRkObbLFEAIRGXxOykvqQMUwnfPX
         kuRbCkxMBhLQdm+XfY9OSKwmcH3YvKa/h7qp97CCPpSGyvAHqz25ScZDSAv0nOTmiwIT
         xP6IJo4/3ttXtIy/ak24lnxcJ9WgiPwp9K8sd3sPI0wp7NU3ZeqNjJyPcBSCIal/8yBS
         Sd/6xj3itEIbpcmEOvLD4mDJaXB0LcP7kz6nPQfA4hmyWiHvrtjsDdZOs2qQQlviIzPz
         0B3HNgy1OCDauIHeTWR3XeY20HT5GxKlSr/vNK75vNlwx1BcG1H2YBn11HALjnxsQOjg
         qoVg==
X-Gm-Message-State: AOAM533myAKAPFOeCBgJ+kmXtCm62iff5f4FcwyYCk7s2R6D1CGbDpa0
        99wfNqJfI77yU0eSswiFqzPC9Vk1Kjwskeo1/RXzdnXerMGXTBH43OwR41rElXRzNyhPZptP1QE
        pvmLhAmH37YMmNZKHHcsH6j7U
X-Received: by 2002:a1c:b041:: with SMTP id z62mr1861616wme.183.1604660443119;
        Fri, 06 Nov 2020 03:00:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy998yT/dbdVsyfPvdRyx12Gso3/GpsD6DmKxXxQdpz/rRJ9mO5IMFzBixjrV3UiX4aJV0qjg==
X-Received: by 2002:a1c:b041:: with SMTP id z62mr1861590wme.183.1604660442885;
        Fri, 06 Nov 2020 03:00:42 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id l3sm1969557wmf.0.2020.11.06.03.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 03:00:42 -0800 (PST)
Subject: Re: [PATCH v13 06/14] KVM: Make dirty ring exclusive to dirty bitmap
 log
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>
References: <20201001012044.5151-1-peterx@redhat.com>
 <20201001012224.5818-1-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <26c461bc-b2e3-bc23-fff6-0377b09d325a@redhat.com>
Date:   Fri, 6 Nov 2020 12:00:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001012224.5818-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/20 03:22, Peter Xu wrote:
>   
> +	/* Dirty ring tracking is exclusive to dirty log tracking */
> +	if (kvm->dirty_ring_size)
> +		return -EINVAL;
> +

ENXIO is slightly more appropriate (especially for debugging, as EINVAL 
suggests that the arguments were wrong and not some external state).

Paolo

