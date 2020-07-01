Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEBE21038F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 08:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgGAGCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 02:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGAGCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:02:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099B9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=z/5jzLBz20jnzhUIycgs8W4kE7bIlfmulK4CDoiMea0=; b=Rdh7FmdD7Y15rSg6dodOBEuFvv
        FfObPJjtVR7g0quEVZqpBga6kvHgT8ns7wJifQypLocVy7KSl00DlJJ6Apfxz69d8ttQ/Hp/Aiu3+
        UkSFJciGJiNv2qxGcYF3l4JYm1YXvzM7bUoFpcUJ9IMbVFvCBuwAcHJfFEYoNHKIJYdbVc+38pS+b
        4cG2uouMlr7EDLp8q8uc+dAY0MrU4lJ9oMvhSQ/p0gZ7oWosf1GV8rus92lqxBVePTd6tNorQ6313
        kKpRCcT5Zo4hjWhxnHeZNL6n04KPo7poo1Z1PfBsLla6oBIiC8bxwWHWbvgXK/YFNyYksXd1rZpzh
        51xIZH/g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqVpP-00079L-TY; Wed, 01 Jul 2020 06:02:40 +0000
Date:   Wed, 1 Jul 2020 07:02:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     willy@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: alternative to xa_for_each?
Message-ID: <20200701060239.GA27121@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

I'm just reviewing a patch adding an xarray user, and I'm wondering
if we could just replace xa_for_each with a loop on
xa_find_after with a magic index to start from the beginning?  That
would always seem like more readable code than the magic looping macro.

And while we're at it:  is there an idiomatic way to get the entry with
the highest index?
