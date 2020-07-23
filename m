Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A286F22B4F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgGWRgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 13:36:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45517 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgGWRgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:36:06 -0400
Received: by mail-io1-f66.google.com with SMTP id e64so7090916iof.12;
        Thu, 23 Jul 2020 10:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fx4eyYCHy8mVK/VaWben4DtpHbe1xdrgwItFtQ1OKzg=;
        b=Z8Ujg6mSZ6MmgDY+y4e0m8VtMD+carSySxA4AuALDNYX0yEUXYDgXKRPFXXiFrnyou
         3cz3mZNPXmVnTshuzMhiqmtdwAOg0W0ugfJVWNIU329wCEQLUQk7CM/QcZGDMIftSwE8
         d1Ekh0YMkXInz9egXmJcEKRN6TSFLaDz3x/wsKgMeiWCzPyZy/dLxSy4WD1Auxcl1YkD
         p2uRL8Rx4wNnLqKoIJXirDOW+SC+5H4ofxqmWo7fBVslFTGtFKM+yxD1q77LegL+iKya
         HNfgrcC8/CPX9cWJL775jX2ptuhG0oaqonYZjKMycKVfsq8YltaM2rHnXcwlnzsE9B6Z
         J3sg==
X-Gm-Message-State: AOAM530//T99u16tqAH2VlgeBzy1VL+EeQSKoStI7cQ+XhBHBrcm9TR1
        3SbgKqqYLTHyPHcXBjncKA==
X-Google-Smtp-Source: ABdhPJzdX5z79RM3bXe10ijc8z8ChiWo0JwO9GDOX4k3gOWYH4jiGol36S+mGz02KAnlNJDcSbQIFw==
X-Received: by 2002:a05:6602:24d5:: with SMTP id h21mr3054531ioe.108.1595525765831;
        Thu, 23 Jul 2020 10:36:05 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y24sm1838390ilk.52.2020.07.23.10.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:36:05 -0700 (PDT)
Received: (nullmailer pid 580799 invoked by uid 1000);
        Thu, 23 Jul 2020 17:36:03 -0000
Date:   Thu, 23 Jul 2020 11:36:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: Add vendor prefix for Shenzhen
 Zkmagic Technology Co., Ltd.
Message-ID: <20200723173603.GA580768@bogus>
References: <20200718105343.5152-1-jbx6244@gmail.com>
 <20200718105343.5152-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718105343.5152-2-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 12:53:41 +0200, Johan Jonker wrote:
> Add vendor prefix for Shenzhen Zkmagic Technology Co., Ltd.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
