Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7E92CA843
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgLAQ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:28:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbgLAQ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606840048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XyWjps8tzjgTT01ktwpVftfAs1XpUw8uGrEPLgazA70=;
        b=EnD+dbhzq8HlzEwa+BQVGBECKexMduZ856sCJdvN0O95e7IIZKqWhbvJrpzk0CNYdfYOwc
        qubANPd9SpDwVL1iNscSiBkfiRrSJC3QqNRIojQCsanoYM1rhZ+qB/LJurJP9iwi4RgSiW
        zSBE+XmzS8ch1Sg9p6b9F1daNikGJ+M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-F-b4JgvON_SAra6nobbILg-1; Tue, 01 Dec 2020 11:27:27 -0500
X-MC-Unique: F-b4JgvON_SAra6nobbILg-1
Received: by mail-wm1-f72.google.com with SMTP id r5so1170658wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XyWjps8tzjgTT01ktwpVftfAs1XpUw8uGrEPLgazA70=;
        b=bvUJdWZij0vf0Za0HfIeE1Cy51XOlw2QuWtI3Rm/2ACCI+cr8Wpe44IKaoYTrty2Hl
         uPnCzyWTm4kewXZ1NpuBvQ6LmxE6DS4n6w7FCs4NjTeZItgLF7FlhT/lvki5xsMr6Hyz
         sgVp20Dt5J0JD/Y7LJC8+y9DpoVaauYHFjt6mUqS4ca4fx6qliR5J3Pky8Rk78OFNztH
         xeMlH4+XUOmIUshgdbdHBAs7/Za45I+8lxfIMSNpu0+VepbMihyE/6vA8i1trnBQeyw9
         2qLJkV81CjK+837PGhvm9AKe1wlyJF15kyXkCfndplr3GV8n8c7sOnnGXcmONta1swLp
         sKOA==
X-Gm-Message-State: AOAM531nqMZxPu08eYo+gmmlCQmMIxJatAd3JKFGpzkORWQSZj/BMv/5
        66E/rwxAuRwjwdE0fv1LKJj/Lk6Cx8NLdC7ErcWkHDqqy8/GMFuldSWdf+PHcOh5LPq9c8tOJ3V
        jzFjXyyOUl1nXGZ+HmkRwPB33
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr4976977wrn.124.1606840045015;
        Tue, 01 Dec 2020 08:27:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdDqJt6fveHVsoUSo1PtynWnxeDkOhF4Sr6xztn3/Nuu9uQkO1f1rAWY9/Z2ilme4hq+2iDA==
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr4976947wrn.124.1606840044789;
        Tue, 01 Dec 2020 08:27:24 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id n10sm46507wrv.77.2020.12.01.08.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:27:24 -0800 (PST)
Date:   Tue, 1 Dec 2020 17:27:21 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Andra Paraschiv <andraprs@amazon.com>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        David Duncan <davdunc@amazon.com>,
        Dexuan Cui <decui@microsoft.com>,
        Alexander Graf <graf@amazon.de>,
        Jorgen Hansen <jhansen@vmware.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH net-next v1 0/3] vsock: Add flag field in the vsock
 address
Message-ID: <20201201162721.lbngjzofyk3bad5b@steredhat>
References: <20201201152505.19445-1-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201201152505.19445-1-andraprs@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andra,

On Tue, Dec 01, 2020 at 05:25:02PM +0200, Andra Paraschiv wrote:
>vsock enables communication between virtual machines and the host they are
>running on. Nested VMs can be setup to use vsock channels, as the multi
>transport support has been available in the mainline since the v5.5 Linux kernel
>has been released.
>
>Implicitly, if no host->guest vsock transport is loaded, all the vsock packets
>are forwarded to the host. This behavior can be used to setup communication
>channels between sibling VMs that are running on the same host. One example can
>be the vsock channels that can be established within AWS Nitro Enclaves
>(see Documentation/virt/ne_overview.rst).
>
>To be able to explicitly mark a connection as being used for a certain use case,
>add a flag field in the vsock address data structure. The "svm_reserved1" field
>has been repurposed to be the flag field. The value of the flag will then be
>taken into consideration when the vsock transport is assigned.
>
>This way can distinguish between nested VMs / local communication and sibling
>VMs use cases. And can also setup one or more types of communication at the same
>time.

Thanks to work on this, I've left you a few comments, but I think this 
is the right way to support nested and sibling communication together.

Thank you,
Stefano

