Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396021BFD27
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 16:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgD3OKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 10:10:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41493 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgD3OKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:10:36 -0400
Received: by mail-oi1-f195.google.com with SMTP id 19so5296471oiy.8;
        Thu, 30 Apr 2020 07:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UgTzeSieOrk7bgrXOEEKGS4vqDfJdjTM5De/Mq9VpvA=;
        b=JWOX0Ed3jmGp6wkD/eNtW0sqU5QOV1BhW3dIUgQM7c8xKxB+g6ByzsbQdwASNAuaqV
         dKJsenliIraZEhOll/hMYfqgJDHSn/7TFjFjeRi4GlhmaUT6H2rB403f9cOj0cIiQ9KR
         B/jEgrtmPxUqeqkUz7n8oATnC4ewSk7bgz01lmVhEWAj9MEl1INlKdUAXYjdanVBF7jU
         TBSJeSE6dKRa95zhhozKwruww3nXXpk5eg6ZBpxvkoecZayfEm61qSzIBnV0BYk9iU8u
         4bMoFDs8gOdMTaJvs5gyzpmNVnAF70vL8hWsfvY00FnLuAgghoruUfxfLedvYzBcAZXe
         Q+Qw==
X-Gm-Message-State: AGi0PuYpt07znlPgszPB9xCUpC9vutwcJ9pUj/QxenaCyXVobquNemRg
        8Mtylh00FJROHY47QQ8CQA==
X-Google-Smtp-Source: APiQypLd3ij132amZqmzb1pb6Pu49V28sjYMfyg7bc6xj1bapelOBMaB7UdhZBZ0xlBAKCAGhjm7Iw==
X-Received: by 2002:aca:6546:: with SMTP id j6mr29159oiw.155.1588255835409;
        Thu, 30 Apr 2020 07:10:35 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w24sm1346250oor.47.2020.04.30.07.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:10:34 -0700 (PDT)
Received: (nullmailer pid 5452 invoked by uid 1000);
        Thu, 30 Apr 2020 14:10:33 -0000
Date:   Thu, 30 Apr 2020 09:10:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: arm: amlogic: add support for the
 Beelink GT-King Pro
Message-ID: <20200430141033.GA5382@bogus>
References: <20200419055322.16138-1-christianshewitt@gmail.com>
 <20200419055322.16138-4-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419055322.16138-4-christianshewitt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Apr 2020 05:53:21 +0000, Christian Hewitt wrote:
> The Shenzen AZW (Beelink) GT-King Pro is based on the Amlogic W400 reference
> board with an S922X chip.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
