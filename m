Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B72ABE78
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgKIOTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:19:38 -0500
Received: from mail.thorsis.com ([92.198.35.195]:60017 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbgKIOTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:19:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id C0B06F2C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 15:19:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hbjSGg2J5noT for <linux-kernel@vger.kernel.org>;
        Mon,  9 Nov 2020 15:19:35 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 28B434753; Mon,  9 Nov 2020 15:19:33 +0100 (CET)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.2
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-mtd@lists.infradead.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 05/23] mtd: mtdcore: Fix misspelled function parameter 'section'
Date:   Mon, 09 Nov 2020 15:19:28 +0100
Message-ID: <14597255.v2tPdhxTZE@ada>
In-Reply-To: <20201106213655.1838861-6-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org> <20201106213655.1838861-6-lee.jones@linaro.org>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am Freitag, 6. November 2020, 22:36:37 CET schrieb Lee Jones:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/mtdcore.c:1592: warning: Function parameter or member 'section'
> not described in 'mtd_ooblayout_find_eccregion' drivers/mtd/mtdcore.c:1592:
> warning: Excess function parameter 'sectionp' description in
> 'mtd_ooblayout_find_eccregion'
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mtd/mtdcore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index e9e163ae9d863..31d1be4b22617 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1578,7 +1578,7 @@ static int mtd_ooblayout_find_region(struct mtd_info
> *mtd, int byte, *				  ECC byte
>   * @mtd: mtd info structure
>   * @eccbyte: the byte we are searching for
> - * @sectionp: pointer where the section id will be stored
> + * @section: pointer where the section id will be stored
>   * @oobregion: OOB region information
>   *
>   * Works like mtd_ooblayout_find_region() except it searches for a specific
> ECC

Reviewed-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex



