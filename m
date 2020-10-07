Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41528610D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgJGOSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:18:16 -0400
Received: from verein.lst.de ([213.95.11.211]:37520 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGOSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:18:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C94C76736F; Wed,  7 Oct 2020 16:18:12 +0200 (CEST)
Date:   Wed, 7 Oct 2020 16:18:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: atomisp: stop compiling compat_ioctl32 code
Message-ID: <20201007141812.GA1578@lst.de>
References: <20201007141702.655724-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007141702.655724-1-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 04:16:39PM +0200, Arnd Bergmann wrote:
> Alternatively, the entire file could just be removed, since anyone
> willing to restore the functionality can equally well just look up
> the contents in the git history if needed.

I suspect that is the right thing.  Note that given that the driver
is only in staging anyway, the right thing to do would be to change
the ioctl ABI to be more compat friendly to start with.
