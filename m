Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE122C2D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390459AbgKXQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:36:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390470AbgKXQgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606235808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qViGPvAp3Bdb6AOjvlouT/dVyBQzwDGsvBv6zenTU0=;
        b=dAF24XkatYRVtQUW8jf1zyQHr7l3u3oN3hV56Uvejrea+bh6BAQpoDqvbXCUkTzN3as3R9
        bwtzty9OTqyyIYxam3MFulujwXY+tee5Im03J7CTgfzPjal5i1OGsQKBQSbdCpRzHjoPIO
        jYwPFDopN0rp7mQZLtEGijWc5e/IBNI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-z0hqIUuhOKGXlx8s0QXqBA-1; Tue, 24 Nov 2020 11:36:46 -0500
X-MC-Unique: z0hqIUuhOKGXlx8s0QXqBA-1
Received: by mail-qt1-f198.google.com with SMTP id g12so16576693qtc.15
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3qViGPvAp3Bdb6AOjvlouT/dVyBQzwDGsvBv6zenTU0=;
        b=E/gkb24ZueZmLCBCIWJBajjopHxfagAHmEUnHOXGYBlrjtCc8OiVvZZZkenKGAbEQe
         l8mAZgIP0ETQHt1r5IvelbNCO9V6d/rNSs92nG6a4FoTDdQYDrb1Rug8NRF64FzyNmxI
         lwlwgOh/QlvzPp5Da1x13ydGaEqHVv3XS+b7tjKsNX1dwNEYCSVlsLVLIDiy3UIrv5gU
         VRejO5AbI0D9LCaZ1/gYGey8M71THgqRbDqIbBX9ayNjwfQ6a5jEBkHxLtkUnn3zKoHE
         /QCMBoo+MQ6+CQzIv1tHJ8F0yjtbvJZY7fDrqeLbOwC6RZFvbxUiG+CGJ086utw0uZ7o
         wZkQ==
X-Gm-Message-State: AOAM530sj8gW910dSqhlYP62A1QFZNu6crLeWd/w78/sZRAmbf1S+E1y
        T/XQXPIFbObRuERI6MrAy0kqKc8N++znbYLA5V8tEXAr/bFJUDCNICF3Q9C0P5vqZoDmCKiVCl4
        zAJ/FuYZA3b8NnriVUg8v19Pj
X-Received: by 2002:a37:6892:: with SMTP id d140mr5265891qkc.200.1606235806342;
        Tue, 24 Nov 2020 08:36:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzP/zq72cvnSAWEVDqTAda07UHdS5aRMF2LrjfClGVhHpVLSq+wwWTS4eIddRlosB2VneKCw==
X-Received: by 2002:a37:6892:: with SMTP id d140mr5265862qkc.200.1606235806104;
        Tue, 24 Nov 2020 08:36:46 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x19sm10252911qtr.65.2020.11.24.08.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 08:36:45 -0800 (PST)
Subject: Re: [PATCH v5 0/9] "Task_isolation" mode
To:     Alex Belits <abelits@marvell.com>,
        "nitesh@redhat.com" <nitesh@redhat.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Cc:     Prasun Kapoor <pkapoor@marvell.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "leon@sidebranch.com" <leon@sidebranch.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <8d887e59ca713726f4fcb25a316e1e932b02823e.camel@marvell.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b0e7afd3-4c11-c8f3-834b-699c20dbdd90@redhat.com>
Date:   Tue, 24 Nov 2020 08:36:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8d887e59ca713726f4fcb25a316e1e932b02823e.camel@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/23/20 9:42 AM, Alex Belits wrote:
> This is an update of task isolation work that was originally done by
> Chris Metcalf <cmetcalf@mellanox.com> and maintained by him until
> November 2017. It is adapted to the current kernel and cleaned up to
> implement its functionality in a more complete and cleaner manner.

I am having problems applying the patchset to today's linux-next.

Which kernel should I be using ?

Thanks,

Tom

