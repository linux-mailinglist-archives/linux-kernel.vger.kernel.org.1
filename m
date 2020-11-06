Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3282A97D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgKFOo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:44:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89013C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 06:44:59 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 395521F46A74;
        Fri,  6 Nov 2020 14:44:58 +0000 (GMT)
Date:   Fri, 6 Nov 2020 15:44:54 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] mtd: spinand: micron: add support for MT29F2G01AAAED
Message-ID: <20201106154454.20ca277c@collabora.com>
In-Reply-To: <20201106142838.7772-1-nthirumalesha7@gmail.com>
References: <20201106142838.7772-1-nthirumalesha7@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Nov 2020 22:28:38 +0800
Thirumalesha Narasimhappa <nthirumalesha7@gmail.com> wrote:

> The MT29F2G01AAAED is a single die, 2Gb Micron SPI NAND Flash with 4-bit
> ECC
> 
> Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
> ---
> 
> v6: Reverted the SPINAND_OP_VARIANTS() as they were in v4 for
> MT29F2G01AAAED device
> 
> v5: As per the review comments, the changes were reverted to the v2,
> except the MT29F2G01AAAED device related (including the review comments)
> 
> v4: Split patch into two parts,
>     1. Generalise the oob structure name & function names as show in v3
>     2. Add support for MT29F2G01AAAED device
>        a. Add oob section check in micron_ooblayout_free function
>        b. Rename mt29f2g01aaaed_* to generic name micron_4_*
> 
> v3: As per the review comments,
>      1. Renamed read_cache_variants as quadio_read_cache_variants,
> write_cache_variants as
>       x4_write_cache_variants/x1_write_cache_variants,
> update_cache_variants as
>       x4_update_cache_variants/x1_update_cache_variants,
> read_cache_variants as x4_read_cache_variants

We want those renames in a separate patch (ideally happening before
this one).
