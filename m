Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9DA284540
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 07:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgJFFXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 01:23:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57180 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgJFFXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 01:23:22 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0965NI46032902;
        Tue, 6 Oct 2020 00:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601961798;
        bh=5Feol3WKm5zX0b3OB4XP9b2vuJwJd91pvKimsOUKvh8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=c2sRdplLX7OCb71sIS2RGIsBkaCCckZvojwAdRLr60GkzsrsfpUTAyTJlxiYNIW8e
         FZk/fteDhnGUlLw6JfG56IZcXEGpOnfzbQaJf8DEoGbujm772xoItNUMhi5z0ZVZxk
         ar6767SkJeTcpWt9BEzcDKOb8Ma4t0iA0LOvdCrg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0965NIcD049792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Oct 2020 00:23:18 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 6 Oct
 2020 00:23:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 6 Oct 2020 00:23:18 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0965NFS9062469;
        Tue, 6 Oct 2020 00:23:15 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Michael Walle <michael@walle.cc>,
        Doug Anderson <dianders@chromium.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH] Revert "mtd: spi-nor: Prefer asynchronous probe"
Date:   Tue, 6 Oct 2020 10:53:13 +0530
Message-ID: <160196166120.11915.2526794978202188721.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005090321.8724-1-vigneshr@ti.com>
References: <20201005090321.8724-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 14:33:21 +0530, Vignesh Raghavendra wrote:
> This reverts commit 03edda0e1edaa3c2e99239c66e3c14d749318fd6.
> 
> This leads to warn dump like [1] on some platforms and reorders MTD
> devices thus may break user space expectations. So revert the change.
> 
> [1]:
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[1/1] Revert "mtd: spi-nor: Prefer asynchronous probe"
      https://git.kernel.org/mtd/c/9a3422a110

--
Regards
Vignesh

