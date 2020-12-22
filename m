Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB882E0B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgLVOXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgLVOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:23:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F4C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hYnCL/Z0LMH7jTIypqvf/4LgCsg5+aYOBvlIsw/Dfzw=; b=bTEPE34SwYAvu29kn68FrqY2Z9
        3bL5mRxgSbYTbn2ehqbWCaCkz8xpwvyemI7mAp9vkYjTlQKdUVZWt3dLxJux15wGFqaSw5Puqkry+
        Aacl9zQjB/ijChJnjG4qlOMfPXaz6O3EPABOPzWAHwGUMZtCqJgZ8JTdeOQL3XyVJ0lUywAA5FP56
        vmCOzy05UHogeP6c28ICR1s6V80oGPmLh7g4d2rEAfEjVqiZyvSPLoxJDYwEoaGXrFXNrgtZk+nnO
        ThMoPmsIDGWzNCWhI9HdZdiwOovBhX2/B65VWgyRufCAhTIPpOmxJfTb2JjNniuSFSZyvh9gT/mc/
        mkRC4lUg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kriYc-0004qi-8T; Tue, 22 Dec 2020 14:22:34 +0000
Date:   Tue, 22 Dec 2020 14:22:34 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, guoweichao@oppo.com,
        zhangshiming@oppo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: support direct IO for uncompressed file
Message-ID: <20201222142234.GB17056@infradead.org>
References: <20201214140428.44944-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214140428.44944-1-huangjianan@oppo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not add new callers of __blockdev_direct_IO and use the modern
iomap variant instead.
