Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3E42DE076
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 10:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388997AbgLRJh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 04:37:26 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:44445 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732991AbgLRJh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 04:37:26 -0500
Received: by mail-ed1-f52.google.com with SMTP id p22so1632346edu.11;
        Fri, 18 Dec 2020 01:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sP5Pl2hChRWdlyFWKwCe+3kPLFBbxcwbik9e5Qyx4BY=;
        b=rpPsrFPG3LyZlWvSxQUshT/7cpRya/qxnQH4qPDz0CVK2///ZtsYuS7f4NnPVJLqlW
         3/DOZRIrrfy6pagx8HZWX5W/0BR9vPiCNYLzWe1OxG+P9yyvE7CqCPpJc9tz7t4l/x5Z
         g2VHO8uLV4lnZytVoNuj7k4nN5GPhwkPVc3wGsc1stsGYF8ejDUaSbUwMZkdujB7hVBk
         rZOWus57a+Ab+ATji+YtvuNXuiE151CI702j80XrO9nXKa61CAf1D6mtjttwdc+wjvdz
         VAnIonMjn7mZutopD5BNsi1rKfw9kyo5gNGAqwruaoL8LWXd9HaymJYg1VZR0jo49dzX
         kxKg==
X-Gm-Message-State: AOAM533Mx09eTEKZkM28271dT28ae6MGF+6XxB5upVfHGVf7c5O/uHQS
        w0OVs8ZYNHj9x4SA71/HKfQ=
X-Google-Smtp-Source: ABdhPJwmnQ8vtF9L2mupckjV6KgdPxs54QQxzeJjbslIcDPBwDazexMhbxIle9rXr08GaKC24mHzFg==
X-Received: by 2002:a50:f392:: with SMTP id g18mr3497517edm.306.1608284204006;
        Fri, 18 Dec 2020 01:36:44 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n9sm24449828edy.83.2020.12.18.01.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 01:36:43 -0800 (PST)
Date:   Fri, 18 Dec 2020 10:36:41 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201218093641.GA38684@kozik-lap>
References: <20201218083726.16427-1-alice.guo@oss.nxp.com>
 <20201218085223.GA17306@kozik-lap>
 <AM6PR04MB6053A65F794B316659CDE638E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR04MB6053A65F794B316659CDE638E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 09:05:00AM +0000, Alice Guo (OSS) wrote:
 > > +    required:
> > > +      - compatible
> > > +      - nvmem-cells
> > > +      - nvmem-cell-names
> > > +
> > > +additionalProperties: true
> > 
> > Don't leave comments unresolved (or resolve them against review without
> > discussion). Rob asked for changing it. The same as with all schemas - you need
> > to describe the missing properties.
> > 
> > Best regards,
> > Krzysztof
> 
> Hi,
> Thank you for your advice. I replied to him and let him know I remained here unchanged. There will be errors according to his suggestion.

Then the solution is to correct the errors - describe missing properties
- instead of ignoring the suggestion and making a resubmit right away.

Best regards,
Krzysztof

