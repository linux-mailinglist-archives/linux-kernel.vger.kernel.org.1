Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4B31B2DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 19:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgDURC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 13:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDURCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:02:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C38C061A41;
        Tue, 21 Apr 2020 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wuF6glVROYbPM3r9lPyVTY3Ec0nGVm2GCfVQiXVfRVY=; b=MU2YBSolyc8RiAMCdBHGeC3uNQ
        qeGwbqtvVY+vbruuhfyMS/cq6/Liwo69PIxQcBbF7Nl+RMpyRr3fDePaF4pcFWY6Grjnn0mM2enUq
        Z2oaw3kysp3dVPRzx9uMRwxAZHvb0oewZ9JfX/03N8GHr2JtJeEZ/AZnyJTD7IbkCMaNoUypckhFC
        g4kKSLjan/BCiGdeVEy1UNYTYj9C46iWJH1/oVaLau/GJpEfEZewUhka8CfXw/u9XnyrR7ysVIHM1
        XEZ5Xlo+1j49Ltz7//xo2TxIqrVAhAXtEiKXEMkaCkBPIuvazpyUVFpyPM86VjAD+Tzq59ZCtDs86
        md+O3b2A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQwHv-0004SX-BR; Tue, 21 Apr 2020 17:02:23 +0000
Date:   Tue, 21 Apr 2020 10:02:23 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 08/29] docs: filesystems: convert configfs.txt to ReST
Message-ID: <20200421170223.GP5820@bombadil.infradead.org>
References: <cover.1587487612.git.mchehab+huawei@kernel.org>
 <278a9befc98b49ea866c9b687d070c70cde20628.1587487612.git.mchehab+huawei@kernel.org>
 <20200421165534.GA16511@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421165534.GA16511@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 06:55:34PM +0200, Christoph Hellwig wrote:
> NAK, this makes the document significantly harder to read.

Really?  It reads more easily to me in the new format.  Enclosing
section headers in [] is really weird.
