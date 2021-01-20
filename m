Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A672FDB52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbhATUus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbhATUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:50:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17471C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/shl85XqhoyjZfHGYTKFnCVqIWL+Zr7I2QCEAukUCJU=; b=CTq71W3NU9K2Sdk91yce1P9h4Z
        xZSa1wavHOKoh7ovVUiol7h6ZYxMyGLaARelNyC3i1XJxO6nDnPdG+nJX825HDAVi+ekLXNzf8Hff
        nEA80YfkN9LMEuD+wd/mG8GxIu759GXSA+W+OTtLrx7hUfw6dAZTM0/edZ5vPRKBuC2PtPVTka1lC
        XSoCM4YDTYpUfxZS1L4g0l51MuxzcPRKpgkJPIAhP16KmhScBOsGdJxwB35f0MljZf+soXg6+rNVf
        q01w05dUGldz6wSzmNInmQOAQTECKgBKDdtHeiwo1F2C7CtSE2ZCuuEV1ClByruAXRheQlahBjOfk
        DB+tQDlA==;
Received: from [2001:4bb8:188:1954:aa9e:1db6:1a5a:7fd3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2KN7-00GCJV-FA; Wed, 20 Jan 2021 20:47:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: restore splice and sendfile support on kernfs
Date:   Wed, 20 Jan 2021 21:46:28 +0100
Message-Id: <20210120204631.274206-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Tejun,

this fixes a regression in Linux 5.10 that stopped sendfile and splice
from working on kernfs/sysfs files.

Diffstt:
 file.c |   65 ++++++++++++++++++++++++-----------------------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)
