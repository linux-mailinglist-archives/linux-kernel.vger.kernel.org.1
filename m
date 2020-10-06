Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B514728441D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 04:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgJFClS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 22:41:18 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:39682 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725973AbgJFClS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 22:41:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 41CF7180A9F42
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 02:41:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:988:989:1260:1277:1311:1313:1314:1345:1381:1437:1515:1516:1518:1534:1538:1561:1593:1594:1711:1714:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3690:3865:3867:3870:4250:5007:6119:7903:10004:10400:10848:11657:11658:11914:12043:12050:12297:12760:13069:13149:13230:13311:13357:13439:14659:14721:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: baby73_2700986271c3
X-Filterd-Recvd-Size: 1120
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 02:41:16 +0000 (UTC)
Message-ID: <9b6f5c32d244131dbd63b55b085b3b4173144b4b.camel@perches.com>
Subject: sysfs filenames with spaces
From:   Joe Perches <joe@perches.com>
To:     LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 05 Oct 2020 19:41:15 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't seem like a great idea to me.

For my system I've got:

/sys/devices/platform/Fixed MDIO bus.0/
/sys/bus/platform/drivers/int3401 thermal/
/sys/bus/platform/drivers/int3403 thermal/
/sys/bus/platform/drivers/int3400 thermal/
/sys/bus/mdio_bus/drivers/Generic PHY/
/sys/bus/mdio_bus/drivers/Generic Clause 45 PHY/
/sys/bus/pnp/drivers/i8042 aux/
/sys/bus/pnp/drivers/i8042 kbd/
/sys/bus/i2c/drivers/CHT Whiskey Cove PMIC/

Could these filenames be avoided in the future or
even renamed today?


