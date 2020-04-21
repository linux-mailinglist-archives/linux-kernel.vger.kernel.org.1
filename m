Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3CD1B2E39
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgDURXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 13:23:41 -0400
Received: from verein.lst.de ([213.95.11.211]:47982 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDURXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:23:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C37F468C4E; Tue, 21 Apr 2020 19:23:37 +0200 (CEST)
Date:   Tue, 21 Apr 2020 19:23:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 08/29] docs: filesystems: convert configfs.txt to
 ReST
Message-ID: <20200421172337.GA18305@lst.de>
References: <cover.1587487612.git.mchehab+huawei@kernel.org> <278a9befc98b49ea866c9b687d070c70cde20628.1587487612.git.mchehab+huawei@kernel.org> <20200421165534.GA16511@lst.de> <20200421170223.GP5820@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421170223.GP5820@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 10:02:23AM -0700, Matthew Wilcox wrote:
> On Tue, Apr 21, 2020 at 06:55:34PM +0200, Christoph Hellwig wrote:
> > NAK, this makes the document significantly harder to read.
> 
> Really?  It reads more easily to me in the new format.  Enclosing
> section headers in [] is really weird.

It wasn't entirely uncommon, but that's not really the point.  The
Problem is all the weird ".." or "::" annotations that really kill
the flow, or things like "|copy|" that have no reason to exist.
