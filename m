Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCEB2C21A7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbgKXJhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731448AbgKXJha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:37:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B099AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F27KcdxnSBH0rGkXOypmCAQ/Zpct2KlOr6/o6Q2kSLo=; b=lsjV8Tp4SDXOFa8bbktFq1L3jN
        yCemMkWUAEPjQSpEEdgMLHu/FwEx5cy5hiEdkXLR5oXEknqtUDiyWn7ydZtf2Jl7xFA1NFFoSA1+A
        etWfdHLzedI4qb6f8xkrJuW3vu+oFt5AQy9QJsmqEq55RXOLokR0Y5M1RHIAt6nUL7tYtUWlbSNBA
        ZP7PVidU1UawcRdNyssG2sLqI6AvQw4UKQh60EWsx7E7xOC9BSmcU+b57rqN5YdyjQiNntIzSVOMM
        Bro97cfkJlje3I1Pa+RKkDU/KsFMWriw52+JxQiRdEoR0pFOj53GbXFfD12yjXVbPDWWEYnw56Dtu
        4/pH4fgA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUlN-0008Pf-0e; Tue, 24 Nov 2020 09:37:29 +0000
Date:   Tue, 24 Nov 2020 09:37:28 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/9] relay: require non-NULL callbacks in relay_open()
Message-ID: <20201124093728.GB31963@infradead.org>
References: <cover.1606153547.git.jani.nikula@intel.com>
 <e40642f3b027d2bb6bc851ddb60e0a61ea51f5f8.1606153547.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e40642f3b027d2bb6bc851ddb60e0a61ea51f5f8.1606153547.git.jani.nikula@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 07:59:22PM +0200, Jani Nikula wrote:
> There are no clients passing NULL callbacks, which makes sense as it
> wouldn't even create a file. Require non-NULL callbacks, and throw away
> the handling for NULL callbacks.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
