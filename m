Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE5D276DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgIXJqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:46:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38314 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:46:43 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08O9kdLb129688;
        Thu, 24 Sep 2020 04:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600940799;
        bh=PxR3Y6wV8Jw/tkfOVXDYewyxFGiJlTF76X9Vpki1UZw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jDjiVMI9Ik/OG1ZaQFGrJKnExLu2SjwUvKYN1VzlGuFSXzuCBO7xtPlGzA/cF+xcz
         TZWUvHRpIOOnvoEnsBywlgW1rH7fBO+O4u6sMsPhtawleXRn/MT30GpZsmMMetiIsF
         ZnWZ9Li5biklmHGHg0EQbUDgW5n7vnWznq1dv/b4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08O9kdms101687
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 04:46:39 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 04:46:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 04:46:38 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08O9kZ8d077061;
        Thu, 24 Sep 2020 04:46:36 -0500
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-j7200: Add HyperFlash related
 nodes
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200923163150.16973-1-vigneshr@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <45bf760c-9426-8656-15b1-01f0f44cec8a@ti.com>
Date:   Thu, 24 Sep 2020 15:16:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200923163150.16973-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20 10:01 PM, Vignesh Raghavendra wrote:
> This series adds HyperBus and HyperFlash nodes for TI's J7200 SoC

Reviewed-by: Sekhar Nori <nsekhar@ti.com>
