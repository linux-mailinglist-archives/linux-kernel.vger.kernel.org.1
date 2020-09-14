Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D757F269131
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgINQNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:13:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35744 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgINQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:10:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08EGAGDa083367;
        Mon, 14 Sep 2020 11:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600099816;
        bh=hl2eOVK57eOjyraDEfcXSk1M76Td+1h4RO8wxJAZPWU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uwsWAjMG2pPTYrZdQCNPFXAjbhp6RWw3jwCSlOvZl5YDQLyLQcob3CZLWHUwc8NkI
         tXhu6eClooLmCHxlyHDdEVjd9L0JsBANo5hQtptFpfcBGCdE/aMzJfJ5Y0q67/BtTf
         WdP4ZToISd1sQQdj+oLf4IgjBNjEIRJWaGAoCouY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08EGAGbI012881
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Sep 2020 11:10:16 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Sep 2020 11:10:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Sep 2020 11:10:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08EGAGZp036526;
        Mon, 14 Sep 2020 11:10:16 -0500
Date:   Mon, 14 Sep 2020 11:10:16 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add DT to get PCIe working in J721E SoC
Message-ID: <20200914161016.bil575y3ig5oz5dn@akan>
References: <20200914152115.1788-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200914152115.1788-1-kishon@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:51-20200914, Kishon Vijay Abraham I wrote:
> Now that J721E PCIe support is merged (including the YAML bindings),
> add PCIe device tree nodes to get PCIe working in J721E SoC both in
> RC mode and EP mode.
> 
> Series has been rebased to:
> git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux ti-k3-dts-next 
> 
> Changes from v1:
> 1) Renamed all syscon dt-nodes to "syscon" instead of pcieX-ctrl.
> 2) Add TI specific compatible for "syscon" DT nodes
> 3) Add information about appending "ranges" property to access all PCIe
>    instances in commit log.
> 
> Kishon Vijay Abraham I (2):
>   arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes
>   arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe
>     instances
> 
>  .../dts/ti/k3-j721e-common-proc-board.dts     |  80 ++++++
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 232 +++++++++++++++++-
>  arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   5 +-
>  3 files changed, 315 insertions(+), 2 deletions(-)
> 
> -- 
> 2.17.1
> 

Thanks, yeah - the series is clean. If no one adds a tag in the next
couple of days or so, I can pick it up.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
