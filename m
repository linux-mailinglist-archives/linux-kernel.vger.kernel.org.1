Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF31C8129
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 06:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgEGEvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 00:51:17 -0400
Received: from verein.lst.de ([213.95.11.211]:44422 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgEGEvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 00:51:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46A7868B05; Thu,  7 May 2020 06:51:13 +0200 (CEST)
Date:   Thu, 7 May 2020 06:51:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russ Anderson <rja@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Mike Travis <mike.travis@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve Wahl <steve.wahl@hpe.com>
Subject: Re: x86/uv cleanups
Message-ID: <20200507045113.GA4396@lst.de>
References: <20200504171527.2845224-1-hch@lst.de> <20200505153944.GD2297@hpe.com> <87sggenfdr.fsf@nanos.tec.linutronix.de> <20200506213650.dva5xnq4oplxzn2o@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506213650.dva5xnq4oplxzn2o@hpe.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 04:36:50PM -0500, Russ Anderson wrote:
> In addition to Christoph's patches, we will soon be submitting
> additional clean up patches.  Mike Travis is working on a patch
> to remove old SGI UV1 code.  Dimitri Sivanich is working on a
> sgi_rtc cleanup patch.  We are looking at additional cleanup
> that should have been done previously.

If you plan to submit these very soon I'll happily defer this
cleanup series a bit and can resubmit it on top of your changes.
