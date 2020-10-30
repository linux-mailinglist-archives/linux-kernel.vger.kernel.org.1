Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B0F29FED3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgJ3Hms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgJ3HlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:05 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F0AA2240C;
        Fri, 30 Oct 2020 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043663;
        bh=UBNZVdHq9PIvX3zxVtLZW8p3WIJ4/d404+9rOLhRsWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbbQUzWd9uHpG3BO4H6GlVTyIt2YczYSjRpLYx/0maiJeCLEJq7rBzkiez32oXp0C
         56tPQR+13CHrE7QYqVFArtuzyiyYkvbajenCEH8AygkB6UuD0ZkjBRKnrNw8KWwzgV
         jRQgLxgga6mKVge8ii0juzLqMSnS1px2s0EeIWwU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1x-004Ogb-HI; Fri, 30 Oct 2020 08:41:01 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/39] docs: ABI: vdso: use the right format for ABI
Date:   Fri, 30 Oct 2020 08:40:48 +0100
Message-Id: <28c7cf3a71e15fb7499b70ec8f38c2efaaf4add2.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ABI is not following the format described at ABI/README.

Use it, filling in the blanks with the git log that added it,
and using the current e-mail from Andy.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/stable/vdso | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/stable/vdso b/Documentation/ABI/stable/vdso
index 73ed1240a5c0..951838d42781 100644
--- a/Documentation/ABI/stable/vdso
+++ b/Documentation/ABI/stable/vdso
@@ -1,3 +1,9 @@
+What:		vDSO
+Date:		July 2011
+KernelVersion:	3.0
+Contact:	Andy Lutomirski <luto@kernel.org>
+Description:
+
 On some architectures, when the kernel loads any userspace program it
 maps an ELF DSO into that program's address space.  This DSO is called
 the vDSO and it often contains useful and highly-optimized alternatives
-- 
2.26.2

