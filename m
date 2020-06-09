Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FAF1F4284
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 19:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgFIRhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 13:37:13 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:44426 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728848AbgFIRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:37:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 61C6A10051150;
        Tue,  9 Jun 2020 17:37:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1042:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1568:1593:1594:1711:1714:1730:1747:1777:1792:1801:2194:2199:2393:2559:2562:2729:2828:3138:3139:3140:3141:3142:3622:3865:3867:3872:4225:4321:4362:4605:5007:7903:8957:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21325:21451:21611:21627:21772:21990:30054:30056:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:4,LUA_SUMMARY:none
X-HE-Tag: waves38_2c1561926dc4
X-Filterd-Recvd-Size: 1835
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jun 2020 17:37:11 +0000 (UTC)
Message-ID: <64758b6f2142a1b2a170de38b80f2dbe6c70ceb2.camel@perches.com>
Subject: Re: [PATCH 1/1] tty: fix spelling mistake
From:   Joe Perches <joe@perches.com>
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 10:37:01 -0700
In-Reply-To: <20200609160249.31329-1-f.suligoi@asem.it>
References: <20200609160249.31329-1-f.suligoi@asem.it>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-09 at 18:02 +0200, Flavio Suligoi wrote:
> Fix typo: "tigger" --> "trigger"

Thanks.

fyi:

$ git grep -w -i tigger
drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c:                       * software tigger (systrig, hrtimer).
drivers/leds/led-triggers.c:/* Simple LED Tigger Interface */
drivers/scsi/mpt3sas/mpt3sas_trigger_diag.h:/* fake firmware event for tigger */
drivers/tty/moxa.h:#define IntrRxTrigger        0x100   /* rx data count reach tigger value */
kernel/trace/trace.c:    * to store the trace event for the tigger to use. It's recusive
tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc:echo "Test histogram basic tigger"
tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc:echo "Test stacktrace tigger"
tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc:echo "Test histogram trace_marker tigger"
tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc:echo "Test snapshot trace_marker tigger"



