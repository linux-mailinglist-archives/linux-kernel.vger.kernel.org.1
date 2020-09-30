Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C55B27E3DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgI3IfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:35:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54616 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3IfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:35:06 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U8Yw91019720;
        Wed, 30 Sep 2020 03:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601454898;
        bh=vyP7kkQO60gEdt3Yqemaz9AGjZ7Y49Hn9COTQL/iAm4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wE02Ncx6VDOKEESSJ5GWJv+32WsgCrPNKW29pwltPd75TkCh/bTJc6pfhDIuv+DKQ
         XFU9JGNNMkj9ljOQ8Nle2fAKxxSUOYvaIiWS+yfAZwc00apeEldzEhc0c/8TXMnbCb
         rXpi7dFJB1bCKfDddAl1iKp5ykrsxOVzFZ8lkWxE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U8YwtC036285
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 03:34:58 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 03:34:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 03:34:57 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U8Yo8k098804;
        Wed, 30 Sep 2020 03:34:54 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-mtd@lists.infradead.org>, Ikjoon Jang <ikjn@chromium.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        Xingyu Wu <wuxy@bitland.corp-partner.google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        ST Lin <stlin2@winbond.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [RESEND PATCH v4] mtd: spi-nor: winbond: Add support for w25q64jwm
Date:   Wed, 30 Sep 2020 14:04:43 +0530
Message-ID: <160145480408.16293.15779441408974019689.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928060631.2090541-1-ikjn@chromium.org>
References: <20200928060631.2090541-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 14:06:31 +0800, Ikjoon Jang wrote:
> Add support Winbond w25q{64,128,256}jwm which are identical to existing
> w25q32jwm except for their sizes.
> 
> This was tested with w25q64jwm, basic erase/write/readback and
> lock/unlock both lower/upper blocks were okay.
> 
> Signed-off-by: ikjn@chromium.org <ikjn@chromium.org>
> Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
> Signed-off-by: ST Lin <stlin2@winbond.com>
> Tested-by: Nicolas Boichat <drinkcat@chromium.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[1/1] mtd: spi-nor: winbond: Add support for w25q64jwm
      https://git.kernel.org/mtd/c/6eedfd858f

--
Regards
Vignesh

