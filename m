Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526AB233CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 03:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgGaBmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 21:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731064AbgGaBmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:42:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCEEC061574;
        Thu, 30 Jul 2020 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mqhIELekkHe/ZR4guRdlhW7nBODDTfcTLaXo5qRKcCE=; b=F+5Zd8eVBTVGgA8RC/sOFDnIWe
        PyWkPsMUb+WCeKyQP/ndMuWMyii1M6XVwYqo7p2dplrmDklT1SqTHZHDVmcwOcIouXSBbWPLudi1D
        PZZY20mP4xFImyalAbDTKvP2TtXAM/v7NzakNMtuNLyXuf7km0ZQbrAK3/XdDR8e1Fwnx/2OT34pF
        x99WXZ18Yey752Qu3xAYVLE/q+wL8RyZgsFMdepQTgw7yAV3CqyVHcG9aCOv3kvWvFwBpvrSLdsHx
        8+gBpokx502xFujrkesbZQiO19VhdF6WAkDSn53Hn+kwSHJLAdEs/f8ztz90Wqbk2LLrGK921d2Qn
        KKAIutqQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1K4E-0006bc-EF; Fri, 31 Jul 2020 01:42:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 0/7] block: delete or fix duplicated words
Date:   Thu, 30 Jul 2020 18:42:26 -0700
Message-Id: <20200731014233.6418-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop doubled words or fix them to what they should be.
Also fix a few typos and kernel-doc notation.


Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org


 block/bfq-iosched.c  |    2 +-
 block/bio.c          |    4 ++--
 block/blk-mq-sched.c |    2 +-
 block/blk-mq.c       |    2 +-
 block/blk-timeout.c  |    2 +-
 block/elevator.c     |    4 ++--
 block/genhd.c        |    6 +++---
 7 files changed, 11 insertions(+), 11 deletions(-)
