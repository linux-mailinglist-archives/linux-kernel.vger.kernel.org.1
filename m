Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF727E83C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgI3MKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbgI3MKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:10:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B675B2076E;
        Wed, 30 Sep 2020 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601467804;
        bh=wEaTNwm+t8iDeqGsvqHnQ7jAGgh0Ut3DrEatmmujGCE=;
        h=Date:From:To:Cc:Subject:From;
        b=V8GLN8CS/2Jaedfn+tCa3zfkFonmLsaPvOxaIzYPItZTA2M0SzQxB5kufZnNTuyMn
         TIIQHdRcd1F8nkPEypvSDx3r7SpclfmRpIoOWProCmyI/zt9RXeokpA2+pVWJxY/Qk
         XAFEjwDqGeEVJItUH7mH+q9QTC8TgvJu6GFZUWVA=
Date:   Wed, 30 Sep 2020 14:10:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] MAINTAINERS: exclude char maintainers from things they do
 not maintain
Message-ID: <20200930121007.GA1615300@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of subdirectories and files in drivers/char/ that
have their own maintainers and developers and ways of getting patches to
Linus.  This includes random.c, IPMI, hardware random drivers, TPM
drivers, and agp drivers.  Instead of sending those patches to Arnd and
myself, who can't do anything with them, send them to the proper
developers instead.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index d6b9445649e5..a6f0a3ec0047 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4101,6 +4101,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 F:	drivers/char/
 F:	drivers/misc/
 F:	include/linux/miscdevice.h
+X:	drivers/char/agp/
+X:	drivers/char/hw_random/
+X:	drivers/char/ipmi/
+X:	drivers/char/random.c
+X:	drivers/char/tpm/
 
 CHECKPATCH
 M:	Andy Whitcroft <apw@canonical.com>
