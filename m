Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710BD25B880
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 03:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgICB7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 21:59:02 -0400
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]:57856 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgICB7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:59:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5F42B18029587;
        Thu,  3 Sep 2020 01:59:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3868:3870:4321:4605:5007:10004:10400:10848:11026:11232:11233:11473:11658:11914:12043:12297:12438:12679:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:4,LUA_SUMMARY:none
X-HE-Tag: gun42_4f15721270a5
X-Filterd-Recvd-Size: 1615
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu,  3 Sep 2020 01:59:00 +0000 (UTC)
Message-ID: <71837114676678d44500f146a2d98bbe9e541c65.camel@perches.com>
Subject: Re: [PATCH v2] use cpu_to_le{16,32} instead of __constant_cpu_to_*
From:   Joe Perches <joe@perches.com>
To:     Rene Rebe <rene@exactcode.com>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, himanshu.madhani@oracle.com
Date:   Wed, 02 Sep 2020 18:58:59 -0700
In-Reply-To: <20200902.232949.1343752343092794969.rene@exactcode.com>
References: <b7719680-e451-5687-1fb7-c8c059a880d4@acm.org>
         <2C755628-1426-4BA4-B2A3-AD059BB0F605@exactcode.com>
         <c7daea00-410d-2073-bf52-2abda9acdf8e@acm.org>
         <20200902.232949.1343752343092794969.rene@exactcode.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-02 at 23:29 +0200, Rene Rebe wrote:
> As per recommendation, convert a few remaining __constant_cpu_to_le{16,32}
> instances in the qla2xxx, qla4xxx and cifs to just cpu_to_le{16,32}.
[]
> diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
[]
> @@ -3583,7 +3583,7 @@ static int __qlt_send_term_imm_notif(struct scsi_qla_host *vha,
>  
>         /* terminate */
>         nack->u.isp24.flags |=
> -               __constant_cpu_to_le16(NOTIFY_ACK_FLAGS_TERMINATE);
> +               cpu_to_le16(NOTIFY_ACK_FLAGS_TERMINATE);

trivia: this now fits on a single line.


