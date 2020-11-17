Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CDA2B6B97
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgKQRT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgKQRTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:19:55 -0500
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6D9B2465E;
        Tue, 17 Nov 2020 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605633594;
        bh=F894O72Ff43eVcEhgtWI2dFdRNSdXrZRZxZM1VJ2XvA=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=qAscs2fbQ4IKoyiTYkoKy+5aRwJrM2FRIOcjP1zOkkcJBKmMvEwSdsSR0iHmCmSoB
         dY7k37924QKz6q6UFAcckedUE3zce7zn2mHIcuY1GUwbbj1oMDoyLz/uO06YLD4ouw
         jdm6cz6tqUPfOjaSEpNQ+dss2sSbc4gkVUBsZvf4=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 3/3] Linux 4.19.152-rt66-rc1
Date:   Tue, 17 Nov 2020 11:19:48 -0600
Message-Id: <866d992ded11ac5f4bc54ddf3677934366a8d735.1605633581.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1605633581.git.zanussi@kernel.org>
References: <cover.1605633581.git.zanussi@kernel.org>
In-Reply-To: <cover.1605633581.git.zanussi@kernel.org>
References: <cover.1605633581.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v4.19.152-rt66-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index e2eb19782d4c..8def1daec031 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt65
+-rt66-rc1
-- 
2.17.1

