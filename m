Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F6D2523AE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 00:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHYWbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 18:31:52 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40114 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHYWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:31:51 -0400
Received: by mail-il1-f195.google.com with SMTP id p18so137383ilm.7;
        Tue, 25 Aug 2020 15:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z76vAXbQc6SQMGZuDrl6BPLV3aZwglI6Z7tRuBobsXg=;
        b=KPV9lJKfeXoW/gbhezLAKv3/pePNPuZ7sjLn4wXoahsqb5KXRIOmG0OW/D9L86Zv91
         V0IY65eYJSGDRiFXERpDVrDeMMDdz1n0/DA80CtAFKlDuyOaEYfBGkn4oHZpBy/Mjp5U
         3dNTxC83uz+9it7PBBjEcaIkrqlqN++Lg3FkhxRdYnVuMmbJOkAszBpcRz+js6VgZctx
         jN9WMyCWDNE1Ln/oU2UaQ2O5X1GLlHFdTxpGiNkleP94Yd9k0jN9S1vNYoR4TPi2Wyss
         5yDvNw9CIY7YKmgyritT+B+Tk07ibGTVcKzaKoyYkVy5PW1p9RPS3V4ghiuW86XnipgQ
         CUhg==
X-Gm-Message-State: AOAM532rof61gaywS/kQ6n0kMEFyMH9D7KFMwvMZ0Skc7l1qQwUg36qJ
        qwxnHJ0h8peoP3xe/7QvedjRvOACrsehBME=
X-Google-Smtp-Source: ABdhPJzBT0frZFOJQ+HzZsP06jO7+Y9mywlOa6x5j9kOJq6tGbmP+8DCdWWEGaxDuuCzqd2erNowsg==
X-Received: by 2002:a05:6e02:134e:: with SMTP id k14mr11015304ilr.271.1598394710892;
        Tue, 25 Aug 2020 15:31:50 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id f9sm233581ilk.32.2020.08.25.15.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 15:31:50 -0700 (PDT)
Received: (nullmailer pid 1465667 invoked by uid 1000);
        Tue, 25 Aug 2020 22:31:48 -0000
Date:   Tue, 25 Aug 2020 16:31:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Atte Tommiska <atte.tommiska@xiphera.com>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: rng: add bindings for Xiphera
 XIP8001B hwnrg
Message-ID: <20200825223148.GA1464468@bogus>
References: <cover.1597914503.git.atte.tommiska@xiphera.com>
 <d385a6e0f8edaaf7c8a26eb45fa0a4608d029b13.1597914503.git.atte.tommiska@xiphera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d385a6e0f8edaaf7c8a26eb45fa0a4608d029b13.1597914503.git.atte.tommiska@xiphera.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 01:51:21PM +0300, Atte Tommiska wrote:
> Document the device tree bindings of Xiphera's XIP8001B-trng IP.

typo in the subject. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Atte Tommiska <atte.tommiska@xiphera.com>
> ---
>  .../bindings/rng/xiphera,xip8001b-trng.yaml   | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/xiphera,xip8001b-trng.yaml
