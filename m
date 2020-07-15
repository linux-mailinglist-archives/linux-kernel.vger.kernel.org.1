Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F252221412
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 20:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgGOSPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 14:15:17 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36915 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgGOSPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:15:16 -0400
Received: by mail-il1-f196.google.com with SMTP id r12so2819987ilh.4;
        Wed, 15 Jul 2020 11:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PmBnF7DoD1kZyHvLWFAFdH+GQUE7qsucYcrrKDK6qro=;
        b=kj90bc+yXbdDzB+vgWqmYxHRGSAwFPI8pwUD5keLOhXhSkO+L2QoewLdth7isKBLx5
         0Yn2uEqGBKjRgbeSIdzk/4bpi/blFpDKfQe9W/tFsNHti3qw3iyL1wOJ6jgAvppCuWv1
         i7cOZJJ+AeARbynG8/3dPZHubWf4esYKw50nZO2zH5UGHRiV1dJOLbqVg5kS+Hfm83Om
         R1PVZOmFUXS4BBRojQmKVf03QgguDV05PkpfmI3l/u9kn/U8aKlGP1TQVEafV20wRRV8
         vUmZ6Z67V5kwCU0Cvgsydy9NI7B51ReHqhyFxCKiB6OgMrv2VEsiXvEvmCm/nbqSFGNd
         oxvg==
X-Gm-Message-State: AOAM532R4/teA01ukxGzvumEC5ToZ43F5++gBxJvwqzNxREd7ev+Pbzl
        fP+ACUliZgvPIHkO+KkiL+6xZO4Tpg==
X-Google-Smtp-Source: ABdhPJxb2xhUbYj05ZQZVYQe0lPGVbmo4BcPFh3EMY1ZPDkGjNrgsEk1WxfOMZBcR/Faa75viXH2Vw==
X-Received: by 2002:a92:4101:: with SMTP id o1mr749153ila.53.1594836915542;
        Wed, 15 Jul 2020 11:15:15 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k3sm1416637ils.8.2020.07.15.11.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 11:15:14 -0700 (PDT)
Received: (nullmailer pid 550046 invoked by uid 1000);
        Wed, 15 Jul 2020 18:15:14 -0000
Date:   Wed, 15 Jul 2020 12:15:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: Add vendor prefix for RoseapplePi.org
Message-ID: <20200715181514.GA549992@bogus>
References: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
 <b34021779d95a4185a15118e2f13be90f5c4286f.1592123160.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b34021779d95a4185a15118e2f13be90f5c4286f.1592123160.git.cristian.ciocaltea@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 03:19:09 +0300, Cristian Ciocaltea wrote:
> Add devicetree vendor prefix for RoseapplePi.org Foundation.
> Website: http://roseapplepi.org/
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
