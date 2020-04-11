Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508161A4E75
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 09:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgDKHNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 03:13:51 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:25069 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDKHNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:13:51 -0400
Received: from [192.168.42.210] ([93.22.135.18])
        by mwinf5d37 with ME
        id RKDp220060Pz5GD03KDpNY; Sat, 11 Apr 2020 09:13:50 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Apr 2020 09:13:50 +0200
X-ME-IP: 93.22.135.18
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Joe Perches <joe@perches.com>, apw@canonical.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
 <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
 <6e52383e-100d-b016-32c2-6fb54938b6fe@wanadoo.fr>
 <c9fd4bc75812fed4799c2fb87b452b809a7e9a7a.camel@perches.com>
 <db2730700ab3eb7008413a1e7bba94ca7c49a031.camel@perches.com>
 <26b49cf5-453b-9a81-b045-fdc99c42fcf8@wanadoo.fr>
Message-ID: <af3166a9-c463-2645-05c5-441cc87abb6c@wanadoo.fr>
Date:   Sat, 11 Apr 2020 09:13:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <26b49cf5-453b-9a81-b045-fdc99c42fcf8@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 11/04/2020 à 09:12, Christophe JAILLET a écrit :
>
> Hi,
>
>     ./scripts/checkpatch.pl -f drivers/soc/kendryte/k210-sysctl.c
>
> is missing line 189, even if it looks like a construction correctly 
> spotted in some other files:
>     if (foo) {
>         dev_err(...);
>         ...
>     };
>
> CJ
>
>
Oops, my mistake, this one is correctly spotted :)

CJ

