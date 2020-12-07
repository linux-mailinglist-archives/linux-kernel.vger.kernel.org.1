Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46B82D1876
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgLGSXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:23:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:5050 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgLGSXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:23:51 -0500
IronPort-SDR: 7U+6VjvvlgE29G6zdeQlgp2yrYz4sFJQD0aN/QzsFGaAIr0jPvvNjO9eZByGKisiBOOJmXbGXJ
 qH5dvWR7JvWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="160792547"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="160792547"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 10:22:05 -0800
IronPort-SDR: LJpIOl5qR3FbYUO6GpoIFjBgNfoBKfI9nILXpkiVbNmPIE2cwe4CBMx+aKHMiSLNbd9lF6n3GV
 MEf4AfTulbig==
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="551915231"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 10:22:04 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id D3A0A6363;
        Mon,  7 Dec 2020 10:22:04 -0800 (PST)
Date:   Mon, 7 Dec 2020 10:22:04 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 02/22] dt-bindings: Add bindings for Keem Bay IPC driver
Message-ID: <20201207182204.GC49179@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-3-mgross@linux.intel.com>
 <20201207160152.GB351233@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207160152.GB351233@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 10:01:52AM -0600, Rob Herring wrote:
> On Tue, Dec 01, 2020 at 02:34:51PM -0800, mgross@linux.intel.com wrote:
> > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > 
> > Add DT binding documentation for the Intel Keem Bay IPC driver, which
> > enables communication between the Computing Sub-System (CSS) and the
> > Multimedia Sub-System (MSS) of the Intel Movidius SoC code named Keem
> > Bay.
> > 
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > ---
> >  .../bindings/soc/intel/intel,keembay-ipc.yaml | 63 +++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> > new file mode 100644
> > index 000000000000..6e21c54d8f34
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> > @@ -0,0 +1,63 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2020 Intel Corporation
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/soc/intel/intel,keembay-ipc.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Keem Bay IPC
> > +
> > +maintainers:
> > +  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > +
> > +description:
> > +  The Keem Bay IPC driver enables Inter-Processor Communication (IPC) with the
> > +  Visual Processor Unit (VPU) embedded in the Intel Movidius SoC code named
> > +  Keem Bay.
> 
> Sounds like a mailbox. 
Its a multi-channel mailbox like thing with priority channel support.

> 
> What's the relationship between this and the xlink thing?
Xlink is a SW abstraction to allow multiple user access to the VPU as well as
enabling use cases where a Keem Bay is used as an accelerator add in card as
well as a simple SBC type of design.  The xlink stuff sits on top of the IPC
stuff.

--mark

