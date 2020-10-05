Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3632835DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgJEMgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJEMgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:36:19 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9C42085B;
        Mon,  5 Oct 2020 12:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601901378;
        bh=7kNQFuRMbLujrtf3gL6wdyntjtOWLB84yExSiL7nz48=;
        h=Date:From:To:Cc:Subject:From;
        b=ODxGmpa31hsLdYeUKEljiWcczviVn8dRILtVG2fwskri63Aq4XBUEmnrAa+mUQNIX
         XBKkdxgbWuDPHj2OUvGBnSPSjXXmp9JMj68wb0syqC/5GzeaF7k9g5g3Z0n8qKKC2Y
         zFOQw23Pbv1hEGeNO8NIY7RpnzB/sGeq0yBQMVsc=
Date:   Mon, 5 Oct 2020 14:37:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com
Subject: [PATCH] w1: w1_therm: make w1_poll_completion static
Message-ID: <20201005123703.GA800532@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot rightly points out that w1_poll_completion() should be
static, so mark it as such.

Cc: Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index e4baaf92f074..cddf60b7309c 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1031,7 +1031,7 @@ static int reset_select_slave(struct w1_slave *sl)
  *
  * Return: 0 - OK, negative error - timeout
  */
-int w1_poll_completion(struct w1_master *dev_master, int tout_ms)
+static int w1_poll_completion(struct w1_master *dev_master, int tout_ms)
 {
 	int i;
 
