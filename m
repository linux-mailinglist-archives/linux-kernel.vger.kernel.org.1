Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EDE1A9179
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 05:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbgDODLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 23:11:32 -0400
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:38966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731048AbgDODLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:11:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 66338181D341E;
        Wed, 15 Apr 2020 03:11:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3868:4321:4605:5007:10004:10400:10848:11026:11232:11658:11914:12043:12297:12740:12895:13019:13069:13311:13357:13439:13894:14181:14659:14721:21080:21627:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: floor22_286eb4526923a
X-Filterd-Recvd-Size: 2068
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 Apr 2020 03:11:17 +0000 (UTC)
Message-ID: <414a17ea0978cf65020d9be84f257fe85edc62ab.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: rtl8192u: Refactoring setKey function
From:   Joe Perches <joe@perches.com>
To:     Camylla Cantanheide <c.cantanheide@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        navid.emamdoost@gmail.com, sylphrenadin@gmail.com,
        nishkadg.linux@gmail.com, stephen@brennan.io,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        lkcamp@lists.libreplanetbr.org
Date:   Tue, 14 Apr 2020 20:09:07 -0700
In-Reply-To: <CAG3pEr+huVACoP7sTMALYfE46dc+D8DdGPF0ky6EShd4eXD9eg@mail.gmail.com>
References: <20200413030129.861-1-c.cantanheide@gmail.com>
         <20200414123326.GG1163@kadam>
         <CAG3pEr+huVACoP7sTMALYfE46dc+D8DdGPF0ky6EShd4eXD9eg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-14 at 22:18 -0300, Camylla Cantanheide wrote:
> Em ter., 14 de abr. de 2020 às 09:35, Dan Carpenter <
> dan.carpenter@oracle.com> escreveu:
[]
> > > diff --git a/drivers/staging/rtl8192u/r8192U_core.c
[]
> > > +     target_content = macaddr[0] << 16 |
> > > +                      macaddr[0] << 24 |
> > > +                     (u32)us_config;

And Camylla, this statement should be

+     target_content = macaddr[0] << 16 |
+                      macaddr[1] << 24 |
+                     (u32)us_config;

Not a repeated [0]

> > > +
> > > +     write_nic_dword(dev, WCAMI, target_content);
> > > +     write_nic_dword(dev, RWCAM, target_command++);
> > > +
> > > +     /* MAC */
> > > +     target_content = macaddr[2]       |
> > > +                      macaddr[3] <<  8 |
> > > +                      macaddr[4] << 16 |
> > > +                      macaddr[5] << 24;



