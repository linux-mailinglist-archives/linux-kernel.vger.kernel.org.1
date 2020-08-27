Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D576D253C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 05:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgH0DMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 23:12:05 -0400
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:36230 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726798AbgH0DMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:12:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C59B21802DA53;
        Thu, 27 Aug 2020 03:12:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:800:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2567:2682:2685:2693:2828:2859:2898:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:8603:8957:9025:9592:10004:10400:10848:11232:11658:11914:12043:12297:12438:12555:12683:12760:12986:13069:13149:13230:13311:13357:13439:14095:14181:14394:14659:14721:14777:21080:21433:21627:21796:21811:21889:21939:30036:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: meal91_421740e27069
X-Filterd-Recvd-Size: 2732
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 03:12:02 +0000 (UTC)
Message-ID: <5e10c1645dd8f735215cf54a74db0f8dd3f6cbd5.camel@perches.com>
Subject: [PATCH] deprecated.rst: Remove now removed uninitialized_var
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Date:   Wed, 26 Aug 2020 20:12:01 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's now gone from the kernel so remove it from the deprecated API text.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/process/deprecated.rst | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 918e32d76fc4..70720f00b9aa 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -51,24 +51,6 @@ to make sure their systems do not continue running in the face of
 "unreachable" conditions. (For example, see commits like `this one
 <https://git.kernel.org/linus/d4689846881d160a4d12a514e991a740bcb5d65a>`_.)
 
-uninitialized_var()
--------------------
-For any compiler warnings about uninitialized variables, just add
-an initializer. Using the uninitialized_var() macro (or similar
-warning-silencing tricks) is dangerous as it papers over `real bugs
-<https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/>`_
-(or can in the future), and suppresses unrelated compiler warnings
-(e.g. "unused variable"). If the compiler thinks it is uninitialized,
-either simply initialize the variable or make compiler changes. Keep in
-mind that in most cases, if an initialization is obviously redundant,
-the compiler's dead-store elimination pass will make sure there are no
-needless variable writes.
-
-As Linus has said, this macro
-`must <https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/>`_
-`be <https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/>`_
-`removed <https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/>`_.
-
 open-coded arithmetic in allocator arguments
 --------------------------------------------
 Dynamic size calculations (especially multiplication) should not be


