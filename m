Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691B92B7853
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgKRIVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:21:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgKRIVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605687676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6KbmzkjPXdz5sd/mUlYtsiRppY2HL0oovb3kA5qA88=;
        b=DmN5WcaxiJBo/y6HXemUCWlx4Lq229FAfIxiRl9gVcU3kUNzGJUgADQ0mP0wyQkxxLfAKT
        I0AYO94JoanTJTXet9EnH2hRkl7aptnwkdSPpTBa9MTVhsz3i/vKIUZTLZXwgZet22FcUp
        G1F33DkPobCdlg4biKCukZ+rVaPeUOY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-PwIx0dc5NuCuK4jOQcwF8g-1; Wed, 18 Nov 2020 03:21:14 -0500
X-MC-Unique: PwIx0dc5NuCuK4jOQcwF8g-1
Received: by mail-ej1-f69.google.com with SMTP id l2so550952ejx.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6KbmzkjPXdz5sd/mUlYtsiRppY2HL0oovb3kA5qA88=;
        b=lJml65lWsm12FoQXR1MS9WRRzs5m4mBEDcchCj7vn/EWG5rlHstlAPKj5TEyTpblR4
         rB0DSCAudYFE0o6o/MK/kYESetwy7xanV5we+DapxGckK13IU4SGVF6TUyNH+kFg4O44
         RddGFcoUPtI7LY33Sz/5l8KYdbgsfbHta1isM/Du+yoyN942gAy4rm9Na0Ff7GRpIzER
         g1g6gTWx+yaV8+Wzkv+QxmGwiRSZ0XE5pSm3KppVKKyCIv7Bu/1gTCrV7adXFOivhvmc
         Ao1BXI9PCk7fbQRmwjNM3N9pHnJTs9I6pwVRaHBuo0N0K/kvfQvpqdmAg7P9yrdadpaY
         i5VQ==
X-Gm-Message-State: AOAM531hu832gZYZsEEyuflOKl+0rD/e0C6VcUeobNpj6yynH1Mt2Uqw
        iP0PahkgKafDo6MOub391e9CVZzrneu3lfMYk90Wa6qercK/wDM+mw2gT5sh01yyfQqqrlyqASC
        Fa7P6zJPYiJc7PPPSoJ77wfo5
X-Received: by 2002:a17:906:ca93:: with SMTP id js19mr24197396ejb.537.1605687673227;
        Wed, 18 Nov 2020 00:21:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnL15xTPVl8NBwdM1yC9jhzhLP8R3S6JTXtQ9uX4GF3tz9G3svQWxLIaZfoDvgEd1r2A6fww==
X-Received: by 2002:a17:906:ca93:: with SMTP id js19mr24197387ejb.537.1605687673057;
        Wed, 18 Nov 2020 00:21:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b1sm12672359ejg.60.2020.11.18.00.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 00:21:12 -0800 (PST)
Subject: Re: [RFC] Add kernel-doc test script
To:     Eduardo Habkost <ehabkost@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201030144713.201372-1-pbonzini@redhat.com>
 <20201030144713.201372-3-pbonzini@redhat.com>
 <20201113152106.7b4a07ee@lwn.net>
 <20201113223912.GK17076@casper.infradead.org>
 <20201117212452.GM1235237@habkost.net>
 <20201117213051.GA29991@casper.infradead.org>
 <20201117223612.GN1235237@habkost.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19ebee73-0e7a-7dc1-5948-072ae153e383@redhat.com>
Date:   Wed, 18 Nov 2020 09:21:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201117223612.GN1235237@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/20 23:36, Eduardo Habkost wrote:
> +# the -man output includes the build date
> +export KBUILD_BUILD_TIMESTAMP=1991-08-25

Nice :)

> +ok=yes
> +
> +# don't even try to test other formats if -none fails:
> +test none -none || exit 1
> +
> +test rst2 -rst -sphinx-version 3.0.0 || ok=no

Do you want 3.0.0 here too?

> +test rst3 -rst -sphinx-version 3.0.0 || ok=no
> +test man -man || ok=no

Also since you are at it you might as well rename the function to 
something other than "test", it's a bit confusing due to the "test" 
shell builtin.

Paolo

