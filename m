Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C83741A3E39
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 04:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDJC2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 22:28:46 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:47184 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDJC2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 22:28:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CA3A9182CCCD0;
        Fri, 10 Apr 2020 02:28:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2911:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3867:3868:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4425:5007:8985:9025:10004:10400:10848:11232:11658:11914:12043:12297:12438:12555:12663:12740:12760:12895:13019:13069:13311:13357:13439:14180:14181:14659:14721:21060:21080:21451:21627:21811:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cart95_697e48a2c6740
X-Filterd-Recvd-Size: 1458
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Apr 2020 02:28:44 +0000 (UTC)
Message-ID: <135aaf66d6e9bf38e1d64edbdca9929743c33e4b.camel@perches.com>
Subject: Re: [PATCH v2] staging: rtl8192u: Corrects 'Avoid CamelCase' for
 variables
From:   Joe Perches <joe@perches.com>
To:     Camylla Cantanheide <c.cantanheide@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        lkcamp@lists.libreplanetbr.org
Date:   Thu, 09 Apr 2020 19:26:43 -0700
In-Reply-To: <CAG3pErLnRA-02XfG1pbvv7F=gU06=yTMByuvpX0QjiZvDVqFxw@mail.gmail.com>
References: <20200318211205.188-1-c.cantanheide@gmail.com>
         <bb163d6b706a7b07e8b2e1c51b0da72a5923af97.camel@perches.com>
         <CAG3pErLnRA-02XfG1pbvv7F=gU06=yTMByuvpX0QjiZvDVqFxw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-09 at 23:09 -0300, Camylla Cantanheide wrote:
> Hi Joe,
> 
> Thanks for your review, I'm new to this and I would like to learn.
> 
> I didn't undertand your coment, I was hoping if you could help me clarify a
> bit.

I sent you a suggested patch clarifying the code
rather than clarifying the naming just before this.

https://lore.kernel.org/lkml/a421ed974d7c675a7d41405d483c7645004d4125.camel@perches.com/



