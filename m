Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1CF1E335F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 01:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392103AbgEZXFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 19:05:43 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43073 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389565AbgEZXFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:05:42 -0400
Received: by mail-il1-f194.google.com with SMTP id l20so22164998ilj.10;
        Tue, 26 May 2020 16:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2oYPgM1BtR439Mfpid4h6QvwH7miODS6soRM9HPdtmM=;
        b=VeqJDgrql00O53CQ8fGVzNG/iYrcwCF1W1FS6VkiyYTS+Ry2BSJsVhNsg0CMa/uloJ
         whNPE2AvQ9u4Lr+CDh0rAk+kq+rWzBa2u9/jg0DGKC76A+IHS7VRjtEfMQzK5lzlwnbR
         QNXKVWzXZvZ5zXXbL1qHShC8gtxZv/HBOjcVLjEMtTHkWR3Qt+kMDXgItsZ3UtVckpN5
         TeGAj4+znjxi++5jvkOWcPxWzM3KPJ3J4csu+p9y5GnFCLWgtG/2Mu3OZ95Cg32lNXrh
         tVwESVhDu0qxJPvMHJbNR49KAH5CeDfrtQkKJE98phFTaDIRwHBBeKjR2tg/OuKAXNLY
         AQxQ==
X-Gm-Message-State: AOAM531JCwHaK7XZQQE+MKIr7itlhsiJe+GSyEWnkWnWFcD0aUope0wv
        +PZHZF8fi6eF7+N/T5DomQ==
X-Google-Smtp-Source: ABdhPJyBcSvWgTEJyZu7WnBFc0wCdUtMbWcguCU5wrtNSwGUZAEBzYVIN4zA/3rvIXr6KxxEurglbw==
X-Received: by 2002:a92:c742:: with SMTP id y2mr3207192ilp.126.1590534341592;
        Tue, 26 May 2020 16:05:41 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 4sm722115ilc.34.2020.05.26.16.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 16:05:41 -0700 (PDT)
Received: (nullmailer pid 558228 invoked by uid 1000);
        Tue, 26 May 2020 23:05:40 -0000
Date:   Tue, 26 May 2020 17:05:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 09/13] dt-bindings: clock: Make marvell,mmp2-clock a
 power controller
Message-ID: <20200526230540.GA557537@bogus>
References: <20200519224151.2074597-1-lkundrak@v3.sk>
 <20200519224151.2074597-10-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519224151.2074597-10-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 12:41:47AM +0200, Lubomir Rintel wrote:
> This is a binding for the MMP2 power management units. As such apart from
> providing the clocks, they also manage the power islands.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v2:
> - Added this patch
> 
>  .../devicetree/bindings/clock/marvell,mmp2-clock.yaml        | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
