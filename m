Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D928CD9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgJMMBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbgJMLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:42 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C08A22273;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590080;
        bh=lFEzsRGazv6x3BF+7IzZhV96OJvEaoKXaQrpvpjxmPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOzuU+/GKgLO/HD9vu/6LsZ1ZmGSoHuI/QrjaPpfprorH8i6dKJs+l+OfZa3wDDg+
         dLaizJiliPzHuA8iga4Rsm33x2m+WsZeMvpNrkAd4qlFajtSlbxcmUckjy4MepoDpD
         NCJT7F8614YApqZLczfgRC5UTLlV8/MKtzi4UW38=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CUW-FM; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 30/80] docs: basics.rst: move kernel-doc workqueue markups to workqueue.rst
Date:   Tue, 13 Oct 2020 13:53:45 +0200
Message-Id: <f19293340b028a47925119ac40805c9a853edf2f.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there's already a rst file with workqueue markups, containing
part of them, move the other definitions, in order to avoid
warnings with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/core-api/workqueue.rst | 2 ++
 Documentation/driver-api/basics.rst  | 9 ---------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 00a5ba51e63f..541d31de8926 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -396,3 +396,5 @@ Kernel Inline Documentations Reference
 ======================================
 
 .. kernel-doc:: include/linux/workqueue.h
+
+.. kernel-doc:: kernel/workqueue.c
diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
index 1ba88c7b3984..54f8d5ca7475 100644
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -55,15 +55,6 @@ High-resolution timers
 .. kernel-doc:: kernel/time/hrtimer.c
    :export:
 
-Workqueues and Kevents
-----------------------
-
-.. kernel-doc:: include/linux/workqueue.h
-   :internal:
-
-.. kernel-doc:: kernel/workqueue.c
-   :export:
-
 Internal Functions
 ------------------
 
-- 
2.26.2

