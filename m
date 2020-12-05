Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126562CFADF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 10:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgLEJjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 04:39:55 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:46132 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgLEJhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 04:37:11 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id F0A60201104;
        Sat,  5 Dec 2020 09:05:29 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 6209620ECC; Sat,  5 Dec 2020 10:00:18 +0100 (CET)
Date:   Sat, 5 Dec 2020 10:00:18 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     clabbe@baylibre.com, linux-kernel@vger.kernel.org,
        huawei.libin@huawei.com, cj.chengjian@huawei.com
Subject: Re: [PATCH] pcmcia: omap: Fix error return code in omap_cf_probe()
Message-ID: <X8tMItlENWiXBlyr@light.dominikbrodowski.net>
References: <20201125125057.30669-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125125057.30669-1-bobo.shaobowang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Nov 25, 2020 at 08:50:57PM +0800 schrieb Wang ShaoBo:
> Fix to return proper error code instaed of 0 in omap_cf_probe(), as done
> elsewhere in this function.
> 
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>

Applied to pcmcia-next.

Thanks,
	Dominik
