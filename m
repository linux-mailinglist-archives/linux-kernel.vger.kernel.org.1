Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AF8227262
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 00:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgGTW13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 18:27:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41680 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTW12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:27:28 -0400
Received: by mail-io1-f65.google.com with SMTP id p205so19295094iod.8;
        Mon, 20 Jul 2020 15:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dmZWPiwMYUt+IEOD9Wmpq4+HBAIL3pN57wPHpCepilk=;
        b=NVgjAt10Bh+KGXIpX9dITjy+osGa6XRraIDegnMKhiACafJJDKDj5incm/9RRzqJcb
         /pf+Zvl133Mt9whgbBQVZKzyCJ9NlU8LrvjSLiTqD2XG0ZyTKBPdkS7oXl6kHJ46eFnQ
         PGM+6PX/RmUxtnXwD6Cz7pQyquzt54SnJ7GgGsDU/0F6NxnsI2ZGgz4doct9qFVNV6DB
         4zxQjgC3gC1SKkYLXiu0+YXFvobC2L7Sm17Spi7c3TCrtqm8SFUck9aFAPPOb68tHxwi
         vPVpAriaUwq/KCJewWhc0YVC2f+oRdmqvq1XmlIQ0jg3qFqdu5GXP0HIXbZHfEoKVTR2
         VdTA==
X-Gm-Message-State: AOAM532iegcP7sCMAY/HtiSF0udAiphoI0R27ifhYc+aMh1tboDtkAv3
        WEMv7+32cwbKFgMARE62sA==
X-Google-Smtp-Source: ABdhPJzT/wiVQZfvilkAhuT/SHp5hylwqI28PubTIp6kEeIwB33d4SeJdoyIdotXOPRW4VF+nUs4vw==
X-Received: by 2002:a02:c88c:: with SMTP id m12mr14461904jao.2.1595284047756;
        Mon, 20 Jul 2020 15:27:27 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c7sm9727477ilo.85.2020.07.20.15.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:27:26 -0700 (PDT)
Received: (nullmailer pid 3063847 invoked by uid 1000);
        Mon, 20 Jul 2020 22:27:25 -0000
Date:   Mon, 20 Jul 2020 16:27:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Chu Lin <linchuyuan@google.com>, belgaied@google.com,
        jasonling@google.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqil@google.com
Subject: Re: [PATCH] dt-bindings: hwmon: adm1272: add
 adm1272-adm1275-temp1-en binding
Message-ID: <20200720222725.GA3061855@bogus>
References: <20200710004258.296017-1-linchuyuan@google.com>
 <20200719222222.GA78762@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719222222.GA78762@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 03:22:22PM -0700, Guenter Roeck wrote:
> On Fri, Jul 10, 2020 at 12:42:58AM +0000, Chu Lin wrote:
> > Problem:
> > 	adm1272 and adm1278 supports temperature sampling. The
> > current way of enabling it requires the user manually unbind the device
> > from the driver, flip the temperature sampling control bit and then bind
> > the device back to the driver. It would be nice if we can control this in a
> > better way by reading the dt.
> > 
> > Solution:
> > 	Introducing device tree binding adm1272-adm1278-temp1-en. If the
> > flag is set, flip the temp1_en control bit on probing.
> > 
> > Testing:
> > make dt_binding_check
> > 
> > Signed-off-by: Chu Lin <linchuyuan@google.com>
> > ---
> >  Documentation/devicetree/bindings/hwmon/adm1275.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/adm1275.txt b/Documentation/devicetree/bindings/hwmon/adm1275.txt
> > index 1ecd03f3da4d..4403fe30f005 100644
> > --- a/Documentation/devicetree/bindings/hwmon/adm1275.txt
> > +++ b/Documentation/devicetree/bindings/hwmon/adm1275.txt
> > @@ -15,6 +15,8 @@ Optional properties:
> >  
> >  - shunt-resistor-micro-ohms
> >  	Shunt resistor value in micro-Ohm
> > +- adm1272-adm1278-temp1-en
> > +	Enable temperature sampling. This is supported on adm1272 and adm1278
> 
> I suspect this should be something like "analog,temp1-enable". 

Yes.

> Either case,
> I would suggest to resend the series and copy DT maintainers at least on
> this patch.

Only the DT list matters.

Rob
