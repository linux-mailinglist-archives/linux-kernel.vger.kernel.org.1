Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072CA1A1BD4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 08:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgDHGPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 02:15:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDHGPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 02:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NFKXv7QsXR7iUPXlkUIYwrc537WG8/WzEf7Z9zVWV9k=; b=WKF4y97u3LTKHRZq0DGkRn/4Kf
        muiDgpvEnxcQfnnHzcq9p5lLS/amGd9J/2jjjFDN/IYC0PRfbyzsiYIsdtygsbI/18gl/fXlO270K
        EwCss3rDBRMvhoRI+ZiB/1lk7zyFJsFAdGAaygcZsz3p6S/blHYFFwYoFQYYOpzChplWRZ5E6QYWq
        i7J9kpPvLq8LEJyuL1W9b3dyjY+1Et59BMCiZzjjsdHuuHa8+XCtoIslIovyk0Le80ANK7SYBUaGe
        lOx2/UK2q9Mjd2mk58tLnZlM5LaV6ZC5+oCKX5cHQfL2MtE16wgjBx+q52vz31Vriun1/uVyk6Gon
        FDRomUIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM404-00059U-3A; Wed, 08 Apr 2020 06:15:48 +0000
Date:   Tue, 7 Apr 2020 23:15:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mbus: export mvebu_mbus_{add,del}_window for modules
Message-ID: <20200408061548.GA19756@infradead.org>
References: <20200324190623.26482-1-vadym.kochan@plvision.eu>
 <20200325135801.GA29951@infradead.org>
 <20200407151219.GB25149@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407151219.GB25149@plvision.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 06:12:19PM +0300, Vadym Kochan wrote:
> Hi Christoph,
> 
> On Wed, Mar 25, 2020 at 06:58:01AM -0700, Christoph Hellwig wrote:
> > On Tue, Mar 24, 2020 at 09:06:23PM +0200, Vadym Kochan wrote:
> > > Allow to add/del remap window by external modules at runtime.
> > 
> > Please send this together with your driver submission.
> 
> The driver itself is just servicing user process to configure io
> windows via ioctl, so I think it is not so useful ?

If you want the export in mainline your driver needs to be as well.
