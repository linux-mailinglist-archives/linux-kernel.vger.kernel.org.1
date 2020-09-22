Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE484274BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIVWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:20:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35144 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVWUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:20:01 -0400
Received: by mail-io1-f68.google.com with SMTP id r9so21534288ioa.2;
        Tue, 22 Sep 2020 15:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJgPG9nFqKSPj20PO+Q8aRuzKhCzolUfMEd72+sKZ5Y=;
        b=h+gdW6YyQ6gkbUOs2rUcic2zgQWU5trRYr0gZcUEa0nMTPTdSFFtDkmxkPX0NCnXkK
         Rk1d5ey/IH8e+y0rEY4oetUiEwLloTNuct3YqA5JwsWC3Bq9ZEahTQhVTI2/Hd0sOIj0
         unzbu5kZRnLIWce/mN9gA/4G6qIv1BmtMLfAJ5L5p0E6pvIIaR4wQPOuNAg/bZ6fuJwl
         wLkgg5ZJ4gqi9Hs3i+HcC7JP2a+Ou8/e+kgc68hghSS4WphxURbZSXyDcwSHNdmyeocQ
         APh58y0Sp4atvXpGaLNius40/ysG9wWamGuSNtz9/vpfLcykQv8dG+4uJI4yiSmAVLIi
         G1Kw==
X-Gm-Message-State: AOAM532zvP0H8iizdxQqVR5g9LJjaoX0VIaIqRalGkHJcG2kaAhMYqTa
        F7JfX0+B9JH/mzit4d3Jfw==
X-Google-Smtp-Source: ABdhPJwI8vrDQOMurbkEIJAIiMEuHNothuYJbyAYzDNUdEu7xESwerwBj5XmYNhkRLLhSI+/FWzz6g==
X-Received: by 2002:a02:1a83:: with SMTP id 125mr6048477jai.48.1600813200316;
        Tue, 22 Sep 2020 15:20:00 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s1sm9701286iln.22.2020.09.22.15.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:19:59 -0700 (PDT)
Received: (nullmailer pid 3360327 invoked by uid 1000);
        Tue, 22 Sep 2020 22:19:58 -0000
Date:   Tue, 22 Sep 2020 16:19:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org, sboyd@kernel.org,
        alistair@popple.id.au, andrew@aj.id.au,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        jk@ozlabs.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: fsi: Aspeed master: Add bus-frequency
 property
Message-ID: <20200922221958.GA3360267@bogus>
References: <20200910151840.25333-1-eajames@linux.ibm.com>
 <20200910151840.25333-4-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910151840.25333-4-eajames@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 10:18:39 -0500, Eddie James wrote:
> Document the bus-frequency property.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
