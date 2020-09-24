Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A42276D82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgIXJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:31:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32968 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIXJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:31:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08O9Vhhq122200;
        Thu, 24 Sep 2020 04:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600939903;
        bh=FnDfphtvzOaoxVKuLWg4liIqcSbcVtXiY52oAVj0uAM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yaMVRm8JA8d++Adpf0AIjlDN095KEcNmKJW3jyExc8lCn6QgDYOX2/vymmMBCVAzp
         ChqEHAb9tb6q2cCUkJ+wkKivtQPe5rA75k4MDzgtHkXUXsvgyyCylHhsT1KaHnXp3u
         asXsA1gBJJQNjU4aovGAsHPgHWYkt1Nlz8+x1Pe4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08O9VhOP027491;
        Thu, 24 Sep 2020 04:31:43 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 04:31:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 04:31:43 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08O9VeBs025802;
        Thu, 24 Sep 2020 04:31:41 -0500
Subject: Re: [PATCH v2 0/2] J7200: Add I2C support
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>
References: <20200923155400.13757-1-vigneshr@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <4caba17e-09fb-4839-72cf-d2d3a255d183@ti.com>
Date:   Thu, 24 Sep 2020 15:01:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200923155400.13757-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20 9:23 PM, Vignesh Raghavendra wrote:
> Add I2C and I2C IO expanders nodes for J7200
> 
> v2:
> Align reg address format with that of file's (s/0x0/0x00)

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

