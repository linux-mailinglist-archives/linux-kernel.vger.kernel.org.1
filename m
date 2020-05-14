Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755C61D34BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgENPOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 11:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgENPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:14:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4E7C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uSUydUvO5de16QbUQV/j8lXZOq2OQ7UGLXiWZJlBoBY=; b=GGEf+AZkYpqjLYConVlocDzcCG
        AYmCaUtORs64iLf59ZyBlOFcU5w5CfwSaDpvpq5fQK4iXHRrSV1HHqBMPsPClwoNNtSReObuPEbaM
        zvb9jvfFFr4q9K13X9Ay6rOomqz/SPhUrsIyHQjGXUCH7PXY2uqkjXxucDXoHhc+se3qRXvrD9k4q
        JrH3/g46azjvxCRvYld1s3DOgEM093IiucOXxPOUbBTJGyPRuk3T0pO7I0qS3yCu897dTbuG/XyBB
        eG40gXfYs+ckYbWaauhG83nH3Ry76t1oMwSVftINOdk0ceKebuROn1W8BTijky8IFto4WvPUN6b1Q
        yJKots0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZFYd-0000MF-Vm; Thu, 14 May 2020 15:13:59 +0000
Date:   Thu, 14 May 2020 08:13:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] lightnvm: Replace zero-length array with flexible-array
Message-ID: <20200514151359.GA1145@infradead.org>
References: <20200507190452.GA15449@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507190452.GA15449@embeddedor>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvme.h has nothing to do with lightnvm.  I'll merge this with the next
one into a single nvme zero-length array patch.
