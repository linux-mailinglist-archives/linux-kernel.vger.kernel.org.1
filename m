Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981E91C199E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgEAPfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgEAPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:35:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CBBC061A0C;
        Fri,  1 May 2020 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OVGNTTsIXilZE/mIAgswxp17k1GWIaGH4stxbXUcyh0=; b=ufJ9ndREHi/ST+gjq87NpeNtn5
        hS2gK6+ZL7QtopBXMdN/oP1STPMHM+tKKg9AjO+f9xN3wxbSCMt7njj82dI8dzO8ynWmBT1XzCi1o
        M+Vj1cNeSxmCnhJDLFOM+ofphWPIGzD+4w9X0SkF6VZDulHJ5780tR2xMP7q7UavjKjM2qBd9KOYJ
        JmhxHlasPHIzLhYvrjluaVZZWDw0D5TNbkKn+3YKuje9vURfzftd6mc5lwiHCi8wC3G5LEM0ntVIg
        xxsfRXdsr1C53oK6K0XWK8CYrFKjlL/OrQs6gfiNEsFPAEzTtr1NKir7GUBhBv0Sn26b2COCyrUdJ
        qjcI9VfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUXhS-0006PB-Df; Fri, 01 May 2020 15:35:38 +0000
Date:   Fri, 1 May 2020 08:35:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] floppy: use print_hex_dump() in setup_DMA()
Message-ID: <20200501153538.GB12469@infradead.org>
References: <20200501134416.72248-1-efremov@linux.com>
 <20200501134416.72248-2-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501134416.72248-2-efremov@linux.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 04:44:13PM +0300, Denis Efremov wrote:
> Remove pr_cont() and use print_hex_dump() in setup_DMA() to print the
> contents of the cmd buffer.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
