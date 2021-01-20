Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544602FCFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbhATLxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:53:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728298AbhATLfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611142434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUX//Uf+V6l0OJyZxkhQnjE+0KPFHbcXgQTrdUt5Ypg=;
        b=QnlGRhNmR8Z2A1flHEv2whf68A0l/W+8a2XlvaB3R1pHkk7hIMgcFrxF2sHc9RV7wco2vL
        5OfWKJYb7RsMEaNtYITQp15sqfg1HCjFqN75Eva3/G91RUlWWdcLMJ/fwZpZkmHa38jxTt
        qjKSPo/Z9O/I1+d2SGsKKbdKV9L6Wng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-CFemLnO9OUWF2i6KPxc-_g-1; Wed, 20 Jan 2021 06:33:52 -0500
X-MC-Unique: CFemLnO9OUWF2i6KPxc-_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EDD11007245;
        Wed, 20 Jan 2021 11:33:42 +0000 (UTC)
Received: from [10.36.115.161] (ovpn-115-161.ams2.redhat.com [10.36.115.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D3085F9B5;
        Wed, 20 Jan 2021 11:33:38 +0000 (UTC)
Subject: Re: [PATCH] virtio-mem: Assign boolean values to a bool variable
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Tian Tao <tiantao6@hisilicon.com>
References: <1611129031-82818-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <81a1817d-a1f5-dfca-550c-3e3f62cf3a9d@redhat.com>
 <20210120045736-mutt-send-email-mst@kernel.org>
 <da2cb3fb-0ea5-5afd-afb5-a9e7f474e148@redhat.com>
 <20210120060301-mutt-send-email-mst@kernel.org>
 <a61b016e-7896-134c-a1be-8ff8e8e6fbe2@redhat.com>
 <20210120063209-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <486f9996-377d-0901-838b-8a4a1747d128@redhat.com>
Date:   Wed, 20 Jan 2021 12:33:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210120063209-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Want to send your ack on this one?
>>
>> Sure
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> 
> Added yours and the original Signed-off-by.
> 
> Thanks!

Thanks Michael!


-- 
Thanks,

David / dhildenb

