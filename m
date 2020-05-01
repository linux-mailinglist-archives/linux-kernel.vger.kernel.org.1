Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B019A1C1F0B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 22:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgEAUwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 16:52:51 -0400
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]:54408 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgEAUwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:52:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 9AC98181D3025;
        Fri,  1 May 2020 20:52:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:4250:4321:4385:5007:6119:8957:10004:10400:10848:11232:11658:11914:12043:12297:12555:12663:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21627:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: balls69_358bf361e1e3c
X-Filterd-Recvd-Size: 2389
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 May 2020 20:52:47 +0000 (UTC)
Message-ID: <93f764ad743082f2bbab4595eb892c2004e61b44.camel@perches.com>
Subject: Re: [PATCH 03/24] rcu/tree: Use consistent style for comments
From:   Joe Perches <joe@perches.com>
To:     paulmck@kernel.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Date:   Fri, 01 May 2020 13:52:46 -0700
In-Reply-To: <20200501190555.GB7560@paulmck-ThinkPad-P72>
References: <20200428205903.61704-1-urezki@gmail.com>
         <20200428205903.61704-4-urezki@gmail.com>
         <20200501190555.GB7560@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-01 at 12:05 -0700, Paul E. McKenney wrote:
> On Tue, Apr 28, 2020 at 10:58:42PM +0200, Uladzislau Rezki (Sony) wrote:
> > Simple clean up of comments in kfree_rcu() code to keep it consistent
> > with majority of commenting styles.
[]
> on /* */ style?
> 
> I am (slowly) moving RCU to "//" for those reasons.  ;-)

I hope c99 comment styles are more commonly used soon too.
checkpatch doesn't care.

Perhaps a change to coding-style.rst
---
 Documentation/process/coding-style.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index acb2f1b..fee647 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -565,6 +565,11 @@ comments is a little different.
 	 * but there is no initial almost-blank line.
 	 */
 
+.. code-block:: c
+
+	// Single line and inline comments may also use the c99 // style
+	// Block comments as well
+
 It's also important to comment data, whether they are basic types or derived
 types.  To this end, use just one data declaration per line (no commas for
 multiple data declarations).  This leaves you room for a small comment on each


