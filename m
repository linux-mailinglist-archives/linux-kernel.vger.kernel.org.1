Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C103030C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 01:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbhAZADB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 19:03:01 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35178 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732186AbhAZABw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 19:01:52 -0500
Received: by mail-oi1-f170.google.com with SMTP id w8so16763858oie.2;
        Mon, 25 Jan 2021 16:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=du5YoegYLBKhCges/+sXzMbO3GMQX37nv6WSDKN2xZ4=;
        b=s+rK1hTNwXWGIN8rdsbbeeZDwlib483Ki9WESLk8LALn8vsnV32kNlMs3S5e9wlkxi
         p6ceNfNEa0/Gk2QY1pHVs5XuUppXwvlJlWM83AlacoZxpq0cw0hbUpAwDNiznH8BxQOs
         zlpUZdsUuxYuJE3zWJQGpR2q7yFm/e77TVjgNoPOrwXGtHtH5dbyusl7LJRQAyf7QooL
         JmvYJDGZX7RRiYy/3+5x3uZ6pJtiHqcqCETI/UPZ1BEtf4vZZ5Ljplf1s4fepp/YR7m3
         rtcDgWdMwEOCbf6EQvtax8u/5aE/ddwPgkV1wU67dR37mCj/Z9P4PUu+w1U3FP6xSxe/
         mHbA==
X-Gm-Message-State: AOAM533VZ9Tw9Veod7LGNKfGEvxbrYGZezPjkC8zmrv+sai/GUt5Tsej
        JVzfgxVxaSg0sxbRgyIuyw==
X-Google-Smtp-Source: ABdhPJx07tuOIe51LMcOFboVe0ycViNWO8nGfvcSmhDCtSDNPHuOPvtDnJLKlxnCvD5S61PZkWHSZg==
X-Received: by 2002:aca:5185:: with SMTP id f127mr1652630oib.18.1611619270848;
        Mon, 25 Jan 2021 16:01:10 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x141sm1828485oia.3.2021.01.25.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 16:01:09 -0800 (PST)
Received: (nullmailer pid 1303788 invoked by uid 1000);
        Tue, 26 Jan 2021 00:01:08 -0000
Date:   Mon, 25 Jan 2021 18:01:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3: squelch warnings regarding no
 #address-cells for interrupt-controller
Message-ID: <20210126000108.GA1267192@robh.at.kernel.org>
References: <20201117161942.38754-1-nsekhar@ti.com>
 <20201117161942.38754-3-nsekhar@ti.com>
 <ab9658ef-c8a7-155b-acb1-effa872132ca@ti.com>
 <20201118151259.kpag44djji4ssiup@eldest>
 <18e41dba-a3dd-308a-605e-63b76ca638e5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18e41dba-a3dd-308a-605e-63b76ca638e5@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 01:17:36PM +0200, Grygorii Strashko wrote:
> 
> 
> On 18/11/2020 17:12, Nishanth Menon wrote:
> > On 13:38-20201118, Grygorii Strashko wrote:
> > > Hi Rob,
> > > 
> > > On 17/11/2020 18:19, Sekhar Nori wrote:
> > > > With dtc 1.6.0, building TI device-tree files with W=2 results in warnings
> > > > like below for all interrupt controllers.
> > > > 
> > > > /bus@100000/bus@30000000/interrupt-controller1: Missing #address-cells in interrupt provider
> > > > 
> > > > Fix these by adding #address-cells = <0>; for all interrupt controllers in
> > > > TI device-tree files. Any other #address-cells value is really only needed
> > > > if interrupt-map property is being used (which is not the case for existing
> > > > TI device-tree files)
> > > > 
> > > > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> > > > ---
> > > >    arch/arm64/boot/dts/ti/k3-am65-main.dtsi              |  5 +++++
> > > >    arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi            |  2 ++
> > > >    arch/arm64/boot/dts/ti/k3-am654-base-board.dts        |  1 +
> > > >    arch/arm64/boot/dts/ti/k3-j7200-main.dtsi             |  3 +++
> > > >    arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi       |  1 +
> > > >    arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts |  1 +
> > > >    arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             | 11 +++++++++++
> > > >    arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       |  3 +++
> > > >    8 files changed, 27 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > > index aa8725db0187..55aaa1404d7d 100644
> > > > --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > > +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > > @@ -440,6 +440,7 @@
> > > >    		interrupt-controller;
> > > >    		interrupt-parent = <&gic500>;
> > > >    		#interrupt-cells = <1>;
> > > > +		#address-cells = <0>;
> > > Does it really required or mandatory to have #address-cells = <0>; defined for interrupt-controller DT nodes which
> > > do not have child nodes and no "interrupt-map"?
> > 
> > Just to help clarify (I could be mistaken as well): is'nt the
> > interrupt map for user interrupt map nodes that refer to this
> > interrupt controller node to state they dont need a parent address
> > specifier - so are we claiming none of the users will have an
> > interrupt-map (now and never in the future as well) - we we might want
> > to explain why we think that is the case, and if we are expecting dtc
> > to deduce that (if so how?)?
> > 
> 
> The main reason I commented - is hope to get some clarification from DT maintainers.
> 90% of interrupt-controller nodes do not have #address-cells and I never seen in in GPIO nodes
> (most often is present in PCI and GIC nodes).
> and nobody seems fixing it. So, if we are going to move this direction it's reasonable to get clarification to be sure.
> 
> And there is no "never" here - #address-cells always can be added if really required.

Once required, how does one figure that out? It's not obvious and 
requires booting. So we need something at build time. I'm okay with 
loosening the check as long as it warns when a interrupt parent phandle 
in an interrupt-map is missing '#address-cells'.

Now that I look back at the dtc change, I'm now confused why this 
check got applied. Both David and I wanted changes in regards to 
#address-cells. Either a separate check or part of interrupt-map checks. 
And the interrupt-map check never got applied. Andre?

Rob
