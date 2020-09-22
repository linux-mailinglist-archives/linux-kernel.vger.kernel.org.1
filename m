Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB8274361
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIVNjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgIVNjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:39:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188D3C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3fapcNZDDQCDTarDLFybEby3a2yP8Xsc7hwi+J7BjGo=; b=GOHkLH/QPzG9HT44Tmu4+WTTC8
        ncmeKz/m+IDMtDSU1fBVvHxFql/Yh4FJhzL7Qla/WPqFkhqXiuQAbOq0EC6kbcfsbOZT4wbdSkqXf
        BxcqciK0kk5zcCE5lbilxa02+QCq25Rcad3J/Myl0t/WfpbovJXhhKIvfRKmVY3O+FFklbdKKVbYn
        dD9FZHi0Wsn6rOr3SL4eeEeDB4U68ebR6F1xahWepC/sWv4TTojAIh1ZIjzxMiTrtDM8XRQjMgMvV
        ytigKXUg2NGaS0kGyRgahYXEQxcwWeYZ3+g0ViTG5M5PZOlQ1aB9qmU1XqS0xbMYo7Ih/la7ii0C8
        V5lcEYRw==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKiW8-0005Lv-JP; Tue, 22 Sep 2020 13:39:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org
Subject: a few trivial dma-mapping header cleanups
Date:   Tue, 22 Sep 2020 15:39:59 +0200
Message-Id: <20200922134002.1227279-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

these three patches clean up dma-mapping.h a little bit
