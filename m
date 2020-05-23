Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9111DF429
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 04:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgEWC1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 22:27:02 -0400
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:54470 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387427AbgEWC1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 22:27:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E1340837F24A;
        Sat, 23 May 2020 02:27:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:560:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3870:3871:3872:4321:5007:6119:7514:7809:7901:7903:7974:9010:10004:10400:10848:11232:11658:11914:12043:12048:12297:12740:12760:12895:13019:13069:13072:13255:13311:13357:13439:13891:14096:14097:14181:14659:14721:14777:21080:21324:21325:21433:21451:21627:21660:21819:30003:30022:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: hook24_400a8fc26d2c
X-Filterd-Recvd-Size: 2265
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 May 2020 02:26:59 +0000 (UTC)
Message-ID: <7366c990d4352e093ff7d17953079d7f0420c3a9.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update my maintainer entries to reorder
 email addresses
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, mchehab+huawei@kernel.org,
        davem@davemloft.net, robh@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 22 May 2020 19:26:58 -0700
In-Reply-To: <20200523021928.67126-1-skhan@linuxfoundation.org>
References: <20200523021928.67126-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-22 at 20:19 -0600, Shuah Khan wrote:
> get_maintainer.pl picks only the first email address found in the file.
> Reorder my email addresses so it finds my linuxfoundation.org email.

OK.

btw:  --noremove-duplicates is also an option.  For instance:

$ ./scripts/get_maintainer.pl -f Documentation/usb/usbip_protocol.rst
Valentina Manea <valentina.manea.m@gmail.com> (maintainer:USB OVER IP DRIVER)
Shuah Khan <shuah@kernel.org> (maintainer:USB OVER IP DRIVER)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
linux-usb@vger.kernel.org (open list:USB OVER IP DRIVER)
linux-doc@vger.kernel.org (open list:DOCUMENTATION)
linux-kernel@vger.kernel.org (open list)

vs:

$ ./scripts/get_maintainer.pl --noremove-duplicates -f Documentation/usb/usbip_protocol.rst
Valentina Manea <valentina.manea.m@gmail.com> (maintainer:USB OVER IP DRIVER)
Shuah Khan <shuah@kernel.org> (maintainer:USB OVER IP DRIVER)
Shuah Khan <skhan@linuxfoundation.org> (maintainer:USB OVER IP DRIVER)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
linux-usb@vger.kernel.org (open list:USB OVER IP DRIVER)
linux-doc@vger.kernel.org (open list:DOCUMENTATION)
linux-kernel@vger.kernel.org (open list)



