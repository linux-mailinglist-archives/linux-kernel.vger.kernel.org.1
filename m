Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D6F1C07BB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 22:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgD3UTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 16:19:42 -0400
Received: from mail.kocurkovo.cz ([185.8.236.170]:50384 "EHLO
        mail.kocurkovo.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgD3UTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:19:32 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 16:19:31 EDT
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 2D1F6954; Thu, 30 Apr 2020 22:10:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 2D1F6954
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588277406;
        bh=GRiqx3S89pnK7y7w7UBxwGrz8iZUSDLvCma5su5DnY8=;
        h=From:To:Cc:Subject:Date:From;
        b=OzZrNtkdl+Tr4LsizEOjPoSKbwnO+sLyLOuLT+FGPu9wluqS6K+eYdfijsaeurXth
         1Uqw+iNr2KC0JhrWN8HfiRMZC2rbOp4RxuX8wtW4xRS+1Lxay/50MFJe9pJP62Sl43
         4h1CKo6sJi0ZVis0vVwfSAlGHYY3ayV5jPZlX5iU=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH 0/3] Refactor reused code for updating fb_info
Date:   Thu, 30 Apr 2020 22:09:23 +0200
Message-Id: <1588277366-19354-1-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set will unify reused switch statement updating fb_info by
creating inline functions.

Tested only by compilation.

Matej Dujava (3):
  staging: sm750fb: add missing case while setting FB_VISUAL
  staging: sm750fb: add common function to set color offsets and visual
    mode
  staging: sm750fb: print error message with actual value

 drivers/staging/sm750fb/sm750.c | 150 +++++++++++++++-----------------
 1 file changed, 68 insertions(+), 82 deletions(-)

-- 
2.26.2

