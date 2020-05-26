Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC67D1C2DB9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 17:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgECPzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 11:55:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42216 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgECPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:55:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id m18so6731915otq.9;
        Sun, 03 May 2020 08:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WURwT71swtVFaN+yXCKfqBj9g3Oagy9nGbGNfJs/ttY=;
        b=sVmA6h6J4CB1KAw8uQ96g4Totm6AT3SPPXCkukpRiwR+bDL/HfsnNZNH2WVh9peyH+
         amCx7MT88z2OVjgyvb05Ud/yG8UkSGYOGQv3FH9AiS2D/gBxTyLudPk8hsQ4m5NbhUKT
         mImK0hppNLH1VwM+UrBY537TfbuBF6Oaz622x3yy+kRi6m/B4Tq5mBHBEy69fb2zSQWu
         ZXzEb96D3HcHM3g1Pov5+XeHuBj1RUKGSE/UlUO4uqYq/99Jv7gXuglYA2o67GOppqVe
         Q1REtlUCMTr2qpfjhUH8VPcC5f8qy//ZcHCpNlWgKm4lq7SAwjxUbM9YzW49kxRHrSBK
         jxLw==
X-Gm-Message-State: AGi0PuZPBoSXfwLnnZ3rFLALPYlA8vwJH/jebDcwafKVqWGE+fYXhhTU
        T6s0nyLIjPWyg7Wi3+QYGA==
X-Google-Smtp-Source: APiQypLPrNKb9hcMJW+6irrNT4WLvGBks0DGiqn8/nZf8bAIh9cn83ZuTnXYpbBuQ8iNoNxoETKjWQ==
X-Received: by 2002:a05:6830:1290:: with SMTP id z16mr11618297otp.78.1588521322109;
        Sun, 03 May 2020 08:55:22 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k8sm2491054ood.24.2020.05.03.08.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 08:55:21 -0700 (PDT)
Received: (nullmailer pid 20149 invoked by uid 1000);
        Sun, 03 May 2020 15:55:21 -0000
Date:   Sun, 3 May 2020 10:55:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v3 3/8] dt-bindings: net: Convert Calxeda Ethernet
 binding to json-schema
Message-ID: <20200503155521.GA20089@bogus>
References: <20200430211054.30466-1-andre.przywara@arm.com>
 <20200430211054.30466-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430211054.30466-4-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 22:10:49 +0100, Andre Przywara wrote:
> Convert the Calxeda XGMAC Ethernet device binding to DT schema format
> using json-schema.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/net/calxeda-xgmac.txt | 18 -------
>  .../bindings/net/calxeda-xgmac.yaml           | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.txt
>  create mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.yaml
> 

Applied, thanks.

Rob
