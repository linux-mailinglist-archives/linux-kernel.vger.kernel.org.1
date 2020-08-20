Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1EC24C4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 19:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHTRss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 13:48:48 -0400
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:45654 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726723AbgHTRsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:48:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id DBFAA1800B86B;
        Thu, 20 Aug 2020 17:48:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2198:2199:2200:2393:2553:2559:2562:2828:2898:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:4321:5007:6119:6120:7903:9592:10004:10400:10848:11026:11232:11658:11914:12043:12297:12555:12740:12760:12895:13069:13095:13161:13229:13311:13357:13439:14181:14659:14721:21080:21212:21433:21627:21660:30012:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: name45_221863b27032
X-Filterd-Recvd-Size: 2754
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 20 Aug 2020 17:48:41 +0000 (UTC)
Message-ID: <472f2e553805b52d9834d64e4056db965edee329.camel@perches.com>
Subject: Re: [RFC PATCH 2/5] sysrq: use pr_cont_t for cont messages
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Aug 2020 10:48:40 -0700
In-Reply-To: <CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
         <20200819232632.13418-3-john.ogness@linutronix.de>
         <CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-19 at 18:03 -0700, Linus Torvalds wrote:
> On Wed, Aug 19, 2020 at 4:26 PM John Ogness <john.ogness@linutronix.de> wrote:
> > Use the new pr_cont_t mechanism.
> 
> This looks actively much worse than the old code.

Isn't this just a generic mechanism to simplify
the accumulation of
logging message chunks?

It does seem straightforward enough to me.

And here it seems like the 'for (j =...)' loop is superfluous.

Maybe something like this would be reasonable:
---
 drivers/tty/sysrq.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index a8e39b2cdd55..a145e4fc1a2a 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -572,21 +572,14 @@ void __handle_sysrq(int key, bool check_mask)
 			console_loglevel = orig_log_level;
 		}
 	} else {
-		pr_info("HELP : ");
-		/* Only print the help msg once per handler */
+		pr_context c;
+		pr_info_start(&c, "HELP :");
 		for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++) {
-			if (sysrq_key_table[i]) {
-				int j;
-
-				for (j = 0; sysrq_key_table[i] !=
-						sysrq_key_table[j]; j++)
-					;
-				if (j != i)
-					continue;
-				pr_cont("%s ", sysrq_key_table[i]->help_msg);
-			}
+			if (!sysrq_key_table[i])
+				continue;
+			pr_next(&c, " %s", sysrq_key_table[i]->help_msg);
 		}
-		pr_cont("\n");
+		pr_end(&c, "\n");
 		console_loglevel = orig_log_level;
 	}
 	rcu_read_unlock();


