Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47162B431E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgKPLtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:49:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbgKPLtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605527341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97VmpTXAdtiBuZSpuvkK0VLB6Qe0uigxKEQsDu39lOA=;
        b=S+F9/FpAFG4ES2GMcjRpxk2YhHErebd0CvRFvSe8wZFjW22SXhB8UssaEJbUgIKWwvvz8L
        qo7l8FmPhx61Ks32WwSttf2fuH7mzjPgWDAS8q870KrhKqGak820TQrYN/wpD0fvAjbUcM
        mhpwUDLNJdJ++eKmGlzbEMn2Xz+hicM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-9BYP-k9dNz6aQgaKYJIWJw-1; Mon, 16 Nov 2020 06:48:59 -0500
X-MC-Unique: 9BYP-k9dNz6aQgaKYJIWJw-1
Received: by mail-wm1-f72.google.com with SMTP id j62so8569807wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=97VmpTXAdtiBuZSpuvkK0VLB6Qe0uigxKEQsDu39lOA=;
        b=SvlbaDouCH8tSvI8EBAJBPDT2zNI9yjOCDHEjmWVmWLNcG40P40DkMbhjYDfIcHBqf
         w7s9PoSEVxE8KjNklKTR/bIDVNEFYKAjvQxv4pucVuriRr9YtR3teJNokJ6BaFgXHtsl
         6bvLXXGwwlogvMocgaL04uoqpX4nmUTtZQgWESPPDFHTuANM2YZTlEjiuez6awWDCdgZ
         1ebMmqZHJHQPQ27lI663Am4yOPGV0NtcULZMq0VBSrdddnmnt0z9JflZrL9dCSMXMBr7
         NHhI56A9F+UO8yqQe4beSTeXxooaRECiVWIRxzdEPYJmngvvVej53pHZbaQ6UeNa+jsV
         FWPQ==
X-Gm-Message-State: AOAM530mVucvfHynBFiC+pbFXgHqvLR47HB8mFtSAlXhSJprIKRmjgM8
        VzQg2MKtZNVvAY67iy9sUOSpvB2T0+JVJ5lhESNCdyToeSC67IBFM1mBPDIB3i/OzQwCTLXbTqP
        RYALIuPgc6+frFPu0Sn84VmIa
X-Received: by 2002:a1c:7215:: with SMTP id n21mr14797812wmc.173.1605527338070;
        Mon, 16 Nov 2020 03:48:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFOoFiy2XqLI4AaiwNdhMfhYIc4uTJT8KMlhnHiwhF1emha9fkhv6FOEox/VkGQR3P141RhA==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr14797795wmc.173.1605527337866;
        Mon, 16 Nov 2020 03:48:57 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id g11sm22694417wrq.7.2020.11.16.03.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 03:48:57 -0800 (PST)
Date:   Mon, 16 Nov 2020 12:48:54 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 11/12] vringh: allow vringh_iov_xfer() to skip bytes
 when ptr is NULL
Message-ID: <20201116114854.5vrcjzsvhklpfeud@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-12-sgarzare@redhat.com>
 <a5cfe66f-5ae2-1a73-6010-74123721135b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5cfe66f-5ae2-1a73-6010-74123721135b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:32:02PM +0800, Jason Wang wrote:
>
>On 2020/11/13 下午9:47, Stefano Garzarella wrote:
>>In some cases, it may be useful to provide a way to skip a number
>>of bytes in a vringh_iov.
>>
>>In order to keep vringh_iov consistent, let's reuse vringh_iov_xfer()
>>logic and skip bytes when the ptr is NULL.
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>
>>I'm not sure if this is the best option, maybe we can add a new
>>function vringh_iov_skip().
>>
>>Suggestions?
>
>
>I might be worth to check whether we can convert vringh_iov to use iov 
>iterator then we can use iov_iterator_advance() here.

Make sense, I'll take a look.

Thanks for the suggestion,
Stefano

