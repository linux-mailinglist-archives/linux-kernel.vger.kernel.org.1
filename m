Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9AE268369
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 06:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgINEUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 00:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgINETy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 00:19:54 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CA0C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 21:19:54 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4BqY6b1fpPzKmWL;
        Mon, 14 Sep 2020 06:19:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-disposition:content-type:content-type:mime-version
        :message-id:subject:subject:from:from:date:date:received; s=
        mail20150812; t=1600057187; bh=zKy+V7rb+FuqxMusoG0qN2oIsWwWUZ1GX
        77JR4w9blY=; b=SXrTRWhulFgRF7jf30qgus9UVeWzg3rw4c1JZwfFcwjij3dE1
        A6lh/szZ4HFG3YvWpacf3HFlnTcF4S+upXGvqwbjbkFtD3PB0cao+j2j42XnLfM6
        A1BrC9ChQYT7FTXzrGYS7zgf1pISVpY0QOPILT09t7kdTBSzYR5yqUP11GAcZXGW
        1jHAokTdXSsL6iUrQNF0JJ1jSH/E8Gaz/KUDC0mwzSc242DFjHskuWRmUEcu36kF
        zPk2F9zEinKGXbf165jIc10b2AB5MrcfF1A2aIG/zczWcFg/X1G7d1ZSvFnbaTl2
        y2XA/fVGnrHxNWfdoMXPpILrg8gMtFJRgUlzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1600057188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mV5AQWp81oW3j3XIZy6pCjABbRZF75q4qH4GBI6uPrY=;
        b=ud+kMMy3tU5gq1L1fShyhwwkLPRNtwwBZfUse8YOLSXU4qRAnLgygTaSX2XaQba0fDHDen
        DkOZzh7lGnnYOndUsP/57wFwcHHi2A0UKEq2GL5gXGPu1/EZpTN28WX29HUmCdhag1vIEk
        TF3yEpDTV2jHKO51ewuu2W/B7J7kQDw3TZcw0dd8fv2yXfhTyssBfqOHIaX2vq0E3idcoK
        R12w/aSYEa6EKMShB6DpMt/eFqLT0SPycV+u0nQwbAlk45U3IfoJAkvbrqeOX02biiSOp3
        P7Tvf2lZelKR3Lfi12oaLT1EPpvK7lCSUX75gSQej/QEYp5V6GXyglKw/nJXUg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id y4lD_6IgxA-2; Mon, 14 Sep 2020 06:19:47 +0200 (CEST)
Date:   Mon, 14 Sep 2020 06:19:45 +0200
From:   Wilken Gottwalt <wilken.gottwalt@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2] documentation: arm: sunxi: Allwinner H2+/H3 update
Message-ID: <20200914041945.GA3500@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.66 / 15.00 / 15.00
X-Rspamd-Queue-Id: A21B34F6
X-Rspamd-UID: ad6555
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated information about H2+ and H3 differences and added a link to a
slightly newer datasheet.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
---
Changes in v2:
        - addressed comments/proposals from Maxime
---
 Documentation/arm/sunxi.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm/sunxi.rst b/Documentation/arm/sunxi.rst
index b037428aee98..19d78eea31a9 100644
--- a/Documentation/arm/sunxi.rst
+++ b/Documentation/arm/sunxi.rst
@@ -103,12 +103,14 @@ SunXi family
 
         * No document available now, but is known to be working properly with
           H3 drivers and memory map.
+        * The changes compared to a H3 are a downgraded GMAC to a 100MBit MAC
+          and the display engine (DE) not having support for 4k.
 
       - Allwinner H3 (sun8i)
 
         * Datasheet
 
-          http://dl.linux-sunxi.org/H3/Allwinner_H3_Datasheet_V1.0.pdf
+          https://linux-sunxi.org/images/4/4b/Allwinner_H3_Datasheet_V1.2.pdf
 
       - Allwinner R40 (sun8i)
 
-- 
2.28.0

