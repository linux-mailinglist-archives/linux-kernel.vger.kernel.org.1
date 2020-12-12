Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9313C2D8574
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 10:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438337AbgLLJ5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 04:57:10 -0500
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:39894 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407339AbgLLJ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 04:56:48 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id B5F1918019963;
        Sat, 12 Dec 2020 09:16:45 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 6AE8E180A7FEF;
        Sat, 12 Dec 2020 09:16:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:46:150:152:355:379:599:800:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2525:2553:2561:2564:2682:2685:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6248:7903:7904:8603:9025:10004:10400:10471:10848:10967:11232:11658:11914:12043:12297:12555:12740:12895:12986:13255:13894:14181:14659:14721:21080:21212:21324:21433:21451:21627:21740:21749:21811:21819:30003:30012:30025:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: pie68_1b0f4b527408
X-Filterd-Recvd-Size: 4202
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Dec 2020 09:16:40 +0000 (UTC)
Message-ID: <031a64e4261e1543a136d737436abefd63dbaee1.camel@perches.com>
Subject: Re: mmc: atmel-mci: Reduce scope for the variable
 =?UTF-8?Q?=E2=80=9Cslot=E2=80=9D?= in atmci_request_end()
From:   Joe Perches <joe@perches.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Sat, 12 Dec 2020 01:16:39 -0800
In-Reply-To: <20201211080301.GC1781038@piout.net>
References: <466b4c6d-032f-fbcc-58ac-75f6f39d734f@web.de>
         <20201210151035.GC1578121@piout.net>
         <ec71d7b8-a36b-04f5-77a8-22874ac241e1@web.de>
         <20201210170723.GD1578121@piout.net>
         <2667790c-fad2-aaa9-36e8-6be66949ac8d@web.de>
         <20201210182150.GE1578121@piout.net>
         <4c0d8efe-de25-f168-8b8d-b7f1ede6c6b1@web.de>
         <20201211080301.GC1781038@piout.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-12-11 at 09:03 +0100, Alexandre Belloni wrote:
> On 11/12/2020 07:34:41+0100, Markus Elfring wrote:
> > > > How do you think about a patch like “staging: speakup: remove redundant initialization
> > > > of pointer p_key” for comparison?
> > > > https://lore.kernel.org/patchwork/patch/1199128/
> > > > https://lore.kernel.org/driverdev-devel/20200223153954.420731-1-colin.king@canonical.com/
> > > > 
> > > > Would you tolerate to omit the initialisation for the variable “slot”?
> > > 
> > > If you were able to provide one good technical reason.
> > 
> > I find that the positions of variable definitions (and similar assignments) influence
> > the generation of executable code.
> > 
> And you are wrong, it doesn't.

I rarely reply or read any Markus' emails as everything
from Markus goes into a 'don't read' folder but I was cc'd
directly on one from someone else recently so I think I
should reply to this one too.

In this case Alexandre it seems true, but in the generic case
it may be false.  It may depend on stack size and location.

For instance, with large structs declared either at the top
of a function or in separate branches within the function:

$ cat t_structs.c
struct a {
	int a[2000];
	int b[4000];
};

struct b {
	char a[100];
	char b[10000];
};

void foo1(struct a *a);
void foo2(struct b *b);

void foo(int index)
{
	if (index) {
		struct a ai = {};

		ai.a[index] = index;
		foo1(&ai);
	} else {
		struct b bi = {};

		bi.b[0] = 1;
		foo2(&bi);
	}
}

void bar(int index)
{
	struct a ai = {};
	struct b bi = {};

	if (index) {
		ai.a[index] = index;
		foo1(&ai);
	} else {
		bi.b[0] = 1;
		foo2(&bi);
	}
}

$

newer gcc versions are smart enough to minimize
stack use in foo() but not bar() so ai and bi start
at the same address in foo() so the total stack
used is smaller.

older gcc versions like 4.8 use separate addresses
for ai and bi in foo() so the total stack used is
larger.

$ gcc-4.8 -Wframe-larger-than=1000 -c t_structs.c
t_structs.c: In function ‘foo’:
t_structs.c:27:1: warning: the frame size of 34116 bytes is larger than 1000 bytes [-Wframe-larger-than=]
 }
 ^
t_structs.c: In function ‘bar’:
t_structs.c:41:1: warning: the frame size of 34116 bytes is larger than 1000 bytes [-Wframe-larger-than=]
 }
 ^

$ gcc-5 -Wframe-larger-than=1000 -c t_structs.c
t_structs.c: In function ‘foo’:
t_structs.c:27:1: warning: the frame size of 24032 bytes is larger than 1000 bytes [-Wframe-larger-than=]
 }
 ^
t_structs.c: In function ‘bar’:
t_structs.c:41:1: warning: the frame size of 34144 bytes is larger than 1000 bytes [-Wframe-larger-than=]
 }
 ^


