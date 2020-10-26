Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BA229903F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782740AbgJZO4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:56:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42720 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782136AbgJZOz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:55:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09QEtiCF099910;
        Mon, 26 Oct 2020 09:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603724144;
        bh=eVGkIN+pY+QMWvxrhNpmuGBvJCfkOJmqqUjfqbRkEbc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZocVfrLSBi5q/1jf152PwrRrHixwatZwB9M7ybPQSL5fWFEwIVpQ6vsSiccCgbczh
         bP//FJyPkAlvpred3OokKOA8lwBUVH+F+ffQNxvaWBZCQerQznJ3q2p2DjRhI7NnxV
         g70SClGJYvh+OEi2jwmStl61B7A+YQmJXkyq9l4U=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09QEthPc073307
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 09:55:43 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 26
 Oct 2020 09:55:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 26 Oct 2020 09:55:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09QEtgxi044454;
        Mon, 26 Oct 2020 09:55:42 -0500
Date:   Mon, 26 Oct 2020 09:55:42 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <t-kristo@ti.com>, <robh+dt@kernel.org>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/8] Add support for UHS modes in TI's J721e and J7200
 boards
Message-ID: <20201026145542.4woe7faowvp657at@dislodge>
References: <20201001190541.6364-1-faiz_abbas@ti.com>
 <20201001191302.dlp2tzbvkk35vzgd@akan>
 <2a7ceab9-37ec-9117-1d98-9f307b4b5390@ti.com>
 <20201002124926.rr5dk5hhygavgqs3@akan>
 <00746c65-d240-e7e9-810d-b6e33655cc57@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <00746c65-d240-e7e9-810d-b6e33655cc57@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:39-20201002, Faiz Abbas wrote:
> Ok. I'll send only the defconfig patches in a new series and repost v2 of this at rc1.
> 

Just a reminder, please retest and repost based off v5.10-rc1
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
