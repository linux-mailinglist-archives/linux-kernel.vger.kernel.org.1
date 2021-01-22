Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D83300AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbhAVSLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:11:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43214 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbhAVSHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:07:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10MI6TcB073608;
        Fri, 22 Jan 2021 12:06:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611338789;
        bh=g/EkiDDiGPN4jY+LKUX8Qw0vz+LhVSiznrkxbxhpiAw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Q6aMIngJlMQola3IJizaNUW9xyGfgeBDFe8PCYFls7rYwGQSS4Y/tE6hi+x8UeR1K
         ax1wa9fyLB8eS8/A7tI6oodRObGC/hyxPCvnozx5No4eDMar+ssPC4nTDLfKkhGghK
         PEmH+3Sye3fGFF3CMpM+XhAuhtbQBVMjX2bv4h/U=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10MI6TBR027191
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jan 2021 12:06:29 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 Jan 2021 12:06:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 Jan 2021 12:06:29 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10MI6Tcb032236;
        Fri, 22 Jan 2021 12:06:29 -0600
Date:   Fri, 22 Jan 2021 12:06:29 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mmc: J7200: Add support for higher speed modes in
 MMCSD subsystems
Message-ID: <20210122180629.3j3aoueiwiib4gso@cavalier>
References: <20210122162403.20700-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210122162403.20700-1-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:54-20210122, Aswath Govindraju wrote:
> The following series of patches
> - adds support for HS200 and HS400 speed modes in MMCSD0 subsystem
> - adds support for UHS-I speed modes in MMCSD1 subsystem 
> 
> Aswath Govindraju (2):
>   arm64: dts: ti: k3-j7200-main: Add support for HS200 and HS400 modes
>     in MMCSD0 subsystem
>   arm64: dts: ti: k3-j7200-main: Add support for UHS-I modes in MMCSD1
>     subsystem


Just a curious couple of questions:
Does squashing both the patches create a problem for understanding or a
later bisect? I kind of thought these mostly go hand in hand between the
instances, am I mistaken?

Are there any otap delay params update needed or the defaults are good
to go?

Will also help to provide some verification log along with this.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
