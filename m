Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC8E81A381B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgDIQgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 12:36:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33389 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgDIQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:36:25 -0400
Received: by mail-io1-f66.google.com with SMTP id o127so243838iof.0;
        Thu, 09 Apr 2020 09:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=obJzJn/9ATJzLF22GIU9tDOuUBYY5RgcTfjfIGtO6pw=;
        b=A6xeAxpkNiFact8iSO5vKcIvaBzWkWcX2vQR54cu/8dxJXqPx+Fm7y1Aeg4jGtJ3SK
         po37Wac8C7j11MWrvIuoRQG8SByAXBRDGKfTJPsfqLOpRKMJsK1YaZYEsquKD53gHbTD
         XWG+e0pPMb6oSlS6Wtuh1kzKjRdUqHPwCzICcf3aoF4iAYW+nl7txpZDdE6uC8xxbOSW
         u/Fb6pXJ3PenVYb110BOELrbdyMncdqG3mVD9F6DWER2KIN9O7hRyejAGxKznHQzZtHV
         9piJaecEMIOV35Il5hTmYTm9ouQ89yDRRWo1aizotnduWJoq3eeqGGwwDxfBh3FhlD8G
         DJ5w==
X-Gm-Message-State: AGi0Pua3Y9bZ+fZBkKChuH2Jv2A/2P0i3ADbkQQlDVs6c5IhgxYjnETG
        1W2ShAYKtHlO/QPFkjB5Ow==
X-Google-Smtp-Source: APiQypJafzlDGxoW+PJWxSbYf96R+/W/fyCAo4cBla5lhCPh3XAypIgk0uPoivb5zBTXQuZ8OkE55A==
X-Received: by 2002:a6b:3783:: with SMTP id e125mr28986ioa.188.1586450184721;
        Thu, 09 Apr 2020 09:36:24 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r18sm1793650ilo.18.2020.04.09.09.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 09:36:24 -0700 (PDT)
Received: (nullmailer pid 10601 invoked by uid 1000);
        Thu, 09 Apr 2020 16:36:22 -0000
Date:   Thu, 9 Apr 2020 10:36:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: BD718x7 - add missing I2C bus properties
Message-ID: <20200409163622.GA10546@bogus>
References: <20200406073008.GA13084@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406073008.GA13084@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020 10:30:08 +0300, Matti Vaittinen wrote:
> The DT example needs #address-cells and #size-cells for I2C bus or
> validity checker will generate warnings. Add these properties in
> BD71837 and BD71847 binding examples.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> This patch was created against Lee's for-mfd-next branch. Please let
> me know if this was not feasible.
> 
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml | 4 +++-
>  Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
