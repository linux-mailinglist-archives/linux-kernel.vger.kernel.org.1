Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E8D2DD843
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 19:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgLQS0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 13:26:14 -0500
Received: from smtprelay0196.hostedemail.com ([216.40.44.196]:59408 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727368AbgLQS0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 13:26:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 0D1FF182CF668;
        Thu, 17 Dec 2020 18:25:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3874:4078:4081:4321:5007:6119:7903:7904:10004:10400:10450:10455:11026:11232:11658:11914:12048:12296:12297:12555:12740:12760:12895:12986:13439:14181:14659:14721:14824:19904:19999:21080:21524:21611:21627:21660:21740:30012:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: scene95_61178ef27436
X-Filterd-Recvd-Size: 4105
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Dec 2020 18:25:30 +0000 (UTC)
Message-ID: <b1f96f39e78fc3869bf2786f50f833778dd09fb5.camel@perches.com>
Subject: Re: New objtool warning..
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 17 Dec 2020 10:25:29 -0800
In-Reply-To: <CAHk-=wiJ7xt913Lf6rfeq4CyffhXwHLVZ2ZABcKHmV8cf0FArg@mail.gmail.com>
References: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
         <20201216044918.jdmi32dz75uboybv@treble>
         <CAHk-=wjMoZesNgi1yWzY3nikyR11PUxHgov561UNom5mL1R4rA@mail.gmail.com>
         <CAHk-=whpp_eo-5d0ZLpx=0X91J0ZNReZ_9riNf96z2dy24z=hw@mail.gmail.com>
         <20201216200158.akf356yrw44o2rlb@treble>
         <20201217104556.GT3040@hirez.programming.kicks-ass.net>
         <20201217162524.fkxiemn7aezpv7d5@treble>
         <CAHk-=wiJ7xt913Lf6rfeq4CyffhXwHLVZ2ZABcKHmV8cf0FArg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-17 at 09:27 -0800, Linus Torvalds wrote:
> On Thu, Dec 17, 2020 at 8:25 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > Oh yeah, I forgot about that.  That would be another option if my patch
> > doesn't work out.
> 
> Well, one option is to just say "ok, we know gcc generates horrible
> code that falls through to another function in a situation that we
> claim is unreachable, so let's not claim it is unreachable".
> 
> IOW, the problem here is that the compiler fundamentally isn't smart
> enough to see that something is unreachable, and the "unreachable()"
> annotation we did didn't actually really cause any code that makes it
> so. So we basically have code that _if_ we ever change it, it will
> simply be wrong, and we'll never see any warnings about it but it will
> fall through to nonsensical code.
> 
> So maybe the option here is simply "objtool was right before, the
> unreachable() is fragile and wrong".
> 
> We can easily write that case statement in a way that actually makes
> the compiler generate better code and avoids the issue by just making
> case 0x00 also be the default case.
> 
> So I think I'll just apply this patch instead.

Using default somewhere other than the bottom of a switch/case block
isn't common/pretty.  It's easy to visually skip/glaze over.

Perhaps reorder the block.
Maybe add static to the const arrays too.
---
 drivers/gpu/drm/drm_edid.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 74f5a3197214..53b7bb281edb 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3089,8 +3089,8 @@ static int drm_cvt_modes(struct drm_connector *connector,
 	struct drm_display_mode *newmode;
 	struct drm_device *dev = connector->dev;
 	struct cvt_timing *cvt;
-	const int rates[] = { 60, 85, 75, 60, 50 };
-	const u8 empty[3] = { 0, 0, 0 };
+	static const int rates[] = { 60, 85, 75, 60, 50 };
+	static const u8 empty[3] = { 0, 0, 0 };
 
 	for (i = 0; i < 4; i++) {
 		int width, height;
@@ -3102,20 +3102,18 @@ static int drm_cvt_modes(struct drm_connector *connector,
 
 		height = (cvt->code[0] + ((cvt->code[1] & 0xf0) << 4) + 1) * 2;
 		switch (cvt->code[1] & 0x0c) {
-		case 0x00:
-			width = height * 4 / 3;
-			break;
-		case 0x04:
-			width = height * 16 / 9;
+		case 0x0c:
+			width = height * 15 / 9;
 			break;
 		case 0x08:
 			width = height * 16 / 10;
 			break;
-		case 0x0c:
-			width = height * 15 / 9;
+		case 0x04:
+			width = height * 16 / 9;
 			break;
 		default:
-			unreachable();
+			width = height * 4 / 3;
+			break;
 		}
 
 		for (j = 1; j < 5; j++) {


