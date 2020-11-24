Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E76A2C2CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390194AbgKXQS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:18:56 -0500
Received: from verein.lst.de ([213.95.11.211]:55127 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389760AbgKXQSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:18:55 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 256566736F; Tue, 24 Nov 2020 17:18:52 +0100 (CET)
Date:   Tue, 24 Nov 2020 17:18:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [EXT] Re: [PATCH v1 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <20201124161851.GA10535@lst.de>
References: <20201112062422.32212-1-bbudiredla@marvell.com> <20201112062422.32212-2-bbudiredla@marvell.com> <CAPDyKFqZij1_aZZs3EeEuNob37WsGYN+6N52H2N0nTzM427j3g@mail.gmail.com> <CY4PR1801MB20705DF5A12318AB80EDBD45DEFC0@CY4PR1801MB2070.namprd18.prod.outlook.com> <CAPDyKFqBWEdAzz0hjk7LhqX1D8qmOomHSS=Be+_vU=upxMr0aA@mail.gmail.com> <CY4PR1801MB2070549B13D3ADD324F4E8EBDEFB0@CY4PR1801MB2070.namprd18.prod.outlook.com> <CAPDyKFqZomrJDgjKWvxeOornENnZFXSX+NWTWEerNHf=zf1L8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqZomrJDgjKWvxeOornENnZFXSX+NWTWEerNHf=zf1L8g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 03:40:21PM +0100, Ulf Hansson wrote:
> It looks like Christoph is planning for some rewrite of the pstore
> code, so let's see what that means in regards to this.

Here is what I posted last month:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/pstore

Kees wanted to chime in with a few thing he'd like to see done
differently, but I've not seen the actual comments yet.

In respect to the eMMC support what I've done should mostly
just work, it would have to adopt to the slightly different
registration interface and just call register_pstore_device() with
its own ops.
