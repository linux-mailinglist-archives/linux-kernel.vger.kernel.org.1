Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64A52CA995
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404005AbgLARZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:25:30 -0500
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:60596 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391673AbgLARZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:25:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 07E5018224D8D;
        Tue,  1 Dec 2020 17:24:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4385:5007:6120:7901:7903:7996:10004:10400:10848:11026:11232:11473:11658:11914:12297:12663:12740:12760:12895:13069:13095:13141:13149:13161:13229:13230:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21212:21433:21627:21660:21740:21990:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: jump74_6009439273ac
X-Filterd-Recvd-Size: 1893
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue,  1 Dec 2020 17:24:46 +0000 (UTC)
Message-ID: <f4392362e682ce7a02eee8a2036e1035342a0b4f.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: add fix and improve warning msg for
 Non-standard signature
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 01 Dec 2020 09:24:44 -0800
In-Reply-To: <20201201112931.11192-1-yashsri421@gmail.com>
References: <20201201112931.11192-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-01 at 16:59 +0530, Aditya Srivastava wrote:
> Currently, checkpatch.pl warns for BAD_SIGN_OFF on non-standard signature
> styles.
>
> This warning occurs because of incorrect use of signature tags,
> e.g. an evaluation on v4.13..v5.8 showed the use of following incorrect
> signature tags, which may seem correct, but are not standard:

I'm not a fan of this patch.

There is already a "non-standard" signature warning for
all of these cases since 2012, predating the range of this
retrospective evaluation by over 5 years and yet these
existing commits have been accepted.

The value in actual standardization and effectively
requiring specific signature style tags is quite low.

Anyone that signed a thing a particular way should be free
to sign the thing as they choose.

Most of these warnings would also still be in the tree in
the future in new patches as running checkpatch without
it emitting a message of any type isn't a requirement nor
should checkpatch use actually be required workflow.


