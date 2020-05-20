Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B961DC12B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 23:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgETVP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 17:15:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40447 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726892AbgETVP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590009354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nn5uBihfGYPam0z7Bth4Bg/2LeoczkcBonH1Rf5fkTY=;
        b=BCAmoV5Xq4WTLWlCll/NnnYt6k4dcsYUKoWhjcG/2sfS0FVNxrnHwlxZK6klarUt0Oe7bS
        huaJNvgOxPpPVnFMfrkx+H2zDBlV8omNK4MVueoTKOCOu/U/WNiCAweyzpiiFH2n2SRcpE
        GAWGUnaXz8hD7r6Ic3odt5T/oAzBZFw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-mXgtR43LNCi8Dr10lA2_vQ-1; Wed, 20 May 2020 17:15:53 -0400
X-MC-Unique: mXgtR43LNCi8Dr10lA2_vQ-1
Received: by mail-ed1-f69.google.com with SMTP id c10so1799133edw.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 14:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nn5uBihfGYPam0z7Bth4Bg/2LeoczkcBonH1Rf5fkTY=;
        b=UWEZk0HKafQ0mhV40d154Q9JUIBz3CeqCq6af7DAz/lVmYkqoDK3mdsgawf9cQEfnI
         5dCcHo7j3F1/zGPkrQ9tjgAMb6GTbVixYzWO2mKYVd0SAzHrh4D1ENyeiYr08LyWOEou
         mrcmXa1Lp4K+kt2pkZMc4pe1cqNqCRqI09NfGCrIuCAGL9NfC43pcn9PSULa2i2gpMWT
         /OVqEed49lHIWcAAYyIxCB+GFp6q2AXjMbDc4PUIoig9qOqJlLCp+QXcrvcuWggMcjfV
         lGijSpxNo8vUADM0IKY5A3s81uLHjqVqRZB1y41D1CUusXA7tmC7R0GnNeL8jGNgGxf6
         2TWg==
X-Gm-Message-State: AOAM532l4QYEYt8/z6trd2LlSaJmTjejyO2NYAH+hav/46rG+Tx17BFo
        rxv/VEmibwDVZ1ki34AjzdyrHuzLi9o/+8Fw72SN2ABII24v29smQTRsp8qPMlOTFr3rqeDwI3/
        +IqXuLOH4DtSIILErBM3OqxaT
X-Received: by 2002:a17:906:298a:: with SMTP id x10mr893227eje.238.1590009351884;
        Wed, 20 May 2020 14:15:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP+T4UQY4+ZFFK7rI3puH/bbF9P484sU4hk3mzrt0kP4DghamnJ1GKfP2P9zAY21b+8eR5zA==
X-Received: by 2002:a17:906:298a:: with SMTP id x10mr893215eje.238.1590009351702;
        Wed, 20 May 2020 14:15:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1c48:1dd8:fe63:e3da? ([2001:b07:6468:f312:1c48:1dd8:fe63:e3da])
        by smtp.gmail.com with ESMTPSA id 89sm2898493edr.12.2020.05.20.14.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 14:15:51 -0700 (PDT)
Subject: Re: [PATCH 00/24] KVM: nSVM: event fixes and migration support
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>
References: <20200520172145.23284-1-pbonzini@redhat.com>
 <6b8674fa647d3b80125477dc344581ba7adfb931.camel@redhat.com>
 <cecf6c64-6828-5a3f-642a-11aac4cefa75@redhat.com>
 <2401913621cc7686d71f491ef55f30f78ebbb2eb.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81f6d5ce-b412-31f8-e750-67d4a06a5357@redhat.com>
Date:   Wed, 20 May 2020 23:15:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2401913621cc7686d71f491ef55f30f78ebbb2eb.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 23:08, Maxim Levitsky wrote:
>> IIRC you said that the bug appeared with the vintr rework, and then went
>> from hang to #DE and now back to hang?  And the hang is reported by L2,
>> not L1?
> Yes, and now the hang appears to be deterministic.

Ok, that's actually progress.  Also because we can write a testcase.

Paolo

