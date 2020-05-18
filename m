Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A15D1D8995
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 22:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgERUvF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 May 2020 16:51:05 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:33564 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERUvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:51:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7154F6071A74;
        Mon, 18 May 2020 22:51:02 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KUrDaPiIdUDY; Mon, 18 May 2020 22:51:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5D0B16071A76;
        Mon, 18 May 2020 22:51:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KhVKLKkHVMLA; Mon, 18 May 2020 22:51:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 39EAF6071A74;
        Mon, 18 May 2020 22:51:00 +0200 (CEST)
Date:   Mon, 18 May 2020 22:51:00 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Alban Bedel <albeu@free.fr>
Message-ID: <560174857.237649.1589835060139.JavaMail.zimbra@nod.at>
In-Reply-To: <20200518215649.5273b132@xps13>
References: <20200430131721.360064-1-ricardo@ribalda.com> <20200504104339.31b4a858@xps13> <CAPybu_3D5p7P5ND5qb8-2QmaQhQuvdEbiNKkeK5PbHdF3s-2Fg@mail.gmail.com> <20200518215649.5273b132@xps13>
Subject: Re: [PATCH] mtd: Fix mtd not registered due to nvmem name collision
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix mtd not registered due to nvmem name collision
Thread-Index: Q7Nx72pmZrkxf39ekBQmY2OOnvapSg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> An: "Ricardo Ribalda Delgado" <ricardo@ribalda.com>
> CC: "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, "linux-mtd" <linux-mtd@lists.infradead.org>,
> "linux-kernel" <linux-kernel@vger.kernel.org>, "Boris Brezillon" <boris.brezillon@collabora.com>, "Alban Bedel"
> <albeu@free.fr>
> Gesendet: Montag, 18. Mai 2020 21:56:49
> Betreff: Re: [PATCH] mtd: Fix mtd not registered due to nvmem name collision

> Hi Ricardo,
> 
> Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote on Mon, 18 May 2020
> 16:01:47 +0200:
> 
>> Hi
>> 
>> This is just a friendly ping after two weeks ;)
> 
> Don't worry, it's in the pipe :)

And now applied and pushed. :-)

Thanks,
//richard
