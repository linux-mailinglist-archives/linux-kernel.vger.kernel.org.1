Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A891F3DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 16:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgFIOOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 10:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:14:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CB0C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hg1Lfd4Kx8X1h3BtTaJ9ebs71zPURRNqZuau5w7IU5c=; b=XADt3n2o/MZMTKZ527HpfSMOCS
        bn1tOy5BkDBmJ1/aSEYcnMENZesPwANkFVKsLUI+5+C8i0pL/XqjPqALVFrnbqgRuT+vvxrQyodZS
        knVnHtM+xXUdGSRPzP0VrjegxzmVfg5n2e/1meL0fzwCViCupU5L6eSELKGz7LlqbSXQbIJMkRx+l
        JIT1XJU2J3Q7AYPWKxG+4OmpeAqSZ9gFPxVKx6T7bToaLFlaHyeXSqUUEhhOFPeAslxkLcrMKRV76
        dvh2SslA3nUrkU0Lz6+g888OMIDqRPjQQpaKF25BVxAhjQq2BlOBkAlHCkut9poo8Pbaca63J1Ifr
        qAcHoCvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jif1f-0008AK-Do; Tue, 09 Jun 2020 14:14:51 +0000
Date:   Tue, 9 Jun 2020 07:14:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme-fc: Only call nvme_cleanup_cmd() for normal
 operations
Message-ID: <20200609141451.GA30656@infradead.org>
References: <20200529113740.31269-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529113740.31269-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to nvme-5.8 with some edits to the commit message.
