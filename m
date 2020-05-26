Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6276D1DD8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 22:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgEUU6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 16:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgEUU6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:58:46 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 854F320823;
        Thu, 21 May 2020 20:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590094726;
        bh=WO6/sBNznH3sZTb0GZPogg/y2VoSy9IiQArmJd2k22E=;
        h=Subject:From:To:Date:From;
        b=c0/iropJ25RumE8zSIhy7Jp3hhkDAeMMf+3nNnnzq8P7DnKsmkdFFRPpieFyXtLPd
         VjiY6SpIuHibrgQob4RC3c1IqhZ3suOFn46rONfOIdM0x9unZkes14t6b2fAOk3A6n
         EodS4FjWSDGIjYhvcuOuPabTtl2k1smj5vs4k8m0=
Message-ID: <6cae947a1298eb28a2688d311be4bde06b32aabd.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.124-rt53
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Thu, 21 May 2020 15:58:44 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.124-rt53 stable release.

This release is just an update to the new stable 4.19.124
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: e871e0865991f47c69ce9c7e2f8ff11d105ac6cc

Or to build 4.19.124-rt53 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.124.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.124-rt53.patch.xz

Enjoy!

   Tom

