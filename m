Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545102C21EE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgKXJmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731441AbgKXJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:42:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5D9C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bI7f5L4ivOyoNdbffR7TGYj8zn0YNouWgt/4RCHP95w=; b=he7BtK6qmesescQEgnUa6+tJTy
        3Jo0kkKmmka6+3OhOPxkMmD7+wWGML/d7jgZGVu2E+KXp72eoZNY4OgjCIIeJKzegxkdeCPtf5PYO
        CNXUgVDhpBoi3HtPO1i6q5ObFXTyQgOPiEogpMJFgsSYFV1whTT45jChi7AHmy5skeo9DKEZQBJxr
        Qg0McgxMGu9Vg2wlpzFPLdBfFLQw8/ewIBZT5JbN3DWLp4c3oIrsh/WdfOl8T4N5VpOVeBYzrmTAl
        4FZVcpwvL3E+MRxtnnTh0b8x6WgBaepwKAn2OKVkkOVRm+yQPg2/yQABbz7OlC/VbqLi/E7lj5cA8
        vgoroNSQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUq3-0000Ot-Ky; Tue, 24 Nov 2020 09:42:19 +0000
Date:   Tue, 24 Nov 2020 09:42:19 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 5/9] drm/i915: make relay callbacks const
Message-ID: <20201124094219.GE31963@infradead.org>
References: <cover.1606153547.git.jani.nikula@intel.com>
 <534d089f413db98aa0b94773fa49d5275d0d3c25.1606153547.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534d089f413db98aa0b94773fa49d5275d0d3c25.1606153547.git.jani.nikula@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 07:59:25PM +0200, Jani Nikula wrote:
> Now that relay_open() accepts const callbacks, make relay callbacks
> const.
> 
> Cc: intel-gfx@lists.freedesktop.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
