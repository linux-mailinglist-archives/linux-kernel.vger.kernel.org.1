Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72068265D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 12:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgIKKQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 06:16:35 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:53700 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725778AbgIKKQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:16:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B249D100E7B42;
        Fri, 11 Sep 2020 10:16:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3866:3867:3868:3870:3874:4321:5007:7875:7903:7939:8957:9010:10004:10400:10848:11232:11658:11914:12043:12297:12555:12679:12740:12760:12895:13069:13072:13311:13357:13439:14096:14097:14180:14181:14659:14721:14777:14819:21060:21080:21433:21451:21627:21819:30022:30054:30062:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: shelf69_5d05263270ed
X-Filterd-Recvd-Size: 1890
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Sep 2020 10:16:29 +0000 (UTC)
Message-ID: <7e513eea8ecf7ff1379d7a87245915469784121c.camel@perches.com>
Subject: Re: MAINTAINERS: Marking internal distribution lists
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Date:   Fri, 11 Sep 2020 03:16:28 -0700
In-Reply-To: <alpine.DEB.2.21.2009110811520.9220@felia>
References: <alpine.DEB.2.21.2009110811520.9220@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-11 at 08:37 +0200, Lukas Bulwahn wrote:
> Hi Joe,
> 
> in my continued effort to clean up MAINTAINERS, I came across various 
> email "lists" that are actually just some kind of internal distribution
> lists, but we cannot subscribe to them (no archives available) and they 
> are not affiliated to a specific person.
> 
> Some examples are:
> 
>   - bcm-kernel-feedback-list.broadcom.com
>   - brcm80211-dev-list.cypress.com
>   - brcm80211-dev-list.pdl.broadcom.com
>   - coreteam.netfilter.org
>   - esc.storagedev.microsemi.com
>   - linux-imx.nxp.com
>   - megaraidlinux.pdl.broadcom.com
>   - MPT-FusionLinux.pdl.broadcom.com
>   - ocfs2-devel.oss.oracle.com
>   - oss-drivers.netronome.com
>   - patches.opensource.cirrus.com
>   - qat-linux.intel.com
>   - rds-devel.oss.oracle.com
>   - sparmaintainer.unisys.com
>   - wil6210.qti.qualcomm.com
>   - x86.kernel.org

At one time, those sorts of email addresses were called "exploders"

Perhaps mark them as such?
Maybe like:

L:	megaraidlinux.pdl@broadcom.com (exploder for non-subscribers)


