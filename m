Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E526527520D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIWHAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIWHAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:00:06 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD86C061755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 00:00:05 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Bx8FH14zszKmTr;
        Wed, 23 Sep 2020 09:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-disposition:content-type:content-type:mime-version
        :message-id:subject:subject:from:from:date:date:received; s=
        mail20150812; t=1600844396; bh=m10LheO8hc5AI3VYvBglXLGEZcTkk0rjW
        7Uhrs4vdOk=; b=GeTKrE6M4y9Gd2N1tHH+lX09P7fvOdNx/ujlg8tvcg0a1WYlh
        ssoMKLUILdUyXVbwdKTr7KMj/ExcY7r9ZHSmjDGrIcJELYxErgFUzH/9nZDqnEa5
        wP2YsIyMYLih2b/O8apSXVq6HOMtskIDU0NPpH2Q53jzree3XdG7VnVOiV2dwLfC
        6oVQ2OyorhqYi15dUectgskmImV1B0EBdSKytpfWCb4q9OqeaUZhIURKmyW7D/jq
        iNBby3I0kikFbowFsWcAxp311tVXA33pocVPVvi4Mpx31NFlyptBU7owHRMip/Ds
        KDmuZeZ4lbotEJtqpPrpfkCiDg8872bpgBn6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1600844401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9gZd7rnzxPz4I30I17DO7K+dtQx0yJP49ux50Wew3RA=;
        b=teYqrsmgGO3ebw/RwyFBlGmcwg97sAO3fYUtpk9ME+BTT1qEV44ForflyVVHO/5gybwCy9
        OgOSime65YW9WG1nO4BYSlFezF9nfM0B346+B4Ge3rta4DDmZvIENLQDeBPkkwgygofm00
        0tJjXBdYerz9ccdcvG0IDIac3hJ4dwQQHQ+QoR1ujncIN+rPWs2ksq/FvRvO16cG99swvc
        mIadhQO5aJksUWFarLx5qxcTzzdg+S9BWpNbQ2AKU6riMdQBrdb1CHwiIlhfuP/NiBJh27
        f4eLaCI76JBduJHKvxn4XsdGiuxU7sHsab0DjX6Mk9AMuvczkclKMlSImuspOA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id Iq7v9dox7M4T; Wed, 23 Sep 2020 08:59:56 +0200 (CEST)
Date:   Wed, 23 Sep 2020 08:59:54 +0200
From:   Wilken Gottwalt <wilken.gottwalt@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v3] documentation: arm: sunxi: Allwinner H2+/H3 update
Message-ID: <20200923065954.GA22809@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.59 / 15.00 / 15.00
X-Rspamd-Queue-Id: D4C531696
X-Rspamd-UID: c2997d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced the link to the datasheet by a link to the current version.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
---
Changes in v3:
        - removed the description of the H2+/H3 differences
Changes in v2:
        - addressed comments/proposals from Maxime
---
 Documentation/arm/sunxi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm/sunxi.rst b/Documentation/arm/sunxi.rst
index b037428aee98..62b533d0ba94 100644
--- a/Documentation/arm/sunxi.rst
+++ b/Documentation/arm/sunxi.rst
@@ -108,7 +108,7 @@ SunXi family
 
         * Datasheet
 
-          http://dl.linux-sunxi.org/H3/Allwinner_H3_Datasheet_V1.0.pdf
+          https://linux-sunxi.org/images/4/4b/Allwinner_H3_Datasheet_V1.2.pdf
 
       - Allwinner R40 (sun8i)
 
-- 
2.28.0

