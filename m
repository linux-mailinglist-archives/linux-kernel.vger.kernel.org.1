Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA54293E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408024AbgJTOUU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Oct 2020 10:20:20 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:60562 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407964AbgJTOUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:20:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 188DB6231F3E;
        Tue, 20 Oct 2020 16:20:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2bqLSZFXsX7f; Tue, 20 Oct 2020 16:20:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6AF986125F39;
        Tue, 20 Oct 2020 16:20:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ki_go-2lwbUD; Tue, 20 Oct 2020 16:20:16 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4BB546231F3E;
        Tue, 20 Oct 2020 16:20:16 +0200 (CEST)
Date:   Tue, 20 Oct 2020 16:20:16 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Tom Rix <trix@redhat.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1957286686.215125.1603203616230.JavaMail.zimbra@nod.at>
In-Reply-To: <fef9fb1c-30ee-14fb-a9bd-4f4a554a8bbc@redhat.com>
References: <20201019191631.9604-1-trix@redhat.com> <CAFLxGvwAVbpUe221N-qS19aFSaJ4hM=J=veHfi+4wAkNTNGAog@mail.gmail.com> <fef9fb1c-30ee-14fb-a9bd-4f4a554a8bbc@redhat.com>
Subject: Re: [PATCH] mtd: remove unneeded break
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove unneeded break
Thread-Index: VuWEEkF7B042gHmZlY7KkRdT2r+sCg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Tom Rix" <trix@redhat.com>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Dienstag, 20. Oktober 2020 16:00:37
> Betreff: Re: [PATCH] mtd: remove unneeded break
>> Acked-by: Richard Weinberger <richard@nod.at>
>>
>> Do you want to route this patch through mtd or do you carry it?
> 
> Not sure if this question is for me.

It was. :-)
 
> I do not maintain a subsystem/branch, so through mtd is what i was assuming.

Okay, then let's carry this one through mtd.
Global cleanups go sometimes in a dedicated tree directly to Linus.

Thanks,
//richard
