Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25182D50BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgLJCPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:15:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40958 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgLJCPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:15:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id p126so4071708oif.7;
        Wed, 09 Dec 2020 18:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9JLcr6LeSb9voq7wy4mQhKT2jzcf1oDtqn4kdBVAecY=;
        b=IgbTnUScvp+0874sY3AomTGBwyamG4x8g6dKObIkwKg9jd5Q1nK+b50vShm0LnafhW
         sydLB1Puavo+FoUMEL22gYQnTyp/E6kwYLCxGGmFMP77pXyCzRvNlyccLT3ZdEKiwm98
         b9ffhFT0nEZ44B71GpC/iMgP3oPQTsePhM0ArqRTHRfFl5Tr+knsP11gKfhdT4fDAS9B
         +qoTZ57NDlzjE8ygKH4bnLRNg0/3thAp7cqS/kXGKqtRW5u0MkT5iyYrdtkogilmIMfa
         PleuY5JT+8Z63i4S+lar1St8409eI1ALE9XOPZPffEJTgaqXNW73nZd4D9ZC+xwK87s3
         YFNQ==
X-Gm-Message-State: AOAM531zkamVuWJQeZmjtOZl9iGoZavfLL6zuUBnULYTdcATr0vUcLWg
        iQPJeVinardNBKa4uG13Vg==
X-Google-Smtp-Source: ABdhPJyB9iL6bL23r7xj0mPiLyQxHQwMseB04PFt+U7EXILIsb7/lSIgWi37Ud8lF1Kyj72CxwQzsw==
X-Received: by 2002:aca:b256:: with SMTP id b83mr4083635oif.77.1607566462214;
        Wed, 09 Dec 2020 18:14:22 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i82sm708046oia.2.2020.12.09.18.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 18:14:21 -0800 (PST)
Received: (nullmailer pid 1496561 invoked by uid 1000);
        Thu, 10 Dec 2020 02:14:20 -0000
Date:   Wed, 9 Dec 2020 20:14:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: correct the spelling of
 TQ-Systems GmbH
Message-ID: <20201210021420.GA1496510@robh.at.kernel.org>
References: <20201207093036.29824-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207093036.29824-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 10:30:36 +0100, Matthias Schiffer wrote:
> From: Max Merchel <Max.Merchel@tq-group.com>
> 
> "TQ-Systems" is written with a dash, as can be seen on
> https://www.tq-group.com/en/imprint/
> 
> Signed-off-by: Max Merchel <Max.Merchel@tq-group.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
