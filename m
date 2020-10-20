Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888E529384C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392948AbgJTJiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbgJTJiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:38:17 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F61C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:38:17 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t12so1371987ilh.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQZwsNSiU9VL7BDSnCM9rvnxEFmk0HxipRLqj1HgzZY=;
        b=EfVh6NczMYB41OnAXXD8+yco04T86KiEGP04jjZrKNntDkbYG1d8PLgOyaurm/yqUp
         4laZ1PMF+IqdUrYO0XCNj5yH/zBinpAyxEzt6PPY2XMHg34cQ64v9R0pf+cbTV5L2xXu
         SUHjx9rEqyjNub9NVvDAfRKwH3Bbq66wyPJs1rVKiXb2zk0MG/NgpTZL8emrqq+QnV4W
         ODumcscw7fKvqFoXrSk7D+W5iDgyXopuBtgHMIRtajX1OnSPQGNmFx+DuINaBOgmE26x
         pUlVmDwmDUq7S8BJz7xutW+KNWINDCLG/dzNB7gujzIpVU5k2Ydd0Xkt4gT3jbsnUFwg
         jwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQZwsNSiU9VL7BDSnCM9rvnxEFmk0HxipRLqj1HgzZY=;
        b=jEorI2cZ8UJYdWS07/9dxUe6QAucHlbI0D/sOiLRMDvNF21vWiIp8ucR4lQQJ8n5F2
         U73JNGDxpW3auLqx6jd0xUjTCQ0mDS6Ibpe0HKXQDzGMLx+TVxC1MJ/lCW7Ss4vdVICF
         AE945NZV3+3jVrDQFETGgcM8j+tcTFWMG37qHuNvdCjW6RbBGbn3fXXUDCapvChd8keg
         AXxo2x5XHEK51SiAlGmX4A0ajkfOetOsPX4S3BOdmBJep+m4Frzx68kdp/cEB4jEWzJd
         mz5lXZdAD58wQCRkY3RREiU5tIpe9dyb+IJFYhhYXy6McaFa/Ge/WYNNriHyaZLrQXb0
         MX6g==
X-Gm-Message-State: AOAM533ePEGzABVhEhN68sEursgNja4bqkm6EnrKNM462aKqzGR2G/hv
        hcyMVh8BWQyxVp4jZmlVn1kh0y6yCTbs2vhWm6g=
X-Google-Smtp-Source: ABdhPJyLraQmOVGi+IMto9MyuqYj+0pZpKNX4NQtE+/V7Udl6UIXTZElD4G6Mfjx3Qr8s2xHk4YkgoS1cMmrSRIC4iY=
X-Received: by 2002:a92:180b:: with SMTP id 11mr1236828ily.89.1603186696774;
 Tue, 20 Oct 2020 02:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201012125323.17509-1-david@redhat.com> <20201012125323.17509-16-david@redhat.com>
 <3d85f357-590f-6180-75bc-698a5961c7ae@redhat.com>
In-Reply-To: <3d85f357-590f-6180-75bc-698a5961c7ae@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 20 Oct 2020 11:38:05 +0200
Message-ID: <CAM9Jb+iAGXs2xn235MAjANaXPA_+pkft8rzrSdw34E0Wb+JEiA@mail.gmail.com>
Subject: Re: [PATCH v1 15/29] virito-mem: document Sub Block Mode (SBM)
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Let's add some documentation for the current mode - Sub Block Mode (SBM) -
> > to prepare for a new mode - Big Block Mode (BBM).
> >
> > Follow-up patches will properly factor out the existing Sub Block Mode
> > (SBM) and implement Device Block Mode (DBM).
>
> s/Device Block Mode (DBM)/Big Block Mode (BBM)/
>

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
