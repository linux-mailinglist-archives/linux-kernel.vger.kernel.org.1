Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5194214089
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 22:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGCU5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 16:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:57:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09623C061794;
        Fri,  3 Jul 2020 13:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UkXgUw0rj6h64dMqaiO/kTrP3MGxNmDX1Ooy/Cz+aYM=; b=dtbpXqOMyL3kRZXSiwqdLmHV5b
        p/XfQsY5R2CMQfCXE1ofzZlc9F0VXZ9Ao5zqh00wwc6W6C8dLOOO/jPwEa4k/d5JzFC7bx2x6sNeh
        OARt9B04NyRuoqjD+WVRxAKjWhfg66CZ3gd8QucYr7EO6iI6E+GZQopuuuBRr1tklYxqqPZ9UU7WH
        wDCAffWpIMjb4IlV9MNc+lbskquqdorX/L42Xgzj9INwrbQAJM5KZ3OvBluxzRr+t72WzMucyPDgA
        jjgkUEXo69At04/eG3cT1CaWDMpRMiJqamezdTYPQwHEiDIti4dbFKPTEtdl3Z93Kf95ONoGMsCNk
        80X7hkFw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrSjx-0003a5-KU; Fri, 03 Jul 2020 20:56:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 1/5] Documenation: hwmon/f71882fg: drop duplicate words
Date:   Fri,  3 Jul 2020 13:56:45 -0700
Message-Id: <20200703205649.30125-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703205649.30125-1-rdunlap@infradead.org>
References: <20200703205649.30125-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "to".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 Documentation/hwmon/f71882fg.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/hwmon/f71882fg.rst
+++ linux-next-20200701/Documentation/hwmon/f71882fg.rst
@@ -145,7 +145,7 @@ motherboard, so the driver assumes that
 properly.
 
 Note that the lowest numbered temperature zone trip point corresponds to
-to the border between the highest and one but highest temperature zones, and
+the border between the highest and one but highest temperature zones, and
 vica versa. So the temperature zone trip points 1-4 (or 1-2) go from high temp
 to low temp! This is how things are implemented in the IC, and the driver
 mimics this.
