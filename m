Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77DA2BBF8B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 15:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgKUOOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 09:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgKUOOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:14:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18066C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 06:14:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a3so13086076wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 06:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IWYFKF/mJ+HUJoPCxsHdk7pAqaDwieEIuOGknNJBkGE=;
        b=T5kzv0DqSCFOItJlu9zICD7Mvo71KO8n2HK1FPPMevYCRmL3oFyxfWBoQ3uWLUti+f
         zYUc6sMQvjXZKlrZZaB9hJ+tEX3Fs3JzeqzfxAZEjoJ+duUlL4VOUM79R50TS4F8OGSa
         WWkDEMixMKiqwkbvRco+h5W+IMoW7hTI6XLM4Bt/hN7i1Fr6GGH7w4Jq+2k5KkkI78w6
         8YlFJgB3ZTJW6RjkWOwmJETzneES9a1ANCaykUz4nXsYEVfRNk5AYgzSmClfaUK5ebpu
         IO9NGeO5y06M+Tn+kyVwGen8IJRqa+E8qrcIJOLvXZjZEnxHO0kbNFII5yHeZCB+QUXO
         zKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IWYFKF/mJ+HUJoPCxsHdk7pAqaDwieEIuOGknNJBkGE=;
        b=WO8P9fE9AUwXlEJruDanI9jBWg9cs+kgMpe+hB3EIl4KJmdPDo7MnLfhtwVV6YDpcL
         jpamS/uefTuy4M2HqTlxgoPzrXzaqFsf3TfaID5reGuSGVyZ9+5NEw3iDjmtjld8gKSV
         N7oS2a4nXwRBQIHvayRZ0MMLWt5jhNaELusxQfycPqyWVpysZ0yHM2V/iFnAp7CU+meW
         Kn8/M7AFNR6m116X50V3pYC4K/EMjzniv8gRgmLFidKrZTDIY94BraAtRJ5dhqUaT86T
         FSGSOb5mlKo2fCcG0E3Aj09aYe+4Loq3MpzN04dhq9dVchZqbug5KdGN1pHqRzAqI9aL
         S46A==
X-Gm-Message-State: AOAM533plJSCtQBgGJAq1ysrBTeK1yYTZaCaA+dcBp/twTZaoPTuFndx
        wowF200D296U8We1BjQx6kYBOA==
X-Google-Smtp-Source: ABdhPJwh+gQ2mbKXw8vN5oViDyMNpn5R8RMKiFi8GDqjtHa3AWKn3to7d/4Mu3/AdMYvKrlqx0MukA==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr14764169wme.0.1605968040759;
        Sat, 21 Nov 2020 06:14:00 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id q1sm1519818wrj.8.2020.11.21.06.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 06:14:00 -0800 (PST)
Date:   Sat, 21 Nov 2020 15:13:59 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     George Cherian <george.cherian@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
        lcherian@marvell.com, gakula@marvell.com, masahiroy@kernel.org,
        willemdebruijn.kernel@gmail.com, saeed@kernel.org
Subject: Re: [PATCHv4 net-next 2/3] octeontx2-af: Add devlink health
 reporters for NPA
Message-ID: <20201121141359.GE3055@nanopsycho.orion>
References: <20201121040201.3171542-1-george.cherian@marvell.com>
 <20201121040201.3171542-3-george.cherian@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121040201.3171542-3-george.cherian@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Nov 21, 2020 at 05:02:00AM CET, george.cherian@marvell.com wrote:
>Add health reporters for RVU NPA block.
>NPA Health reporters handle following HW event groups
> - GENERAL events
> - ERROR events
> - RAS events
> - RVU event
>An event counter per event is maintained in SW.
>
>Output:
> # devlink health
> pci/0002:01:00.0:
>   reporter npa
>     state healthy error 0 recover 0
> # devlink  health dump show pci/0002:01:00.0 reporter npa
> NPA_AF_GENERAL:
>        Unmap PF Error: 0
>        Free Disabled for NIX0 RX: 0
>        Free Disabled for NIX0 TX: 0
>        Free Disabled for NIX1 RX: 0
>        Free Disabled for NIX1 TX: 0

This is for 2 ports if I'm not mistaken. Then you need to have this
reporter per-port. Register ports and have reporter for each.

NAK.
