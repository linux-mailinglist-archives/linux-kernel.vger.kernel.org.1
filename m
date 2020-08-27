Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443862544E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 14:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgH0MXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 08:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbgH0MF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:05:28 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44B2A22BF5;
        Thu, 27 Aug 2020 10:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598525652;
        bh=kFFAbpEiWOd1RsbDNrk8SxReMm/OdYxsgBow06GgISE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFnmCoUMqKiiiKwDQnae+sGn28hPOtGpO4uaZUTFxBeLsjZ98g3OxyErLCOmbP+t5
         h3DL3GQIrD6QZK6/e3P4670jOK9lGvOwTlW++TSAE6ATV0+C3wkFYU6/inSAujcSRx
         nNbTByWSaGgMhOYyU4T/KrHxSBjPwWKdVEJ0SyAI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] docs: admin-guide: Not every security bug should be kept hidden
Date:   Thu, 27 Aug 2020 12:53:19 +0200
Message-Id: <20200827105319.9734-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827105319.9734-1-krzk@kernel.org>
References: <20200827105319.9734-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document describes the process of handling security bugs but does not
mention any criteria what is a "security bug".  Unlike
submitting-patches.rst which explicitly says - publicly exploitable bug.

Many NULL pointer exceptions, off-by-one errors or overflows tend
to look like security bug, so there might be a temptation to discuss
them behind security list which is not an open list.

Such discussion limits the amount of testing and independent reviewing.
Sacrificing open discussion is understandable in the case of real
security issues but not for regular bugs.  These should be discussed
publicly.

At the end, "security problems are just bugs".

Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Follow up to:
https://lore.kernel.org/linux-usb/1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com/
---
 Documentation/admin-guide/security-bugs.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index c32eb786201c..7ebddbd4bbcd 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -78,6 +78,12 @@ include linux-distros from the start. In this case, remember to prefix
 the email Subject line with "[vs]" as described in the linux-distros wiki:
 <http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
 
+Fixes for non-exploitable bugs which do not pose a real security risk, should
+be disclosed in a regular way of submitting patches to Linux kernel (see
+:ref:`Documentation/process/submitting-patches.rst <submitting-patches>`).
+Just because patch fixes some off-by-one or NULL pointer exception, does not
+classify it as a security bug which should be discussed in closed channels.
+
 CVE assignment
 --------------
 
-- 
2.17.1

