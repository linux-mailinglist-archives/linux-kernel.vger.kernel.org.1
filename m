Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844E42B289A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgKMWfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:35:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725986AbgKMWff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605306934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OxJxP1oE2Cla0I1OPN4NdLIp1AOD5ygh5VOrDf70gp4=;
        b=bY3OfxgJiQR5I+LiZ20Sxtsg2iw22E4mQC81ARdK9Ob+FqtxCJRGmzznNdbAA3CkX5vqQg
        /bJWgQ3t8//696WWWNwVP/FrNvpxnO3gQ7c5J7QZA1tTNGKzoXfoRqxbfyTnIoRI1hfWmS
        M2TfMkQmxKha7zwjVU0IetWLNtfMZsQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-7GLq8PRFNcKvw05hwBrivg-1; Fri, 13 Nov 2020 17:35:32 -0500
X-MC-Unique: 7GLq8PRFNcKvw05hwBrivg-1
Received: by mail-wr1-f69.google.com with SMTP id v5so4716418wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OxJxP1oE2Cla0I1OPN4NdLIp1AOD5ygh5VOrDf70gp4=;
        b=BBwM0EPbQKmyK8jLAP82Mkq98WYBsfZgOnfCnn6S+Sg6Ij5k8/BbbXkbWFv+O+eNb8
         8XjLBQxQxqZu0Qe2YUESLZ1JHVZA+ab2ZJXfsJIC2pTR8s5a7RrMIFmx9RwgmzkAosTe
         EljxbWb8HCqOypkOPYjzlWSyuE5mi1uCGZOpu0CKz8MF80/7sXQklv2sgSBzvpFzUVrA
         BGdwTTm0szzumECeTVSRD19iBmKM8pPd58llprkKPo7kecVeqO2rD0gap6qIfVLtOvmu
         mwC5VOxBGRzcldKFcQtMgrwboJQjAUt5UvtfFnY9YhGVgWnQwzGy+qDCoIZqIY3vlmQP
         JPhQ==
X-Gm-Message-State: AOAM533OhmwnVZlMLat31waIaXPY3PEWHQM3Hm0uaIKi9egC+jxBsHz6
        X1Fg/NkUACJU8bgP/8t+8lKukLxf4pI5xNwLK6E67nsKTaZ75GcV6Z7A46vA7cThkeTkmoosZgX
        imecpvCLJ2YyrMQ2OjXWT0+pj
X-Received: by 2002:a1c:6302:: with SMTP id x2mr4646097wmb.56.1605306930818;
        Fri, 13 Nov 2020 14:35:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx16goPmTkQI33BXjPuhsGv1l1ZNJDXKJH2RZQichX2X24coMGN7jfwISuAuamqZjVj9g86Ww==
X-Received: by 2002:a1c:6302:: with SMTP id x2mr4646082wmb.56.1605306930644;
        Fri, 13 Nov 2020 14:35:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id g20sm11435472wmh.20.2020.11.13.14.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 14:35:29 -0800 (PST)
Subject: Re: [PATCH 2/2] kernel-doc: Handle function typedefs without
 asterisks
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Eduardo Habkost <ehabkost@redhat.com>
References: <20201030144713.201372-1-pbonzini@redhat.com>
 <20201030144713.201372-3-pbonzini@redhat.com>
 <20201113152106.7b4a07ee@lwn.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b42c1b4-e730-5403-dc28-303b32622727@redhat.com>
Date:   Fri, 13 Nov 2020 23:35:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201113152106.7b4a07ee@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/20 23:21, Jonathan Corbet wrote:
>>
>> Signed-off-by: Eduardo Habkost<ehabkost@redhat.com>
>> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> So as you've undoubtedly noticed, reading those kernel-doc regexes is ... a
> wee bit on the painful side.  Trying to compare two of them in a patch to
> figure out what you have done is even worse.  I suspect we want these
> patches, but can you please supply a changelog that describes the change?
> 

Seems like some of Mauro's recent patches take care of the same thing. 
I'm going to update QEMU's kernel-doc, and if there's anything left to 
do I'll resend.

Thanks,

Paolo

