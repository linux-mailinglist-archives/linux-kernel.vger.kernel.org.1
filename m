Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BEA2BB9EC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 00:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgKTXS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 18:18:27 -0500
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:38790 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728359AbgKTXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:18:26 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9655D182CED2A;
        Fri, 20 Nov 2020 23:18:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,3,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2194:2196:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:4321:5007:7903:8660:9108:10012:10400:10848:11026:11232:11658:11914:12043:12296:12297:12346:12438:12740:12895:13069:13148:13160:13229:13230:13311:13357:13439:13894:14659:14721:21080:21627:21939:21990:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:2:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: grade25_3d0ec972734f
X-Filterd-Recvd-Size: 1719
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Nov 2020 23:18:24 +0000 (UTC)
Message-ID: <5e9c1d953c6b6254a3288f1e797064666e82a79d.camel@perches.com>
Subject: Re: [PATCH 001/141] afs: Fix fall-through warnings for Clang
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:18:23 -0800
In-Reply-To: <51150b54e0b0431a2c401cd54f2c4e7f50e94601.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
         <51150b54e0b0431a2c401cd54f2c4e7f50e94601.1605896059.git.gustavoars@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-20 at 12:23 -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple fallthrough pseudo-keywords
> in places where the code is intended to fall through to the next
> case.

This is the first of the actual patches I've seen.
I think adding fallthough for these patches isn't the best option.

> diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
[]
> @@ -322,6 +322,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
>  			return ret;
>  
> 
>  		call->unmarshall++;
> +
> +		fallthrough;

My preference would be to change these to break and not fallthrough;

>  	case 5:
>  		break;
>  	}

etc...

