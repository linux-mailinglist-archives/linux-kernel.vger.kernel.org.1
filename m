Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA842F9767
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbhARBoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbhARBnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:43:43 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE47C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 17:43:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v1so8459268pjr.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 17:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z0CCc/Q0ksa1TWlIDKNldNTNgYekIptHEj3JiZuvXRM=;
        b=intyiid3dU/Q3TO11c8luW2cUrMy1xoCdlDwSzOdDQf9ETy4WDCWMls6nE2rflUL4w
         JKQQcHLsKJ+5iM/9yx/umo3Ci9GKw0Q8v7+We56PaKHytEgIHwgL5HS/ODhZrBY6r2Zf
         hqbTy2Ko0EbzlkiODLE4akAP4C8tx/TcL4yNDMLBpvtRGYfuhAqMzpoxj3oL4QACYVkS
         sYglssWvyaU3HmHpX6hzZaTINHj5vOKwvzOBzbiKJym2MQLJUKdSxHYjC8u2WSPN7KvW
         ontWl0LxDUmt/pUDWhVqUr104Jf9co/TiZ/a3NmGLI35zjA1Mn67LMzqt1Mk5eaVv4co
         7Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z0CCc/Q0ksa1TWlIDKNldNTNgYekIptHEj3JiZuvXRM=;
        b=bA4w0JdOC+cfr6g7Muh7/iLWxVECpu7J+g+1INiAUwibkQ77XETqm3oJhQPYYJ497M
         cFg+K92ViuluocDTTauZKuzOA34iqswEZGgHEt2tXJ2Nolni/K7Wqkq4R2Jb8UQWYRQL
         +LOemYR1FHysKoIcjuKsS0ScfGRPkz5phs5vhuUVcs/+N8FQHnuatpMC5AzigN5tC6yX
         wTtY6wq1cD3+ED0LpWwS18vkwOxBEh06w5cuf60xGrw0FJwSCVZ9dyoKxPB8/wmDvdfk
         u7GRlhgs6AnMXzwcujbgJsrIS8N4VDJ3gvZl7PHrnc7zs6ztFo1bp2DE2V75oBkuPdHE
         dkMw==
X-Gm-Message-State: AOAM533NTJAhyBhIy8VVGie6Ys8FfOEkolXwpHizXuxVcu9aWL/z5eO3
        hAfRvEAintNW6uw/nkuKVBsB8lV1MrzKf9E8yMA=
X-Google-Smtp-Source: ABdhPJzuvOJY+AZ+TZheP1ZbLItDsxrcHX0qkVGHdNJVK0bzAtxk2zoQZVY6ClihlgYDHsEZTMZtnQ==
X-Received: by 2002:a17:90b:107:: with SMTP id p7mr14503911pjz.110.1610934182794;
        Sun, 17 Jan 2021 17:43:02 -0800 (PST)
Received: from [10.2.218.189] ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id e29sm14685309pfj.174.2021.01.17.17.43.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 17:43:02 -0800 (PST)
Subject: PING: [PATCH v5 0/2] misc: pvpanic: introduce capability & event
 attribute
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, pbonzini@redhat.com, linux-kernel@vger.kernel.org
References: <20210110115358.79100-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <cee80030-dab1-fe79-f14c-24e45532d814@bytedance.com>
Date:   Mon, 18 Jan 2021 09:42:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210110115358.79100-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg

What's the next step I should take?

On 1/10/21 7:53 PM, zhenwei pi wrote:
> v4 -> v5:
> Use sysfs_emit to export attribute value.
> Only allow subset of capability to set on events.
> Add more detailed infomation in document.
> 
> v3 -> v4:
> Use event sysfs attribute instead of module parameter.
> Use driver dev_groups instead of creating files by sysfs_* API.
> 
> v2 -> v3:
> Seperate the function to 2 parts:
>      1, use sysfs to expose device capability.
>      2, add a module parameter to set limitation by user.
> 
> v1 -> v2:
> Remove device info log, use module parameter to expose capability.
> 
> v1:
> The guest sides determines pvpanic capability by RDPT, before kicking
> host side, check the event is supported or not.
> 
> zhenwei pi (2):
>    misc: pvpanic: introduce device capability
>    misc: pvpanic: introduce module parameter 'events'
> 
>   .../ABI/testing/sysfs-bus-pci-devices-pvpanic | 14 +++++
>   drivers/misc/pvpanic.c                        | 58 +++++++++++++++++--
>   2 files changed, 67 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
> 

-- 
zhenwei pi
