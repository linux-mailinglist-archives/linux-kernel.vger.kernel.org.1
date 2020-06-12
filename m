Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1800C1F7ED4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 00:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgFLWRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 18:17:06 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33089 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLWRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:17:04 -0400
Received: by mail-il1-f196.google.com with SMTP id z2so10204647ilq.0;
        Fri, 12 Jun 2020 15:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJtM6TUUgZ0NsS5nwxzOPsUT4RArH9pVS2H787pOfts=;
        b=ajMMrD3y+2Ck7IZsWZrVQrnvVo5goubYER6gs8Tg4TM8bUJgANaN+Zv71mu686GU9u
         +N7V43l12XGj8bo7lJgBkMM+UsUet4F6agyh9y6+At04KM0tbMOzSh/rGZGxgPqd4sD5
         ZcNSoNkrBEwnhsjrUvymyz61ucaXkG5xehGPTVHCdEKlpjVCukCQpjWtB4FhZv+AxB81
         8TSu3VHuZls2kYWuO+kK3ep4VUk6i4OS7oST8fdiTlO8ngouavh0sB2aeKeJZg7KWlZt
         MbmQhP4SuKgf0pv3tguvYIOf7fkCPB5Sz/evF8Ex8omob8OPQsEEYnMZGEnk2wWRnDxO
         JBfA==
X-Gm-Message-State: AOAM532RhsBq7K9wYV8xV49c3iTFtmws4bS97g809uBXeg9mEENUkriw
        nntNoEnCOJdgvtYewAkWP+IiiAk=
X-Google-Smtp-Source: ABdhPJxceJL0d8X9BDVlULnQItsixz2fNFtthKa/xUU8I02pk9qhJxqjcDqeraevcBESW83uuZAmTQ==
X-Received: by 2002:a92:8919:: with SMTP id n25mr14174833ild.158.1592000223384;
        Fri, 12 Jun 2020 15:17:03 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l138sm3916214ill.63.2020.06.12.15.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 15:17:02 -0700 (PDT)
Received: (nullmailer pid 3917505 invoked by uid 1000);
        Fri, 12 Jun 2020 22:17:01 -0000
Date:   Fri, 12 Jun 2020 16:17:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH] dt-bindings: property-units: Add picoseconds type
Message-ID: <20200612221701.GA3916707@bogus>
References: <20200602164219.3159-1-dmurphy@ti.com>
 <e7644623-e9c2-2ebc-8bbd-1bd5dea8942a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7644623-e9c2-2ebc-8bbd-1bd5dea8942a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 02:46:28PM -0500, Dan Murphy wrote:
> Bump

Merge window. Will apply when over.

> 
> On 6/2/20 11:42 AM, Dan Murphy wrote:
> > Add the '-ps' picosecond unit suffix for property names.
> > 
> > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > ---
> >   Documentation/devicetree/bindings/property-units.txt | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
> > index e9b8360b3288..00094070bdac 100644
> > --- a/Documentation/devicetree/bindings/property-units.txt
> > +++ b/Documentation/devicetree/bindings/property-units.txt
> > @@ -17,6 +17,7 @@ Time/Frequency
> >   -ms		: millisecond
> >   -us		: microsecond
> >   -ns		: nanosecond
> > +-ps		: picosecond
> >   Distance
> >   ----------------------------------------
