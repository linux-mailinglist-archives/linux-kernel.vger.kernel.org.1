Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E18E2A44A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgKCL7e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Nov 2020 06:59:34 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:59800 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgKCL7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:59:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9802C60B33ED;
        Tue,  3 Nov 2020 12:59:31 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oQdy23ef3ZQl; Tue,  3 Nov 2020 12:59:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 343706125F2E;
        Tue,  3 Nov 2020 12:59:31 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CAsv9HTMQe0m; Tue,  3 Nov 2020 12:59:31 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1515D60B33ED;
        Tue,  3 Nov 2020 12:59:31 +0100 (CET)
Date:   Tue, 3 Nov 2020 12:59:31 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <782317824.260495.1604404771008.JavaMail.zimbra@nod.at>
In-Reply-To: <f013d7af-6e1d-5b8f-4a23-7f6c150f896a@ti.com>
References: <20201012180404.6476-1-p.yadav@ti.com> <20201012180404.6476-3-p.yadav@ti.com> <f013d7af-6e1d-5b8f-4a23-7f6c150f896a@ti.com>
Subject: Re: [PATCH 2/3] UBI: Do not zero out EC and VID when multi-pass
 writes are not supported
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: Do not zero out EC and VID when multi-pass writes are not supported
Thread-Index: IYY5CPrwbEGqjygzDycc3Mf8hJzERg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Vignesh Raghavendra" <vigneshr@ti.com>
>
> You may want to get rid of assertion for mtd->writesize != 1 in case of
> MTD_NORFLASH.

Agreed. I hope nothing else breaks if NOR has suddenly a writesize >= 1.

Thanks,
//richard
