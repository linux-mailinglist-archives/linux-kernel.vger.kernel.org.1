Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2F2C1111
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgKWQvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:51:18 -0500
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:56200 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729474AbgKWQvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:51:18 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0CE22180064DA;
        Mon, 23 Nov 2020 16:51:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3872:3874:4321:5007:7903:8660:10004:10400:11026:11232:11658:11914:12297:12740:12895:13069:13148:13161:13229:13230:13311:13357:13439:13894:14096:14097:14181:14659:14721:21080:21627:21740:21939:30012:30034:30045:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: offer33_340137427367
X-Filterd-Recvd-Size: 2459
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Nov 2020 16:51:15 +0000 (UTC)
Message-ID: <276a532e28d290abaaf9cd5969cbacecd51cabc9.camel@perches.com>
Subject: Re: [PATCH 001/141] afs: Fix fall-through warnings for Clang
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Mon, 23 Nov 2020 08:51:14 -0800
In-Reply-To: <748935.1606147853@warthog.procyon.org.uk>
References: <5e9c1d953c6b6254a3288f1e797064666e82a79d.camel@perches.com>
         <cover.1605896059.git.gustavoars@kernel.org>
         <51150b54e0b0431a2c401cd54f2c4e7f50e94601.1605896059.git.gustavoars@kernel.org>
         <748935.1606147853@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-23 at 16:10 +0000, David Howells wrote:
> Joe Perches <joe@perches.com> wrote:
> 
> > >  		call->unmarshall++;
> > > +
> > > +		fallthrough;
> > 
> > My preference would be to change these to break and not fallthrough;
> > 
> > >  	case 5:
> > >  		break;
> > >  	}
> 
> My preference would be to fall through.  The case number is the state machine
> state, as indexed by call->unmarshall.

Then ideally the state machine states should be enums and not numbers
and the compiler should use a default block for unhandled states right?

Is code like call->marshall++ a common style for kernel state machines?
Perhaps not.

Does it work?
Sure.

Is it obvious what the transitions are?
No.

> All the other cases in the switch fall through.
> 
> I would also generally prefer that the fallthrough statement occur before the
> blank line, not after it, since it belongs with the previous clause, and not
> between a comment about a case statement and its associated case statement,
> i.e.:
> 
> 		afs_extract_to_tmp(call);
> 		call->unmarshall++;
> 
> 		/* extract the callback array and its count in two steps */
> 		fallthrough;
> 	case 3:
> 
> would be better written as:
> 
> 		afs_extract_to_tmp(call);
> 		call->unmarshall++;
> 		fallthrough;
> 
> 		/* extract the callback array and its count in two steps */
> 	case 3:

I agree completely.


