Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB625A2C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 03:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIBBmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 21:42:49 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:33475 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgIBBlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:41:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6024B5804A3;
        Tue,  1 Sep 2020 21:40:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Sep 2020 21:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        guYHnQ7EswX0GQr05sidaNaBve50E5i1KBPcTUc5iCU=; b=jM9LhOBcI7AI7VLe
        TX2rRjp0C97yMUh3OEI1LdL7GlWdHJh7aYlmA97RezDH9/j0quimpXVba9Q3Wq7J
        q3hQ4TFyXlmR9Voi5d7eS5YtWhj7oe9NglflfOXBWIrQz1XcMcvVZHzA/XkDuzOf
        RHKu9yMb8lBOJtoLz4WGlauus4JAtHrQSzgIabouE6ETY5IzpRi6JfEUARdUsV7a
        KIIcDj7HC/hIW+PGxu4wrnXcaTnTsPdXlv8Q37R7v/XmOln/+oYBqOgD1qaiCrfT
        L4UruDLi3IcPqVO9LDxhCK59LwLlhWqUCxIYNaJory8+0/1lkt3stI7O7EsgjkrI
        bDmSUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=guYHnQ7EswX0GQr05sidaNaBve50E5i1KBPcTUc5i
        CU=; b=lhl3QM5tI0c9/3fkPGvmjGq+zUvd1KZnp5XsMkkP87hvvd0zCidDsWJcf
        v1FmmtczK8wsC1FU3RqR3sFtiFp7Gq1NcLu/h9Y7geq5P6bqtUa04rHRZNb/Pvt9
        uX5NbjXR/GVUymIMaEW7OYRTbNwEmihWfooTYy5Ivzbx2AJDXAaYisaYaPfGbRwY
        Idwh8JD2jCY/o7GCb3HngiB4+7bwDo+tUHq3Mdx6vK8zMkDRNPVx28838D87sWqg
        OEmnJRZuKysftiksfpslc1KOuX8tsNLlZaGlM/cstWvk0niQU9OyIQoXuZJik3dA
        QnOlEaucrafWjZ4lJ1MfKTdzkWM+w==
X-ME-Sender: <xms:CvhOX7dBwPNhunfx0IABxrH3sQy2MkK0xh7niwHH2YXxyyiwEsAPEA>
    <xme:CvhOXxOBkBJA_Hqg1Ll861Iv707sgtVWRZ9X7vNWyjx59iS_hQGCFNgnQ661qnJ6A
    qb6CZOXjuxy0JmIQuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefkedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthh
    hordhpihiiiigrqeenucggtffrrghtthgvrhhnpeejheegveffgffhiedtgeektefhffef
    ffelvddvhffhvedutdffledtieeiveejleenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecukfhppeejfedrvddujedruddtrdeitdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:CvhOX0hfYirCJ6q9ZmM5lHrjfCV0gACs0waW-8tl79JGf5mAgtkpLg>
    <xmx:CvhOX8-twPiPzHB7ScHYUZ5qBZYUNjzgCJKhD6yzZAn5H1XhFQsvzg>
    <xmx:CvhOX3u_Sf-47W8VPnQIQTt5iHmM7ORZl4X-js8P_g-WkQMQTBD-3A>
    <xmx:C_hOXw4hAYUW12H-TVD7CePbllQueS73sCMxIwOdZKtCfI28-2lW5IftDsc>
Received: from cisco.hsd1.co.comcast.net (c-73-217-10-60.hsd1.co.comcast.net [73.217.10.60])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1B7D1328005A;
        Tue,  1 Sep 2020 21:40:26 -0400 (EDT)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, "Tobin C . Harding" <me@tobin.cc>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH 2/2] mailmap, MAINTAINERS: move to tycho.pizza
Date:   Tue,  1 Sep 2020 19:40:17 -0600
Message-Id: <20200902014017.934315-2-tycho@tycho.pizza>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902014017.934315-1-tycho@tycho.pizza>
References: <20200902014017.934315-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've changed my e-mail address to tycho.pizza, so let's reflect that in
these files.

Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 332c7833057f..50096b96c85d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -308,6 +308,7 @@ Tony Luck <tony.luck@intel.com>
 TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
 TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
 Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
+Tycho Andersen <tycho@tycho.pizza> <tycho@tycho.ws>
 Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
 Uwe Kleine-König <ukl@pengutronix.de>
 Uwe Kleine-König <Uwe.Kleine-Koenig@digi.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index e4647c84c987..2c60f3ec2496 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9776,7 +9776,7 @@ F:	drivers/scsi/53c700*
 
 LEAKING_ADDRESSES
 M:	Tobin C. Harding <me@tobin.cc>
-M:	Tycho Andersen <tycho@tycho.ws>
+M:	Tycho Andersen <tycho@tycho.pizza>
 L:	kernel-hardening@lists.openwall.com
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git
-- 
2.25.1

