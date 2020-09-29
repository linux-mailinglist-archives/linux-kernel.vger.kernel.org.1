Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C71E27BFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgI2Iog convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Sep 2020 04:44:36 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:60534 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgI2Iog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:44:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C19246125F2D;
        Tue, 29 Sep 2020 10:44:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HHW3Qf_pwNH7; Tue, 29 Sep 2020 10:44:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5F79061BD1BE;
        Tue, 29 Sep 2020 10:44:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7b1UWPjEyI4Q; Tue, 29 Sep 2020 10:44:33 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3767B6125F2D;
        Tue, 29 Sep 2020 10:44:33 +0200 (CEST)
Date:   Tue, 29 Sep 2020 10:44:33 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Kristof Havasi <havasiefr@gmail.com>
Message-ID: <1641873979.143790.1601369073151.JavaMail.zimbra@nod.at>
In-Reply-To: <20200929083232.GA11648@pengutronix.de>
References: <20200928190612.12074-1-richard@nod.at> <20200929083232.GA11648@pengutronix.de>
Subject: Re: [PATCH] ubifs: journal: Make sure to not dirty twice for auth
 nodes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: journal: Make sure to not dirty twice for auth nodes
Thread-Index: jAQnWmKtuwm37EzhDVXBPQ9JkDWXQw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Sascha Hauer" <s.hauer@pengutronix.de>
> An: "richard" <richard@nod.at>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "stable"
> <stable@vger.kernel.org>, "Kristof Havasi" <havasiefr@gmail.com>
> Gesendet: Dienstag, 29. September 2020 10:32:32
> Betreff: Re: [PATCH] ubifs: journal: Make sure to not dirty twice for auth nodes

> On Mon, Sep 28, 2020 at 09:06:12PM +0200, Richard Weinberger wrote:
>> When removing the last reference of an inode the size of an auth node
>> is already part of write_len. So we must not call ubifs_add_auth_dirt().
>> Call it only when needed.
>> 
>> Cc: <stable@vger.kernel.org>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Kristof Havasi <havasiefr@gmail.com>
>> Fixes: 6a98bc4614de ("ubifs: Add authentication nodes to journal")
>> Reported-by: Kristof Havasi <havasiefr@gmail.com>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> Looked at the code until I understood what the problem is and how it is
> fixed, so:
> 
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to fixes branch!

Thanks,
//richard
