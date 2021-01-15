Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939552F6FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 02:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbhAOBBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 20:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbhAOBBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 20:01:00 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2287EC061757;
        Thu, 14 Jan 2021 17:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mKArbqAdruvusNEdubHVBDte/InN/eE7UtRBk4Ibo+o=; b=pw7EtUQlW5tWIh5NmsZiQEO+yQ
        1boh8Wgmg0sv/AVXEH2cqMUMyC8iYIvetyMnymjlXxtOSYgS4xEcWu/uI/wXPakdbAHAmeN0xbU/y
        F1VUkE5i5iCrUIC7XGbnmZH0OzXC/YLwBoOzM4pOcJhvosTt0bvDRftjgIOPpfBvLwM5IUYkn6eHw
        tZgscXDl+sjagGTqVhLhqzuLTSFbnoERYE7i4qZ1oEV64HM8blf1Lih7GWtbVaGyuoe8aQey8dY12
        4Gjzjr5jjz3QGUH7ZNjGuCl+/pwCIEsXOU3SJjQeZOC8dF1Ruiud7CpDP29ZC6KDLHFjB44kEgJDl
        y2eKyOZw==;
Received: from [2601:1c0:6280:3f0::9abc] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0DTN-0002g1-D7; Fri, 15 Jan 2021 01:00:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] hexagon: remove CONFIG_EXPERIMENTAL from defconfigs
Date:   Thu, 14 Jan 2021 17:00:11 -0800
Message-Id: <20210115010011.29483-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since CONFIG_EXPERIMENTAL was removed in 2013, go ahead and drop it
from any defconfig files.

Fixes: 3d374d09f16f ("final removal of CONFIG_EXPERIMENTAL")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/hexagon/configs/comet_defconfig |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20210114.orig/arch/hexagon/configs/comet_defconfig
+++ linux-next-20210114/arch/hexagon/configs/comet_defconfig
@@ -1,7 +1,6 @@
 CONFIG_SMP=y
 CONFIG_DEFAULT_MMAP_MIN_ADDR=0
 CONFIG_HZ_100=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_CROSS_COMPILE="hexagon-"
 CONFIG_LOCALVERSION="-smp"
 # CONFIG_LOCALVERSION_AUTO is not set
