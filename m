Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2585B2D1C41
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgLGVno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:43:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:59588 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgLGVno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:43:44 -0500
IronPort-SDR: GM97ON1f7qR829G8jJysfq3eUwf48EdHqzY25d7EC66E3kr7Z4OVCz26w5PNzI1yX4kb+NsVgq
 hugaQ68eZPuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="173016582"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="173016582"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 13:41:58 -0800
IronPort-SDR: WAsOIRj0ZsDA1mT74hKiBxohvhchBP+HVpBHvdqWxqwQE19S0BVDTPTrJ0OfJfSv5Wqi+3HVWL
 UsIY2ql2olew==
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="483368686"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 13:41:58 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id A9BB66363;
        Mon,  7 Dec 2020 13:41:58 -0800 (PST)
Date:   Mon, 7 Dec 2020 13:41:58 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     mgross@linux.intel.com, robh+dt@kernel.org,
        leonard.crestez@nxp.com, gregkh@linuxfoundation.org,
        palmerdabbelt@google.com, devicetree@vger.kernel.org,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>,
        Seamus Kelly <seamus.kelly@intel.com>, arnd@arndb.de,
        damien.lemoal@wdc.com, markgross@kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, dragan.cvetic@xilinx.com,
        shawnguo@kernel.org, paul.walmsley@sifive.com, bp@suse.de,
        peng.fan@nxp.com
Subject: Re: [PATCH 15/22] xlink-ipc: Add xlink ipc device tree bindings
Message-ID: <20201207214158.GE49179@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-16-mgross@linux.intel.com>
 <20201207155814.GA351233@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207155814.GA351233@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:58:14AM -0600, Rob Herring wrote:
> On Tue, 01 Dec 2020 14:35:04 -0800, mgross@linux.intel.com wrote:
> > From: Seamus Kelly <seamus.kelly@intel.com>
> > 
> > Add device tree bindings for the xLink IPC driver which enables xLink to
> > control and communicate with the VPU IP present on the Intel Keem Bay
> > SoC.
> > 
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
> > Signed-off-by: Ryan Carnaghi <ryan.r.carnaghi@intel.com>
> > ---
> >  .../misc/intel,keembay-xlink-ipc.yaml         | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
> > 
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml: 'additionalProperties' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml: ignoring, error in schema: 
> warning: no schema found in file: ./Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
> 
> 
> See https://patchwork.ozlabs.org/patch/1409186
> 
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
Thank you!  will do.

--mark
