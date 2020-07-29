Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2F9231984
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 08:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgG2G1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 02:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2G1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:27:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFC3C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tf/gO3FreVKomvUQKozt2vkMCnekTLKNnan8gzEkylo=; b=ju7XvC0AUVrWw6bSF8pd8MS6S1
        xMAqo4WUpjE3aCQgQGiFfjcBJpQlkh5SPldkI00oSFn37aFOwHSkNdw4X2D6eEKwyey4HqYpyCbkn
        b+HGZnopR64JNOdOBM9CXTBEJRxjI0JICPPktkPuYaUbZvQe+iuwA9RqOV04rdn9UgCD2BHmUvQfR
        y3smDz2MGBZY0Lc6/ioC0UXZY5lTlfcYXDZqtmfkNbZCtzoQN4A4WjJ4zDLptI2uxPSbP/Zunjljh
        XptVuIDFWWUDOf+P2aHtCQVBgm6SrHd1eQvgDxUb13WEjLbleV8p7R8zVj5c3o6dym90gXpZSm2Ob
        ZnxF+Kow==;
Received: from 089144218008.atnat0027.highway.a1.net ([89.144.218.8] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0fYW-00040m-5q; Wed, 29 Jul 2020 06:27:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: inherit TAINT_PROPRIETARY_MODULE
Date:   Wed, 29 Jul 2020 08:27:04 +0200
Message-Id: <20200729062711.13016-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

we've had a bug in our resolution of _GPL modules since day one, that
is a module can claim to be GPL licensed and use _GPL exports, while
it also depends on symbols from non-GPL modules.  This is used as a
circumvention of the _GPL exports by using a small shim module using
the _GPL exports and the other functionality.  A recent example can
be found here:

    https://lore.kernel.org/netdev/6376CA34-BC6F-45DE-9FFD-7E32664C7569@fb.com/T/#md514322fdfa212afe9f1d3eb4e5f7eaefece36eb

Diffstat:
 include/linux/module.h |   24 ++----------------------
 kernel/module.c        |   42 +++++++++++++++++++++++++++---------------
 2 files changed, 29 insertions(+), 37 deletions(-)
