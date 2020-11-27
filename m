Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396D42C63DF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgK0LXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgK0LXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:23:37 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2244C0613D1;
        Fri, 27 Nov 2020 03:23:36 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m6so5194946wrg.7;
        Fri, 27 Nov 2020 03:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LhhiEW4KSlNFZUbpyyVfomsLPj+WD51ZBQLOEOaXXA4=;
        b=VtMIQeonz59RDuOkHzr0iTf6DwQwS647PwRLUPfmoqqVOmnzv6KGmYvJ17YWGeOIq3
         Nqu2yCrgPZw9CEYtmxwL6wY8BKOUmEr3ZF2jr8l7SZrkpgMVll+OpErOCwsGVoWJhsr3
         rZQDX9Nz3dlAE2kc3o57fDUVfeacBzA/mWByrHSnx6KVZ+YFhEnDKanZ9sMawAjSc2U/
         xxYAJvSLxg+yZMkFmStdOS66jcl+whTAwofjIvBZtQJTbO8HvqKXUC3Lif2Cxg5YTaWc
         pnLv8GRqnAAj8YtqRiWoagqRTpTM5n7nPuitC0RhvUPK8CkRyOM5o1wvY967JJBSue5c
         rlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LhhiEW4KSlNFZUbpyyVfomsLPj+WD51ZBQLOEOaXXA4=;
        b=rNpfm67+baobM2yxXZ4fa8Efx4cCaMbiLj0ln3yEGWZ47rJBfF7xZ+Bx40m4v6xsBp
         OnWAxD5X8QyrardF7jZybNfgdxlg8UvbpSlzmosrMACLL8tTDW413DESpXiECAhHw4Ua
         rpCCJOfOA7X2n5pgsNnvverQj+Ue364ZvoTLKTXVZd0952x4HHVG02/5UF2KjgMs2qup
         8aQD2rEkODip747Lpk2Rmq/suwzeyS4h7gOxAuREl3/VV/sVvz3GfGW/3oGmqN+MkHkR
         +YkX7Pf69WwwXMuC3i9Cl8OeDjG6ggUWtT6lvJgUix7WwQjroS/3nI3oc79dJCeIjCC7
         b+AQ==
X-Gm-Message-State: AOAM531tPzyJfRxwHVyQ2Eql72txswK0ng9VWpAzbqdZ6jG0kPCR4i3+
        /+ULXBHXTIjxTa25bdBo8tY=
X-Google-Smtp-Source: ABdhPJxY/2/QR/4yr5F1mQgU87OQIFws27IhKyl9W840Q9+BZaUu+NSpgPsf2FlkbuSiMwOT17tYFw==
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr9851504wrs.75.1606476215624;
        Fri, 27 Nov 2020 03:23:35 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id v6sm15302413wrb.53.2020.11.27.03.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 03:23:34 -0800 (PST)
Subject: Re: [PATCH 0/3] arm64: dts: mediatek: Add dsi and display support for
 MT8183 based boards
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201127104930.1981497-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <96ae2394-ed66-f233-e858-00890813793c@gmail.com>
Date:   Fri, 27 Nov 2020 12:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201127104930.1981497-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/11/2020 11:49, Enric Balletbo i Serra wrote:
> Dear all,
> 
> The following patches add the required nodes to enable dsi and display
> support for MT8183 based boards. The patches were tested on a Lenovo
> Ideapad Duet with an out-of-tree patch that enables the display for that
> board.

Applied to v5.10-next/dts64

Thanks!

> 
> The patches depends on [1].
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=374013
> 
> Enric Balletbo i Serra (2):
>    arm64: dts: mt8183: Add iommu and larb nodes
>    arm64: dts: mt8183: Add display nodes for MT8183
> 
> Jitao Shi (1):
>    arm64: dts: mt8183: Add dsi node
> 
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 224 +++++++++++++++++++++++
>   1 file changed, 224 insertions(+)
> 
