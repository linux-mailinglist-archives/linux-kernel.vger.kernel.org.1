Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27A32FA6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393505AbhARQtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406274AbhARQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:46:01 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 08:45:20 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y8so8929296plp.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 08:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gWMhDo44ZR3+C4BOsL4lbIMiVwUBMpYnSaxiT8xJ5N0=;
        b=HoMAu7DLwqcXPYGShBaY4HCKC3qd9UfakWiUd5GWGyMXaHuyv5VSi2Cu/tXOiG2cvU
         dgMnuEnHtYNQAElQ3lwdFMsfjWJV9282UiaC0usYAtPVF6hVVKPJnYjWrw8NAoEtrqxO
         0mpL2YFWf5T6cNplFyWhpTYKRu4chbO57IFPNAYfwQ1xUWs2AbxJ+zYrk2U0U09nzqf2
         cu4WK87XbaiZ/IS6mvZK6fNC8lRmCIqNIcVaKCIgRiarb5KhWmBbDftzHcetoUCUSkou
         Cg6gpSXihgLZYLqfZDjgxo2xG+8IdAP+gPgptBFY+mJx1bpaejPGpP3m7cbwAY7r3+wh
         +QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gWMhDo44ZR3+C4BOsL4lbIMiVwUBMpYnSaxiT8xJ5N0=;
        b=gyEuqA2FIH3bUTrK+nVfevs4bGpVJ1lWcx2WdXHfb3anSxXVlWzAUyi2YxhJVz9ILK
         s0RTTyabtKBYOZksawIq3JnNvliTwZC++LMkIbNtyJBrcFKfnE3RFLA5pvOUry1lJM85
         hBjjWrYXo2NbOLzgUDOTecDOOk8omGFvFilUnsOe1cQauB4w42ZfYqCw1g4FeskVfxbi
         3wPewtw+qVkiNkKpCIf8n+72KXh240WjfgjqInYqGRcAhs9yt3hymssyJF6LhN7HM5rd
         OqQUW21FYmeIgSDR/c6kHBF8t5Ugdjz4uPeQGZy8TbSWo7mdLP7wLh5neH4kFZos2tAa
         BuRg==
X-Gm-Message-State: AOAM5333rqaErUOxI8ZmQDkfXM75lBLdQEw2TofP/ra12Eppr4KpUpzk
        qUxDPq2BWF8qbjNzL6rR7nKFcA==
X-Google-Smtp-Source: ABdhPJwwN4OSSm1UIVCXTvcb48Zp+y8M/NlnNP4llJe9nG/u3m8GqfL3h9//A/BbVNWx0Bn4gYjyHA==
X-Received: by 2002:a17:902:bcc6:b029:db:e257:9050 with SMTP id o6-20020a170902bcc6b02900dbe2579050mr352911pls.22.1610988320145;
        Mon, 18 Jan 2021 08:45:20 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id i1sm8409109pjl.36.2021.01.18.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 08:45:19 -0800 (PST)
Date:   Mon, 18 Jan 2021 09:45:17 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bin Ji <bin.ji@unisoc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V2] coresight: etm4x: add AMBA id for Cortex-A55 and
 Cortex-A75
Message-ID: <20210118164517.GA464579@xps15>
References: <20210118065549.197489-1-zhang.lyra@gmail.com>
 <CAJ9a7Vjd86q4N3V6EJo=ssM0iNBTFV57SB=YSD4CWyTkUQU5Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vjd86q4N3V6EJo=ssM0iNBTFV57SB=YSD4CWyTkUQU5Ow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 02:19:25PM +0000, Mike Leach wrote:
> On Mon, 18 Jan 2021 at 06:56, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Add AMBA UCI id to support Cortex-A55(Ananke) and Cortex-A75(Promethus).
> >
> > Signed-off-by: Bin Ji <bin.ji@unisoc.com>
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> > Changes since v1:
> > * Addressed Mike's comments - changed to use CS_AMBA_UCI_ID().
> > ---
> >  drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index b20b6ff17cf6..8c4b0c46c8f3 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -1713,6 +1713,8 @@ static const struct amba_id etm4_ids[] = {
> >         CS_AMBA_ID(0x000bb95a),                 /* Cortex-A72 */
> >         CS_AMBA_ID(0x000bb959),                 /* Cortex-A73 */
> >         CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
> > +       CS_AMBA_UCI_ID(0x000bbd05, uci_id_etm4),/* Cortex-A55 */
> > +       CS_AMBA_UCI_ID(0x000bbd0a, uci_id_etm4),/* Cortex-A75 */
> >         CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
> >         CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
> >         CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
> > --
> > 2.25.1
> >
> 
> Reviewed by: Mike Leach <mike.leach@linaro.org>

I have applied this patch.

Thanks,
Mathieu

> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
