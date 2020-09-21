Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95C72723F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgIUMdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:33:32 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32978 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgIUMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:33:31 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08LCXIis105635;
        Mon, 21 Sep 2020 07:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600691598;
        bh=Me6JaYxCAj8494EMq4SiU9PetCAowoMjw0t1jk/5Eyo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gulmEJv6PG4M5G68jE/eZlTSqbuDuLCxYnndlHlPhED803yuZioiDvgXkJajCRjjz
         z9gCeGzJq0eHfvwxxDZeUkjaiYV34G9gMtYnfotuQXo8nhmwYudtQiin+f7SU8QhUK
         +IaTk34IHs648dDlEZQOb11tXgLX9E6+Lty9DzZU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08LCXIDA074728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 07:33:18 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 21
 Sep 2020 07:33:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 21 Sep 2020 07:33:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LCX8N6107043;
        Mon, 21 Sep 2020 07:33:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <peda@axentia.se>, Roger Quadros <rogerq@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <t-kristo@ti.com>, <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <kishon@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721e: Rename mux header and update macro names
Date:   Mon, 21 Sep 2020 07:33:07 -0500
Message-ID: <160069143453.25898.17991361187968273734.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918165930.2031-1-rogerq@ti.com>
References: <20200918165930.2031-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 19:59:30 +0300, Roger Quadros wrote:
> We intend to use one header file for SERDES MUX for all
> TI SoCs so rename the header file.
> 
> The exsting macros are too generic. Prefix them with SoC name.
> 
> While at that, add the missing configurations for completeness.

Hi Roger Quadros,

I have applied the following to branch for-5.9-dts on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721e: Rename mux header and update macro names
      commit: c65176fd49f45bd5a5ffaa1790109745d1fa462c

I have also applied ti-k3-dt-fixes-for-v5.9 tag which I will be sending
for 5.9 in the next few mins.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

