Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93BB1E846B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgE2RMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 13:12:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44702 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2RMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:12:55 -0400
Received: by mail-io1-f65.google.com with SMTP id p20so85342iop.11;
        Fri, 29 May 2020 10:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OHboqWMkmK+OdNhD2uMZssxmLRKtctZdJ9sUpoYFPYE=;
        b=UXvZJ+Z5MOXTkzwsmXj3ycvjVjVOSS+M0fUy7f0yXsrccufwxPHcZCNlY9aaFb+Vx0
         3uhwYtSbJWPJP564Y1AeaZa9yWiKOfglXHA+p8t0ebram4KG0LDdq9A5WdZNrdvLriI9
         4tmocT/GW5XM/1je7/Oo6cSR+cGKWNZjBjz5ikbkvv0W2d7BNHppBEYSJwMlU43riFPS
         ZSDaOp+PCSALDtzW4Z4njbDca9pK95Ahd2Sd4FvdB9iRKqVJg/f4F7zUtIniBn7H7t74
         TEE9otwjhRNAkvJCS4EJZcf/7R2MX/bXd0ls1INPxsPiwpG00q0e8WmxdaXnLsC2z8bv
         M4Wg==
X-Gm-Message-State: AOAM531FF2LRpa+YQTfha71O4iiZ9COawKjhI+6b0qMgCn9au7HlJjWT
        E9qnGGpJ83/BXmx9Dtl3RQ==
X-Google-Smtp-Source: ABdhPJwCK68hjzDmx+3jO6TN/lJaHhWps7pZAkAFpT9RDl6ItRCQdn4wbdNHxIr6BicDwl6Ya1pdUw==
X-Received: by 2002:a5e:de03:: with SMTP id e3mr7483688iok.0.1590772373822;
        Fri, 29 May 2020 10:12:53 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id m12sm3311284ili.41.2020.05.29.10.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 10:12:53 -0700 (PDT)
Received: (nullmailer pid 2587417 invoked by uid 1000);
        Fri, 29 May 2020 17:12:52 -0000
Date:   Fri, 29 May 2020 11:12:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Olivier Sobrie <olivier.sobrie@silexinsight.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, Waleed Ziad <waleed94ziad@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        sebastien.rabou@silexinsight.com, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Silex Insight
 vendor prefix
Message-ID: <20200529171252.GA2587363@bogus>
References: <20200525195606.2941649-1-olivier.sobrie@silexinsight.com>
 <20200525195606.2941649-2-olivier.sobrie@silexinsight.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525195606.2941649-2-olivier.sobrie@silexinsight.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 21:56:04 +0200, Olivier Sobrie wrote:
> Silex Insight is a microelectronic company whose headquarter is located
> in Belgium.
> Web site of the company: https://www.silexinsight.com/
> 
> Signed-off-by: Olivier Sobrie <olivier.sobrie@silexinsight.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
