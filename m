Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E37B2E821A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 22:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgLaVN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 16:13:27 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43970 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgLaVN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 16:13:26 -0500
Received: by mail-oi1-f177.google.com with SMTP id q25so22900520oij.10;
        Thu, 31 Dec 2020 13:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ky5e7ecpOimYlfmbzBD6g0sIwpx6DlLamHwFPdO7WyU=;
        b=PBaCSqa5arFA4DXKLS9huSzh++4DUKAy4ZvlPaKTeAhGFoMepkNux4rN82h5nqr1eM
         ZLGY1YiNTdj9jziC8gPK7A7bqIkO5cfZOWLzZYm0Wi09OOzVwTwYxzLd+gIOlcj82ju/
         eKPRje64Tos93uvDZDNvqO+cwmZfD0NkSbJonDgZkadEltGb3GE140b1qWCO3F3S3iuz
         72/w/wW4EtkaA+ZjN//imtxWZEzMN0njmRQXjIODWAawdF8zjdhGUUCzwW4RZq/TxAdb
         +GD40FK2cTdEB2G1yoGNZ3DFgeL6U+MyOmEJC1n/7qhh5j+X5Pey/fp0NQPPooCpOIq9
         vIwQ==
X-Gm-Message-State: AOAM533ezh9tLKP18J+Sfxw8bU38qSMWRwEo1o9NoGkxQY14OEHBnV2t
        XuquWEKXAV0IG4EjCULIeA==
X-Google-Smtp-Source: ABdhPJwVnHsbzNBDhz5mmMwLcNOxr5M7CDDKCjDghURi0obod+G9XpfZn+7RNg7vvYhZ2HjaHlYIrg==
X-Received: by 2002:aca:3dd5:: with SMTP id k204mr9286153oia.32.1609449165320;
        Thu, 31 Dec 2020 13:12:45 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r25sm11639467otp.23.2020.12.31.13.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 13:12:44 -0800 (PST)
Received: (nullmailer pid 2374456 invoked by uid 1000);
        Thu, 31 Dec 2020 21:12:40 -0000
Date:   Thu, 31 Dec 2020 14:12:40 -0700
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: Add device link support for interrupts
Message-ID: <20201231211240.GA2333246@robh.at.kernel.org>
References: <20201218210750.3455872-1-saravanak@google.com>
 <2a6dbcc83d5aca7a3340e0cf4d751cdc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a6dbcc83d5aca7a3340e0cf4d751cdc@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 09:30:45AM +0000, Marc Zyngier wrote:
> On 2020-12-18 21:07, Saravana Kannan wrote:
> > Add support for creating device links out of interrupts property.
> > 
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> > Rob/Greg,
> > 
> > This might need to go into driver-core to avoid conflict
> > due to fw_devlink refactor series that merged there.
> > 
> > Thanks,
> > Saravana
> > 
> > 
> >  drivers/of/property.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 5f9eed79a8aa..e56a5eae0a0b 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1271,6 +1271,22 @@ static struct device_node
> > *parse_iommu_maps(struct device_node *np,
> >  	return of_parse_phandle(np, prop_name, (index * 4) + 1);
> >  }
> > 
> > +static struct device_node *parse_interrupts(struct device_node *np,
> > +					    const char *prop_name, int index)
> > +{
> > +	struct device_node *sup;
> > +
> > +	if (strcmp(prop_name, "interrupts") || index)
> > +		return NULL;
> > +
> > +	of_node_get(np);
> > +	while (np && !(sup = of_parse_phandle(np, "interrupt-parent", 0)))
> > +		np = of_get_next_parent(np);
> > +	of_node_put(np);
> > +
> > +	return sup;
> > +}
> > +
> >  static const struct supplier_bindings of_supplier_bindings[] = {
> >  	{ .parse_prop = parse_clocks, },
> >  	{ .parse_prop = parse_interconnects, },
> > @@ -1296,6 +1312,7 @@ static const struct supplier_bindings
> > of_supplier_bindings[] = {
> >  	{ .parse_prop = parse_pinctrl6, },
> >  	{ .parse_prop = parse_pinctrl7, },
> >  	{ .parse_prop = parse_pinctrl8, },
> > +	{ .parse_prop = parse_interrupts, },
> >  	{ .parse_prop = parse_regulators, },
> >  	{ .parse_prop = parse_gpio, },
> >  	{ .parse_prop = parse_gpios, },
> 
> You don't really describe what this is for so I'm only guessing
> from the context. If you want to follow the interrupt hierarchy,
> "interrupt-parent" isn't enough. You also need to track
> things like interrupt-map, or anything that carries a phandle
> to an interrupt controller.

We don't need to follow the hierarchy, we just need the immediate 
dependencies. But you are right that 'interrupt-map' also needs to be 
tracked.

I also noticed that we define 'interrupt-parent' as a dependency to 
parse, but that's wrong. The dependency is where 'interrupts' appears 
and where 'interrupt-parent' appears is irrelevant.

Rob
