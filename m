Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B7D25ED38
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 09:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgIFHj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 03:39:28 -0400
Received: from smtprelay0121.hostedemail.com ([216.40.44.121]:33348 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725306AbgIFHj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 03:39:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 99040180AA519;
        Sun,  6 Sep 2020 07:39:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1560:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:8985:9010:9025:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:21788:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: smell58_190c540270c1
X-Filterd-Recvd-Size: 1579
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun,  6 Sep 2020 07:39:25 +0000 (UTC)
Message-ID: <144eeac72c832655f28d35bd0ffc504b7c74b395.camel@perches.com>
Subject: Re: [linux-next PATCH v4] drivers/virt/fsl_hypervisor: Fix error
 handling path
From:   Joe Perches <joe@perches.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, timur@freescale.com,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Sun, 06 Sep 2020 00:39:23 -0700
In-Reply-To: <CAFqt6zZ81MwsFUGgfOBG57p=4wfW=5k2RUUub3xgmKNa2cnpzA@mail.gmail.com>
References: <1598995271-6755-1-git-send-email-jrdr.linux@gmail.com>
         <a3b36dfa-b7bb-e69b-95d5-e7d6dd7bda3f@nvidia.com>
         <CAFqt6zaB_wcrUzmOJ6kQWMqdcPrENyJO4FNc_UU5z-AQQh_e3w@mail.gmail.com>
         <4d63100c-fe60-57ad-2924-7b28dbd14c20@nvidia.com>
         <CAFqt6zZ81MwsFUGgfOBG57p=4wfW=5k2RUUub3xgmKNa2cnpzA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-09-06 at 07:47 +0530, Souptick Joarder wrote:
> While running ./scripts/get_maintainer.pl, I observed one issue. Everytime I run
> the script, list is getting changed. Is it an expected behaviour ?

Yes.
https://lkml.org/lkml/2017/7/13/789


