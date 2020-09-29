Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D448327C230
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgI2KRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgI2KRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:17:13 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601374631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOObd0ASgZj9ppsbIcbaTgW81uYugr+Ory6jwCP3mGo=;
        b=KZ4HPZ5q9MfqQxUnM+BxRpW2zZySydCam+ry2u6HNM+zVtxED6AqAkaZy1NgTUPJrajDDx
        eJPN2aiHPWU4sQ2FNZ7seP94TatNxG32IJeZ4wV3cCZ/F4pb5bEaN4JtniMgrxmTCMBPYj
        /IeV4mhT7JTWNfC6BuG30mdKmj8NgPM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-7WMjehYvOtWDDPSR0sd6pw-1; Tue, 29 Sep 2020 06:17:09 -0400
X-MC-Unique: 7WMjehYvOtWDDPSR0sd6pw-1
Received: by mail-ej1-f71.google.com with SMTP id e13so1704580ejk.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mOObd0ASgZj9ppsbIcbaTgW81uYugr+Ory6jwCP3mGo=;
        b=JMIfA4PflZzbLHx1LyVgAucjx6lih5bEM/Tmx5ZjgCV3hqikjI0KE7b6M1YygZHWsK
         Cst2GLdyz7XOj8Rq3XzfErwLmX4QvxHS1sr0ERdpBfmKaHkVuGnKp34zM12mqfumZOl3
         vXOTOH5ZJW1MRyBzzu+c2lehjls5gR/ifJsTHgJQ4dxK3L5t8ZlyNRCHD/Iw8hOFigPU
         Pw5VC5Kvv1s2jbQo16VRdKqBG9OE1ueAckjasGdEC5eStmBkIg1OQafG3+IL2FPukiSb
         KSal8/B0iIehECbasHxSAr64ZTtwo/M1edwq+8C1vqXpBUfenOQUVcwlElIqPyT/Gm7L
         FHaw==
X-Gm-Message-State: AOAM531V3/OyUI3whe8vewVI2CgbrChK0u7D6dYYZF+snj/4h6ce169u
        1Ml0Z984jC0Ve026yyMMtbcgvzkitMQvkeZZ5sqARxOEu++CbaP1E7TxhGWtLNjEtigcewRQopd
        V/hwXIRwpIkyGHLI4/pxLw76O
X-Received: by 2002:a17:906:719a:: with SMTP id h26mr3162844ejk.336.1601374628124;
        Tue, 29 Sep 2020 03:17:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcB7ueuDG5cypCgqlJYSWilSBuD2g1k7d0mJR5Wv5Gi/z5RdGn0BdMU/yoIYOfxi+BU0ZnHg==
X-Received: by 2002:a17:906:719a:: with SMTP id h26mr3162819ejk.336.1601374627848;
        Tue, 29 Sep 2020 03:17:07 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id lo25sm4767646ejb.53.2020.09.29.03.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 03:17:07 -0700 (PDT)
Subject: Re: Keyboard regression by intel-vbtn
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <s5hft71klxl.wl-tiwai@suse.de>
 <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
 <s5h8sctkk2b.wl-tiwai@suse.de>
 <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8c3d8a56-541f-aafc-1be9-4d72d374effe@redhat.com>
Date:   Tue, 29 Sep 2020 12:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/29/20 11:59 AM, Barnabás Pőcze wrote:

<snip>

>> Oohoo, what a wonderful world :)
>>
> 
> 
> Splendid world, indeed. I'm wondering, however, why the incorrect state
> is reported? Is it similar to the linked issue on the Manjaro forum, where a
> different bit is seemingly used to report the tablet mode state, or something else?
> I'm also wondering why it was chosen that a *set* bit means that the tablet
> mode is *off*. All these problems could've been easily avoided... (given that
> I'm not missing anything obvious).

I'm afraid that the only answer which I have to these questions
is not helpful, but in my experience it is true: "firmware sucks".

Regards,

Hans

