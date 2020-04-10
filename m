Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C758F1A4950
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 19:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgDJRjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 13:39:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41403 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgDJRjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:39:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id f52so2501023otf.8;
        Fri, 10 Apr 2020 10:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dA79p/fJYP1exJyfDyndCj6b9oBdHgsFtR15+WKLmA=;
        b=KXeQdKkADYWKcnZqXN1VzyKADRNdyTWUYZFvQDL84YBE6o1gjop3iJO4xq3kzKP39/
         su4kTNRpJGlb6F9i462izwFioO/MU+JUBm6JNazX0zUwF7ct4QTeNiK0sekxfKBURbEE
         ZKMEzzc1p7kquWjGYLRl4D8Mi0j20BuCS4v/t9Bk62g6Wij6AI/wkei69jyAp25Y3JDO
         ww5fZN0ENVAnxpTI7Ow7026LxBalL4lr6i8hxPSXSJoZjjfeRiqk83bN3VTItyxZGUua
         yrkXFaKOgJaNEq0dQ222DIiFZFKcvnh11c3NbPqFWMzG/9/UKmo6xFQvtiDtWe5lbe/R
         E6bg==
X-Gm-Message-State: AGi0PuZ3jub7NTSMwAxjLsK65buh0xVudJNoLNov2BaPg19OKxWseVVm
        a+jcMjt2pBnyw5NysYmGwA==
X-Google-Smtp-Source: APiQypLnV0lWs3/a0m0yM5wOMFXyJ6eGdqLn+x7dWPvHkUdeb3HuMNfRq1B+n0WGttYYQQyMwRIjFw==
X-Received: by 2002:a9d:2056:: with SMTP id n80mr5211844ota.281.1586540338638;
        Fri, 10 Apr 2020 10:38:58 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id x17sm1544589oif.28.2020.04.10.10.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:38:57 -0700 (PDT)
Received: (nullmailer pid 23157 invoked by uid 1000);
        Fri, 10 Apr 2020 16:37:18 -0000
Date:   Fri, 10 Apr 2020 11:37:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/5] dt-bindings: sram: Add Amlogic SCP SRAM compatibles
Message-ID: <20200410163718.GA22705@bogus>
References: <20200326165958.19274-1-narmstrong@baylibre.com>
 <20200326165958.19274-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326165958.19274-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 17:59:54 +0100, Neil Armstrong wrote:
> Add compatibles for the Amlogic SCP SRAM memory zones.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/sram/sram.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
