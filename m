Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A2C2D3C72
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgLIHn7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Dec 2020 02:43:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34776 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgLIHn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:43:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id k14so619416wrn.1;
        Tue, 08 Dec 2020 23:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=34PovGutJhKqA8edy4i8ZDODYpc+dmVnh/VwPkNy4iI=;
        b=QpUN53NGuegDC732CdihFuf82yTZOcjt/frO0Qp1X0f7qKQjnCVCXTqPrYJFBNTORJ
         rw0CtDZNFDutBiGG3CrUxJBrK7Bz/Gp4Gj76ytAJvP0s0NnQVNjS/KLNysAOgK2IjwZc
         SCNgpR3xg/IGd5+smXnAIJA2h9Ic7ZR1X+DS8VNUSEgMZbbXgEgz6BTX+t5kvybfjwiZ
         CFapAZ0DA7FFdgrrUS77CXbWPBImrIJ3Uhj1F6duxAQ8tfRYrQ4utasXB3fcqwqMHKH3
         jSeEHqFUTfXBRC8JtaPVwbAe8glyf+uhRwAgUCofq5GAwMY4uo5tukC+Ozg1UaAvavva
         0Mzg==
X-Gm-Message-State: AOAM530sotXawTA7GF8XkUXNKpYU7Mnt/TkhNb/B94bZMDB+bWzWByRe
        wLS5/K7xVIBgzqEMnSCihkrFhe8a8aOyRQ==
X-Google-Smtp-Source: ABdhPJzwFb6usuIWCN5d087TCGX4jWsqxiGj1IqqE3KKpLORqnMDiNHuwOVVM22deIPFriqzZLh2Fw==
X-Received: by 2002:adf:b343:: with SMTP id k3mr1110838wrd.202.1607499797105;
        Tue, 08 Dec 2020 23:43:17 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id d191sm1701263wmd.24.2020.12.08.23.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 23:43:15 -0800 (PST)
Date:   Wed, 9 Dec 2020 08:43:14 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201209074314.GA3013@kozik-lap>
References: <20201124015949.29262-1-alice.guo@nxp.com>
 <20201130215721.GA3090303@robh.at.kernel.org>
 <AM6PR04MB60533A06C19AA37213C93F54E2F40@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <AM6PR04MB6053C8339E1894687C911E72E2CC0@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <AM6PR04MB6053C8339E1894687C911E72E2CC0@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 02:30:22AM +0000, Alice Guo (OSS) wrote:
> Gentle ping..  and Krzysztof Kozlowski, do you agree?

I did not know that you wait for something from my side.

> 
> Best Regards,
> Alice Guo
> 
> > -----Original Message-----
> > From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> > Behalf Of Alice Guo (OSS)
> > Sent: 2020年12月1日 11:31
> > To: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk@kernel.org>;
> > shawnguo@kernel.org
> > Cc: devicetree@vger.kernel.org; Peng Fan <peng.fan@nxp.com>;
> > s.hauer@pengutronix.de; linux-kernel@vger.kernel.org; krzk@kernel.org;
> > dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org
> > Subject: RE: [PATCH v6 1/4] dt-bindings: soc: imx8m: add DT Binding doc for soc
> > unique ID
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>
> > > On Behalf Of Rob Herring
> > > Sent: 2020年12月1日 5:57
> > > To: Alice Guo <alice.guo@nxp.com>
> > > Cc: devicetree@vger.kernel.org; Peng Fan <peng.fan@nxp.com>;
> > > s.hauer@pengutronix.de; linux-kernel@vger.kernel.org; krzk@kernel.org;
> > > dl-linux-imx <linux-imx@nxp.com>; shawnguo@kernel.org;
> > > linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [PATCH v6 1/4] dt-bindings: soc: imx8m: add DT Binding
> > > doc for soc unique ID
> > >
> > > On Tue, Nov 24, 2020 at 09:59:46AM +0800, Alice Guo wrote:
> > > > Add DT Binding doc for the Unique ID of i.MX 8M series.
> > > >
> > > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > > ---
> > > >
> > > > v2: remove the subject prefix "LF-2571-1"
> > > > v3: put it into Documentation/devicetree/bindings/arm/fsl.yaml
> > >
> > > No, I prefer this be a separate schema file and not clutter board/soc
> > > schemas with child nodes.
> > 
> > Hi,
> > Thank you for your comments. I read
> > "Documentation/devicetree/bindings/arm/arm,realview.yaml"
> > in which there is a "soc". So I added my "soc" to this current file. Can I keep it in
> > Documentation/devicetree/bindings/arm/fsl.yaml?

Please go with Rob's suggestion.

Best regards,
Krzysztof
