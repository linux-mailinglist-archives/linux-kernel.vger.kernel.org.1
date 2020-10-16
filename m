Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16103290638
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407816AbgJPNXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406892AbgJPNXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:23:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DE5C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=f6m35M2p1AgpB94/uwzsw25InjbLlfZsf1jNobIxtRQ=; b=t19IzrzZb7dlnAk7vFzGOJtTV+
        QraJo0L9KL20X4zhW3O9D7AONtknieWIj8tT7EXT3cLFte0G2WRF4QAxYGqiIu7st18JzkJj7RHKU
        hiEPd9LsaZe+2Cm5exzqBzxS/OFYijLp4X7qRyyL1SlGJeusjZ55oE6ms/2McKXAesEpyHrwbaih7
        aynMxfI1gFJh14gMkRyvGo4DPwNTE0tBt+tBBd/yZcVrZ+GnQHomsOFHEZSXw1kuCvUB+qlbp/g/C
        5EtrKM5Fs0J3OaWZxAN4kk7m9HXEEwtBt6CddFHZoIdbTLGMubkjE6z+eFK/Jz8diNPxZFXkO/3+X
        nF5T5J7Q==;
Received: from 213-225-9-134.nat.highway.a1.net ([213.225.9.134] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTPhE-0002rt-Ru; Fri, 16 Oct 2020 13:23:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: simplify pstore-blk
Date:   Fri, 16 Oct 2020 15:20:38 +0200
Message-Id: <20201016132047.3068029-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series cleans up and massively simplifies the pstore-blk code,
please take a look.
