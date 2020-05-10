Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767601CCA1B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 12:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgEJKNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 06:13:39 -0400
Received: from mail.kocurkovo.cz ([185.8.236.170]:47500 "EHLO
        mail.kocurkovo.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgEJKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 06:13:39 -0400
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 4BB873EC5; Sun, 10 May 2020 12:13:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 4BB873EC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1589105616;
        bh=E0i6v1PLlG/Dpi68kRCTMA5zGexAmRdwWxCOCY2+Z6k=;
        h=From:To:Cc:Subject:Date:From;
        b=uJSNVAOsVrUbMTQN6cY0sZqEwH3GH+7nEhUHe6wSEuoXRgHZFDq0lpqOZsSVpQbCp
         ss9pFyUuFBOwCI3u5dznvHAX6dmZrRahZusFP1SNlBMs/jIEha6kzSDxt44xt+qFFY
         lBWTDK6wg7w8Rb/3sLOL/UMz/k5ugwmtlBL8chVw=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        linux-kernel@vger.kernel.org, Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH v2 0/2] staging: vt6656: vt6655: cleaning Makefile
Date:   Sun, 10 May 2020 12:13:33 +0200
Message-Id: <1589105615-22271-1-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset will remove unused definitions of C Macros, reorder variable definition and increase indentation to match visual block.

---
v2: spliting original patch to 2 separate patches

Matej Dujava (2):
  staging: vt6656: vt6655: clean Makefiles
  staging: vt6655: vt6656: change order of makefile variable definitions

 drivers/staging/vt6655/Makefile      | 27 ++++++++++++---------------
 drivers/staging/vt6655/device_main.c |  1 -
 drivers/staging/vt6656/Makefile      |  7 ++-----
 3 files changed, 14 insertions(+), 21 deletions(-)

--
2.26.2

