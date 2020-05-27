Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1B31E4394
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 15:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbgE0N1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 09:27:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41730 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387867AbgE0N1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590586022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rO0Xmu3kpwaS+spo70btHKk/n/bl2TDfOUNRISjvedY=;
        b=Zwtz3KVNBkXkOAz7DJgnrvHQF910iCD0DumL8CXrwm+AxuidxSFfM0RhTeC+ggATVChFy3
        VFlVuy7lUS8/hAoKFNgHbMJzej25iaW6narm54BNj/1QRjgpaSt4P4s83CDeu0S6YKgIOL
        Fvydh9KyOOeBFinUXN8p0rU7UmSj9po=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-fEyHqr_yP4KFgCB8iB93-A-1; Wed, 27 May 2020 09:26:59 -0400
X-MC-Unique: fEyHqr_yP4KFgCB8iB93-A-1
Received: by mail-wr1-f70.google.com with SMTP id z8so11189588wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rO0Xmu3kpwaS+spo70btHKk/n/bl2TDfOUNRISjvedY=;
        b=PjUvVnl7r9JvydMK4x0GceyDG40Xn7MstWrZXvYz6JW2Yz7AzX1rwj9lZTpD8A8kZl
         safweBRsSgfzTrt7ig0kkMb3WvNFEylkq+PaHu9cHmIrHeGQVnn+dXqgBc2ZxKSjK5RA
         bv5r/TRatMxPoZ/0wy2QhdG5+7w74l8I+Kr5hBoIbw9GqbcvFZr1rphaML4IbXL639UG
         fwA/vHDPu4m4BcXaFUmoD4EL76luNIsgiVF3WuLz1Zyhu3Aq7hzhtGnGnhumLK+aiwzV
         rnqzL9YrZtdYNj+6qBTapmE5KPRImWlwqgMAB3lpWhtkuXokOEQBPCCzafEaeY0B46ax
         rIHA==
X-Gm-Message-State: AOAM533VU3qZnXrOsWjezJ4pnqrf4fqrKDEhyRbpTsBOyepc70LmKH9f
        iCHhGzfbQxU+7iws2LkmY0zyf39wSA/piRoGxC4eKd2s7/Ur+Jk/LJitfzZQuS9n7wrfkRTTs8v
        we/qNYLsTTOrDz/P0LByjTnPL
X-Received: by 2002:adf:f582:: with SMTP id f2mr23080022wro.204.1590586018595;
        Wed, 27 May 2020 06:26:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzksEVrGsPk/xGJQnD5AtcYNTpqAooqkuvHIUr1bqlDBm3LvIU1wHX3ffnsooF7m2BY4wdfbQ==
X-Received: by 2002:adf:f582:: with SMTP id f2mr23079984wro.204.1590586018345;
        Wed, 27 May 2020 06:26:58 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.225])
        by smtp.gmail.com with ESMTPSA id c25sm2844600wmb.44.2020.05.27.06.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 06:26:57 -0700 (PDT)
Subject: Re: [PATCH v3 3/7] kunit: tests for stats_fs API
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
References: <20200526110318.69006-1-eesposit@redhat.com>
 <20200526110318.69006-4-eesposit@redhat.com>
 <alpine.LRH.2.21.2005271054360.24819@localhost>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <7178ea00-cee5-d5e9-a7aa-58aa46ee416a@redhat.com>
Date:   Wed, 27 May 2020 15:26:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2005271054360.24819@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> In order to run them, the kernel .config must set CONFIG_KUNIT=y
>> and a new .kunitconfig file must be created with CONFIG_STATS_FS=y
>> and CONFIG_STATS_FS_TEST=y
>>
> 
> It looks like CONFIG_STATS_FS is built-in, but it exports
> much of the functionality you are testing.  However could the
> tests also be built as a module (i.e. make CONFIG_STATS_FS_TEST
> a tristate variable)? To test this you'd need to specify
> CONFIG_KUNIT=m and CONFIG_STATS_FS_TEST=m, and testing would
> simply be a case of "modprobe"ing the stats fs module and collecting
> results in /sys/kernel/debug/kunit/<module_name> (rather
> than running kunit.py). Are you relying on unexported internals in
> the the tests that would prevent building them as a module?
> 

I haven't checked it yet, but tests should work as separate module.
I will look into it, thanks.

Emanuele

