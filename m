Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6FB2F76DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbhAOKmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:42:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbhAOKmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610707234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RX5uSiRrVlvyzLUv66fuI7aYcwumIOTQtngnkQr2i4=;
        b=COvJ64vpPM03HyqObuNVMyHC9x0Bglib/cZ/4o24I7Ji/E7Qx+7K/u2t8fnOB7RDfMTIYJ
        LxSNJznixMx6HIsmlw8AnXBG/o30yeWSmMHUAfK535YyCU5X5q//RFyseXycq0VvSANgLN
        JydKoT2Id5G+pp1qC8IuLtiiCNtYe40=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-wVJgU4sZOHWBRgHby5L9eA-1; Fri, 15 Jan 2021 05:40:32 -0500
X-MC-Unique: wVJgU4sZOHWBRgHby5L9eA-1
Received: by mail-ej1-f69.google.com with SMTP id k3so3413080ejr.16
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 02:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+RX5uSiRrVlvyzLUv66fuI7aYcwumIOTQtngnkQr2i4=;
        b=I612avNpsmUmtvFyfwNOPrbLIjlrswQwsewOKV0bD7dHf7x6JFLBIIj5RgPUruncYK
         iMAT031TzHH7x0WY1A7WzQw2UCkqLQX1sf0UZ63M44PBH0SLHPZXG9ii5d3fbaeBdFKS
         wMFYdhAROeC5uk4AV/45WILM1uTAA1l2iFnLnaKv3HUs3BW8zneiE7ATxA+eZ+ypvvGu
         xsET0e4ClLiJTIthOzqMIQjyl1vrif9TzrECAV/B62Dv/0m556UqjfCNNUYItitxsC1d
         azQK0PvN40/ZMOQzmo7fKrcXBYA+fA7ZenpbkR8Kjf7gEteVMVuDFOBbPp7vBpG6yuPv
         e0vA==
X-Gm-Message-State: AOAM533W8yFkS7VwU/19J/SHSB98ajOWjXZSt4nT/nbRz8Yh1Sq09els
        rD02/RbESgrR1N+w7qoSsK5ItAk2g84MieKD8ls2F97FoUUBfR3hWAwretWlyFEsLFjtoBURZX5
        qnaX4/uPojEbcA9Ksba9KOEBPoChuRfy8rfrDe5OS83sTHhxARubfLe4yldfB5mC9QZYn61EMbH
        kx
X-Received: by 2002:a05:6402:1d3b:: with SMTP id dh27mr9307311edb.238.1610707231426;
        Fri, 15 Jan 2021 02:40:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZs5Sz7+YFJaD03HU8KCcm+88b1j1m3a3tn8+yo8YaQhzFmQM5f8wIS5j7vGlJ1xHqTLXYZA==
X-Received: by 2002:a05:6402:1d3b:: with SMTP id dh27mr9307297edb.238.1610707231204;
        Fri, 15 Jan 2021 02:40:31 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id z22sm1936703edb.88.2021.01.15.02.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 02:40:30 -0800 (PST)
Subject: Re: [PATCH v6 0/3] AMS, Collision Avoidance, and Protocol Error
To:     Kyle Tso <kyletso@google.com>, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210114145053.1952756-1-kyletso@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <46d0f968-0fe6-3ce2-420d-d1a4d9042d79@redhat.com>
Date:   Fri, 15 Jan 2021 11:40:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210114145053.1952756-1-kyletso@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 1/14/21 3:50 PM, Kyle Tso wrote:
> v5 https://lore.kernel.org/r/20210105163927.1376770-1-kyletso@google.com
> 
> "usb: typec: tcpm: AMS and Collision Avoidance"
>  - removed the signed-off
>  - modified the coding style suggested from Heikki
>  - added FR_SWAP AMS handling
> 
> "usb: typec: tcpm: Protocol Error handling"
>  - removed the signed-off
>  - modified the coding style suggested from Heikki
>  - modified more coding style problems (line wrapping limit)
> 
> "usb: typec: tcpm: Respond Wait if VDM state machine is running"
>  - no change

I'm afraid that my testing of this patch-set has been delayed due to a
5.11 regression which I'm chasing down. I have put a task for this
in my calendar for Wednesday Jan 20.

Regards,

Hans

