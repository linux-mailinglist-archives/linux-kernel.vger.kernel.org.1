Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5164221980
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 03:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgGPBaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 21:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgGPBaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:30:17 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4ECC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 18:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=FXWTphzrW3vR3I8XbwNjBExTeT5BTHwhRLPG9dUD25I=; b=TCIyS9POj33Ywy9ZzSqL1x7k5Y
        YFcrZQnslWppa4+qd9OVbMQfsq5SuLF3YM+3fkvBduCq9NNqFBAsq0NeUmiTUctnE8Hqphwfl88Jo
        5J9DJRS+Aoiy78X8XFKPvvbpbrAzNiLhTGJQC+6m8XUMPU+2UXh0mRWC/tn1sbJ7bqdCKSRc97mjA
        TUs7DVBqt4mXuJASM1+NpNiZeFeBj7AAQOQb3GMGmgkFHW4Ufi94NaSatqxfwTjewdX2P31mFoNiW
        kC0TgWrmM/eatHudKikAurZ0ApRdaR3yeim4gO8/FeEBmVvKDiWXd/ZORWioQYEsvlGwe10Wx+iVm
        bRsV9+cg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvsj0-0000W0-Oy; Thu, 16 Jul 2020 01:30:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] regmap: fix duplicated word in <linux/regmap.h>
To:     LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Message-ID: <7ef41bfc-de3e-073a-8746-0b3fdf7628c0@infradead.org>
Date:   Wed, 15 Jul 2020 18:30:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Change doubled word "be" to "to be".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
---
 include/linux/regmap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/regmap.h
+++ linux-next-20200714/include/linux/regmap.h
@@ -275,7 +275,7 @@ typedef void (*regmap_unlock)(void *);
  *			readable if it belongs to one of the ranges specified
  *			by rd_noinc_table).
  * @disable_locking: This regmap is either protected by external means or
- *                   is guaranteed not be be accessed from multiple threads.
+ *                   is guaranteed not to be accessed from multiple threads.
  *                   Don't use any locking mechanisms.
  * @lock:	  Optional lock callback (overrides regmap's default lock
  *		  function, based on spinlock or mutex).

