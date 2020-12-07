Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F482D1C25
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgLGV3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:29:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:3868 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgLGV3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:29:53 -0500
IronPort-SDR: XM60WZUGdmtLx7wSCc3yYqohGN6M6NzRt4WV/gpmJV6j2S7a9kFS4LI4a6AM1M8FcJO1cIK4Ha
 9vyIG64wOwzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="171207998"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="171207998"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 13:28:08 -0800
IronPort-SDR: K5QXC6qn1+IbfmEsqeelnf5Mzwpuxrgj2haIcwiCt2FaFK/EPo07UJj6op9MzpmblvHuINCztL
 LO2KXSWk71yw==
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="539945235"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 13:28:07 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id AFD066363;
        Mon,  7 Dec 2020 13:28:07 -0800 (PST)
Date:   Mon, 7 Dec 2020 13:28:07 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     mgross@linux.intel.com, damien.lemoal@wdc.com,
        leonard.crestez@nxp.com, Paul Murphy <paul.j.murphy@intel.com>,
        dragan.cvetic@xilinx.com, markgross@kernel.org, robh+dt@kernel.org,
        corbet@lwn.net, devicetree@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        arnd@arndb.de, palmerdabbelt@google.com, bp@suse.de,
        shawnguo@kernel.org, peng.fan@nxp.com, gregkh@linuxfoundation.org,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/22] dt-bindings: Add bindings for Keem Bay VPU IPC
 driver
Message-ID: <20201207212807.GD49179@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-5-mgross@linux.intel.com>
 <20201207155726.GA350430@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207155726.GA350430@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:57:26AM -0600, Rob Herring wrote:
> On Tue, 01 Dec 2020 14:34:53 -0800, mgross@linux.intel.com wrote:
> > From: Paul Murphy <paul.j.murphy@intel.com>
> > 
> > Add DT bindings documentation for the Keem Bay VPU IPC driver.
> > 
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Paul Murphy <paul.j.murphy@intel.com>
> > Co-developed-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > ---
> >  .../soc/intel/intel,keembay-vpu-ipc.yaml      | 151 ++++++++++++++++++
> >  1 file changed, 151 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
> > 
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml: 'additionalProperties' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml: ignoring, error in schema: 
> warning: no schema found in file: ./Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
> 
> 
> See https://patchwork.ozlabs.org/patch/1409183
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

Thanks!  I will fix on the next update.

--mark

