Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50179235419
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 20:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgHASzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 14:55:47 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:32812 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbgHASzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 14:55:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D684A18224D61;
        Sat,  1 Aug 2020 18:55:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3868:4321:5007:10004:10400:10848:11026:11232:11473:11658:11914:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:21795:30051:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: lock15_30178ef26f8e
X-Filterd-Recvd-Size: 1511
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Aug 2020 18:55:44 +0000 (UTC)
Message-ID: <91c6c45f0d8ec0d031c216711cd8d7f6e9aad7ad.camel@perches.com>
Subject: Re: [PATCH 2/4] audit: uninitialize global variable audit_sig_sid
From:   Joe Perches <joe@perches.com>
To:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>
Date:   Sat, 01 Aug 2020 11:55:43 -0700
In-Reply-To: <20200801184603.310769-3-jbi.octave@gmail.com>
References: <0/4> <20200801184603.310769-1-jbi.octave@gmail.com>
         <20200801184603.310769-3-jbi.octave@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-01 at 19:46 +0100, Jules Irenge wrote:
> Checkpatch tool reports an error at variable audit_sig_sid declaration
[]
> diff --git a/kernel/audit.c b/kernel/audit.c
[]
> @@ -125,7 +125,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
>  /* The identity of the user shutting down the audit system. */
>  kuid_t		audit_sig_uid = INVALID_UID;
>  pid_t		audit_sig_pid = -1;
> -u32		audit_sig_sid = 0;
> +u32		audit_sig_sid;

All of these are unused outside of audit.c and might as
well be static and removed from the .h file.


