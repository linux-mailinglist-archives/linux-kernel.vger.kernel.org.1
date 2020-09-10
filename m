Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260F7263B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 05:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgIJD0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 23:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgIJD0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:26:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DDCC061573;
        Wed,  9 Sep 2020 20:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hNWu6r11XbnWnSUzeS/6VOacMvYJ0OzgTjH9UW8Sfi8=; b=muZzn4CLAo2obv8QjMLLRNHqPH
        d2A2NdUVWcswPqx+DMWymT4+LHcF2tXjBwyJnQPFgPaX3o9iLF/lVRwd7fzEbl9jvVReHOR2MXKIN
        ehwF9jmg48JUxJBJY0c4JjrmEMg6yy/lznve6wt0+uY6QjsZt0OCR2q2BwPTzlKSvShpCqi/InR1K
        +0aujQoSozzuC08FFSYCflkSNfgLKeTvIBJ/XjGx4l82FIA0X1lw1g3v0EIHVvWKRvDjIKHNsaZz5
        ffs/zXwybGhVhaboq9qXWardvgC/M4uLEwer+lZZoA9MQ+glEQoR1213bhkA6ppMiCQCTdHj9+hrw
        G8o7GLYQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGDDu-000659-Nm; Thu, 10 Sep 2020 03:26:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 0/3] Documentation/admin-guide: kernel-parameters: parameter cleanups
Date:   Wed,  9 Sep 2020 20:26:03 -0700
Message-Id: <20200910032606.7355-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org


 [PATCH 1/3] Documentation/admin-guide: kernel-parameters: update CMA entries
 [PATCH 2/3] Documentation/admin-guide: kernel-parameters: hyphenate comma-separated
 [PATCH 3/3] Documentation/admin-guide: kernel-parameters: add early_param() to list of types of boot parameters

 Documentation/admin-guide/kernel-parameters.rst |    4 +-
 Documentation/admin-guide/kernel-parameters.txt |   22 +++++++-------
 2 files changed, 13 insertions(+), 13 deletions(-)
