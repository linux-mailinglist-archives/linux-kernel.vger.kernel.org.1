Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C055F2FDFAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436852AbhAUCnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:43:32 -0500
Received: from m12-14.163.com ([220.181.12.14]:36873 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393210AbhAUCXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 21:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=suB9M
        vgNkgi6OBoaUS2FIQFjCRzO9+B2UkAsx0+Ld/4=; b=mT5qT08jGB9Yevps0oaMY
        6ueIVt8dDzFAmRTxnPxuXEQZloK2CsHujxOgZAQew3jSJTrJLnzND2Pb2g+8HHtW
        yX+hDhnojluleaPrx+ESHtUr2ACOvH3a49jWXqnaAuWtnCL7KYAqL9LhmYJgWWo5
        zobbFLNszLcAjOnk7bAMOU=
Received: from localhost (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowACn3Jjv5AhgBvFYhA--.3300S2;
        Thu, 21 Jan 2021 10:20:40 +0800 (CST)
Date:   Thu, 21 Jan 2021 10:20:42 +0800
From:   Chunyou Tang <tangchunyou@163.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, akpm@linux-foundation.org, rppt@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangwen@yulong.com, tangchunyou@yulong.com
Subject: Re: [PATCH] arch/alpha: fix typo in a comment in
 arch/alpha/boot/bootpz.c
Message-ID: <20210121102042.00005504@163.com>
In-Reply-To: <0df77d48-8541-32c9-d39d-3e59f89f1f86@physik.fu-berlin.de>
References: <20210120133410.2182-1-tangchunyou@163.com>
        <5e4ed85d-140c-3d85-e4f4-97b27fa37885@infradead.org>
        <0df77d48-8541-32c9-d39d-3e59f89f1f86@physik.fu-berlin.de>
Organization: yulong
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DsCowACn3Jjv5AhgBvFYhA--.3300S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1Uuw4Uury3ArWDCr45ZFb_yoW8GrWfpa
        48JayDA3ykuFWava47tF1ruFWFq3ZrtF47G34UKry5Jry2vry0qr1SkrWxua48CrWFg34j
        vw4aka4a9rs8Cw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USQ6XUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiHhghUVSIsZ1HvgAAs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 17:37:07 +0100
John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> On 1/20/21 5:20 PM, Randy Dunlap wrote:
> > On 1/20/21 5:34 AM, ChunyouTang wrote:  
> >> From: tangchunyou <tangchunyou@yulong.com>
> >>
> >> "kerne" -> "kernel"
> >>
> >> Signed-off-by: tangchunyou <tangchunyou@yulong.com>
> >> ---
> >>  arch/alpha/boot/bootpz.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/alpha/boot/bootpz.c b/arch/alpha/boot/bootpz.c
> >> index 43af718..61b61be 100644
> >> --- a/arch/alpha/boot/bootpz.c
> >> +++ b/arch/alpha/boot/bootpz.c
> >> @@ -200,7 +200,7 @@ extern int decompress_kernel(void*
> >> destination, void *source, START_ADDR	KSEG address of the
> >> entry point of kernel code. 
> >>  	ZERO_PGE	KSEG address of page full of zeroes, but 
> >> -			upon entry to kerne cvan be expected
> >> +			upon entry to kernel cvan be expected  
> > 
> > s/cvan/can/ also  
> 
> Right. Reading the whole paragraph helps. It probably should be:
> 
> ZERO_PGE	KSEG address of page full of zeroes, but
> 		upon entry to kernel, it can be expected
> 		to hold the parameter list and possible
> 		INTRD information.
> 
> Adrian
> 

ok, I change it as :
ZERO_PGE	KSEG address of page full of zeroes, but
		upon entry to kernel, it can be expected
		to hold the parameter list and possible
		INTRD information.
then I commit it.

Chunyou Tang

