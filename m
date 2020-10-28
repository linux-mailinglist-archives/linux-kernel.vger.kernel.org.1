Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABAB29D3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgJ1Vpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgJ1Vpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=66nQyac2hxeaBQvnu3KghvLtDJPnPJ2NCil3q6sKCIg=;
        b=X55rUPVa8g84zR5hz81o8vq1lmxxTYqY30A5JK8z6nq/TNkNygwfofsxXruKKDXnPyXAQO
        MJC74S41atNbPVurwfNUc4B6DTOhIUnAyDT3UFLRgnfxdhsSHv1kZe41VQtbq85oExnmzu
        cqpZ+xwu3S8MlScPBmGOndLXVVjp5Jg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-MbeVINo_OJeGI9jcIgwd9A-1; Wed, 28 Oct 2020 10:44:55 -0400
X-MC-Unique: MbeVINo_OJeGI9jcIgwd9A-1
Received: by mail-wm1-f72.google.com with SMTP id s12so1702480wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 07:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=66nQyac2hxeaBQvnu3KghvLtDJPnPJ2NCil3q6sKCIg=;
        b=JEgbHCrtkLct/EUm8oFwIotyMo0ok5n9PC3dBunSyRe5bVIYyv3cBsONgyKsVNj3c0
         oFlLSVTYeIF7xiTSN4Pi7Bs2y+BNggt9jHElybjqTkqru6qJlkTUNagDhGMcBIu3d4VI
         mH7AE+nm+xCmOeMBQhn6DkuFkBMD68cT/XP1HSw2QZkxwGL/8TruAu/jH9PB9jHcfTDv
         T4QKN4iAy2rouNCFcthC9hiXGt4kbdhzG7tCubvymgVmaLL1G/xDDFSaP/iATg3jrwLH
         zD+g7eMLvHvaMj9/9O7rB7CNP0RINoCCPGlSoex5d+BWreNYK7nOlrVKbwe4eRLp6Ak0
         fgvQ==
X-Gm-Message-State: AOAM530otIFmpD1u3kg+xOI5sV/90n4uP9ykKJ1Ec8NCnRXYD2FszU0x
        Lhmp3yeFc4J2B1SX7P4EOo8Q5GFCi76DAu/gWHN9x20AL9L3No2CcbE7aTnQ/GVo2eKROqWEEuc
        siOUd0G/Ua1QfdUTqkcwkQFZu
X-Received: by 2002:a1c:6302:: with SMTP id x2mr9139063wmb.121.1603896293885;
        Wed, 28 Oct 2020 07:44:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVZ1pMlnMRV9XQp7ynV1e5d9Un1RCNyFC9GqQDtizxI9AAulK2o6sKxWadGDvbXi+JMtVvKg==
X-Received: by 2002:a1c:6302:: with SMTP id x2mr9139042wmb.121.1603896293696;
        Wed, 28 Oct 2020 07:44:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k81sm1492901wma.2.2020.10.28.07.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:44:53 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sched/wait: Add add_wait_queue_priority()
To:     Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Davide Libenzi <davidel@xmailserver.org>,
        "Davi E. M. Arnaut" <davi@haxent.com.br>, davi@verdesmares.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kvm@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
References: <20201026175325.585623-1-dwmw2@infradead.org>
 <20201027143944.648769-1-dwmw2@infradead.org>
 <20201027143944.648769-2-dwmw2@infradead.org>
 <20201027190919.GO2628@hirez.programming.kicks-ass.net>
 <220a7b090d27ffc8f3d00253c289ddd964a8462b.camel@infradead.org>
 <20201027203041.GS2628@hirez.programming.kicks-ass.net>
 <0bc19d43229d73c0fcd5bda1987e3dbb9d62a7e0.camel@infradead.org>
 <20201028142031.GZ2628@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c2d63dd8-4f31-df23-2834-979a261f7653@redhat.com>
Date:   Wed, 28 Oct 2020 15:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028142031.GZ2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/20 15:20, Peter Zijlstra wrote:
> Shall I take the waitqueue thing and stick it in a topic branch for
> Paolo so he can then merge that and the kvm bits on top into the KVM
> tree?

Topic branches are always the best solution. :)

Paolo

