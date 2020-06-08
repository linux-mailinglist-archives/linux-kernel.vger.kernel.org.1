Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DC71F1329
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 09:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgFHHFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 03:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgFHHFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:05:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD07C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 00:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S378zGSpOf2f7Q1RRRkaUsWspkKGCnohH5tp/UAp9n0=; b=V56K/fI9pjhCqJKos2pXtAWzdJ
        IphlrsZzSU87eJoW4gUlDxlRMK8XKWdF6sWXg+ABe2d8azTKmXcwo3GsLbp9FC9nri4P7rNoQfK2b
        IHe4yDNGfXzdrzk45+HD73DnopkZDOcgi4mrLQY1pO7RZH5DUj/yPMTXKv+EvylhGDG27C1njPHqC
        z/ZJOu+NCVJl/u+gi+XqqeZYEVos53iiqpz2zEueMKYMSSLPowiJYMS6PYrgS5f467jzZLajCe5vk
        daoFPXBmmeck3KP+RwmUjtAP3gBckUQka4/SFJw6CYanCAUFcruaN0XJQlgaQTGlCkAeotzPRHQDa
        IsErvlQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiBqF-0002Ke-SQ; Mon, 08 Jun 2020 07:05:07 +0000
Date:   Mon, 8 Jun 2020 00:05:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com,
        roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 03/11] swiotlb-xen: add struct device* parameter to
 xen_phys_to_bus
Message-ID: <20200608070507.GB15742@infradead.org>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
 <20200603222247.11681-3-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603222247.11681-3-sstabellini@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 03:22:39PM -0700, Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> The parameter is unused in this patch.
> No functional changes.

This looks weird.  I'm pretty sure you are going to use it later, but
why not just add the argument when it actually is used?
