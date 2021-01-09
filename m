Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637132F041D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 23:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbhAIWaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 17:30:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbhAIWaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 17:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610231325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jg/ZAS99FadMheTYVgBlaao4XOVVMoYrSPeglej7y3o=;
        b=LwfPvH6DNkCuxo1+RUKPN1YNMazNj0kL5EMr7HAxAQ6ju2OEsNRVXbqSUrOQzO4foV9SVU
        5lqV0rY4oS4Z6uQR32WJI8rGGnxLRu9WYbt77LJPa/YwmthsHq9vjS1lcEvnPOUnfdxqQP
        KKAGV31ep8tgLJWBedjppN41kh/TKzs=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-JyDXFnSCPNe2lb6SLgvdWw-1; Sat, 09 Jan 2021 17:28:43 -0500
X-MC-Unique: JyDXFnSCPNe2lb6SLgvdWw-1
Received: by mail-il1-f197.google.com with SMTP id x13so13622153ilv.16
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 14:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jg/ZAS99FadMheTYVgBlaao4XOVVMoYrSPeglej7y3o=;
        b=TaOUVJbNWvPptcw9gRg4GheJiVbox6MnEaxaS5wQk612KWM4im8DacgXo3UrlS90/9
         ICrU6wziprX8QKxfHfjgsWKK+tkE8hKubDMmTWBe6JewPWPe3A3h0t2zGjmF4wr3dJvD
         gryhUKzFncHTJnfeUrVn7T/zXexIvKKXokMrI77uyPGia25NhKEK1JEf59rwkDJc/koe
         NVa/+HEaXMWaWTF6MIYYBCuzDy9peXS5u7lS8ffZM0YHo9KmRMN2VjzLdgp8xkiLFlfj
         kpRtid5KabfsuHKs+0NrzkNs0LqGzSS9bGDfMxSFJoWMHj/mFAPAXJj9MqW4N/yceGHb
         98gw==
X-Gm-Message-State: AOAM531/6+03MFFXpDkbSEhmm7BEqH1uiFCG8yYh5J3MmL8DKiwvbCYQ
        9o7kKR6ozBmuaRka9skkV6MY5KYg2DmLT1k6eEOswu0mycYMdGbbw/vArDqX/cgqOQroKANhjx3
        kVed+/OWQfbQMkFjkTD4u2EP9
X-Received: by 2002:a05:6e02:124e:: with SMTP id j14mr9808643ilq.284.1610231322927;
        Sat, 09 Jan 2021 14:28:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaSjjO16oSRzXsGLSYddqV1RyaHck1VUwGk8z1xubqvG+T9XAPr4bErVIZkzW6aL/L/oNpMA==
X-Received: by 2002:a05:6e02:124e:: with SMTP id j14mr9808636ilq.284.1610231322770;
        Sat, 09 Jan 2021 14:28:42 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b12sm10834942ilc.21.2021.01.09.14.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 14:28:42 -0800 (PST)
Subject: [RFC] removing explicit #define DEBUG
To:     LKML <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>
References: <20210107034904.4112029-1-pmalani@chromium.org>
 <X/bRstJuBYaLz4PK@kroah.com>
 <CACeCKaediXs81OUTogTWrqoZViP5rLqodO6nngeY2PLnWw=t+w@mail.gmail.com>
 <X/bpBFLIM91eZAEO@kroah.com> <X/cK8myUzKotH86j@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c1f4416f-95aa-0c9e-1077-182b0922c88f@redhat.com>
Date:   Sat, 9 Jan 2021 14:28:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/cK8myUzKotH86j@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cleaning up the printf %hh's I have found a number of files

that explicitly do a

#define DEBUG

with no comments or surrounding #ifdef CONFIG_MY_DEBUG_FEATURE/#endif

If I saw this in a review, I would assume this was leftover devel code and nak the review.

Finding and removing are pretty trival, i believe there are only around 10.

I am bringing this up because if the existing code depends on the DEBUG,

ex/ getting lucking with timing, then the change would introduce problems.


Tom


