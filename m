Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7784228D6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 00:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgJMWor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 18:44:47 -0400
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:39850 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728895AbgJMWor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 18:44:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DA480180A8127;
        Tue, 13 Oct 2020 22:44:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2892:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3874:4321:4384:5007:7875:8557:9592:10004:10400:10848:11026:11232:11473:11658:11914:12043:12291:12296:12297:12438:12555:12663:12683:12740:12760:12895:13141:13230:13439:14093:14097:14181:14659:14721:14915:21080:21451:21627:21990:30012:30029:30054:30070:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: joke67_2600c5827206
X-Filterd-Recvd-Size: 3722
Received: from XPS-9350 (cpe-72-134-80-165.natsow.res.rr.com [72.134.80.165])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 13 Oct 2020 22:44:44 +0000 (UTC)
Message-ID: <3897a8ce5760affa304952c2d30c1266589407f2.camel@perches.com>
Subject: Re: [PATCH 0/2] module: some refactoring in module_sig_check()
From:   Joe Perches <joe@perches.com>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Date:   Tue, 13 Oct 2020 15:44:42 -0700
In-Reply-To: <789a4e5c-8efd-bb1c-86e2-eed8b2b7b0af@omprussia.ru>
References: <789a4e5c-8efd-bb1c-86e2-eed8b2b7b0af@omprussia.ru>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-13 at 23:32 +0300, Sergey Shtylyov wrote:
> Here are 2 patches against the 'modules-next' branch of Jessica Yu's 'linux.git' repo.
> I'm doing some little refactoring in module_sig_check()...
> 
> [1/2] module: merge repetitive strings in module_sig_check()
> [2/2] module: unindent comments in module_sig_check()

I think this code is rather cryptic and could be made clearer.

How about:
---
 kernel/module.c | 51 ++++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index c075a18103fb..98b3af96a5bd 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2884,46 +2884,47 @@ static int module_sig_check(struct load_info *info, int flags)
 	 * Require flags == 0, as a module with version information
 	 * removed is no longer the module that was signed
 	 */
-	if (flags == 0 &&
-	    info->len > markerlen &&
-	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
+	if (flags == 0 && info->len > markerlen &&
+	    !memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen)) {
 		/* We truncate the module to discard the signature */
 		info->len -= markerlen;
 		err = mod_verify_sig(mod, info);
+		if (!err) {
+			info->sig_ok = true;
+			return 0;
+		}
 	}
 
+	/*
+	 * We don't permit modules to be loaded into trusted kernels
+	 * without a valid signature on them, but if we're not enforcing,
+	 * some errors are non-fatal.
+	 */
 	switch (err) {
-	case 0:
-		info->sig_ok = true;
-		return 0;
-
-		/* We don't permit modules to be loaded into trusted kernels
-		 * without a valid signature on them, but if we're not
-		 * enforcing, certain errors are non-fatal.
-		 */
 	case -ENODATA:
-		reason = "Loading of unsigned module";
-		goto decide;
+		reason = "unsigned module";
+		break;
 	case -ENOPKG:
-		reason = "Loading of module with unsupported crypto";
-		goto decide;
+		reason = "module with unsupported crypto";
+		break;
 	case -ENOKEY:
-		reason = "Loading of module with unavailable key";
-	decide:
-		if (is_module_sig_enforced()) {
-			pr_notice("%s: %s is rejected\n", info->name, reason);
-			return -EKEYREJECTED;
-		}
-
-		return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
-
+		reason = "module with unavailable key";
+		break;
+	default:
 		/* All other errors are fatal, including nomem, unparseable
 		 * signatures and signature check failures - even if signatures
 		 * aren't required.
 		 */
-	default:
 		return err;
 	}
+
+	if (is_module_sig_enforced()) {
+		pr_notice("%s: loading of %s is rejected\n",
+			  info->name, reason);
+		return -EKEYREJECTED;
+	}
+
+	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
 }
 #else /* !CONFIG_MODULE_SIG */
 static int module_sig_check(struct load_info *info, int flags)


