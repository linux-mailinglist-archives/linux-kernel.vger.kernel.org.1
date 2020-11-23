Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC1B2C0E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbgKWOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:53:35 -0500
Received: from verein.lst.de ([213.95.11.211]:50828 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbgKWOxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:53:34 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D9E696736F; Mon, 23 Nov 2020 15:53:31 +0100 (CET)
Date:   Mon, 23 Nov 2020 15:53:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: simplify pstore-blk
Message-ID: <20201123145331.GA778@lst.de>
References: <20201016132047.3068029-1-hch@lst.de> <202010161553.F2BA6CF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010161553.F2BA6CF@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:54:25PM -0700, Kees Cook wrote:
> On Fri, Oct 16, 2020 at 03:20:38PM +0200, Christoph Hellwig wrote:
> > this series cleans up and massively simplifies the pstore-blk code,
> > please take a look.
> 
> Cool! Thanks for doing this work. I have a few things I'd like to see
> done differently, and while I'm not a huge fan of the general reduction
> in utility, I can live with it as long as it doesn't make other things
> worse. :) I'll get this reviewed with specific feedback soon, but I'm
> about to be EOW. ;)

Any progress on this in the last five weeks?
