Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E831E926E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgE3P72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 11:59:28 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39239 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729029AbgE3P72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 11:59:28 -0400
Received: (qmail 30265 invoked by uid 1000); 30 May 2020 11:59:27 -0400
Date:   Sat, 30 May 2020 11:59:27 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH] usb: storage: alauda: fix possible buffer overflow
 casued by bad DMA value in alauda_read_map()
Message-ID: <20200530155927.GC29298@rowland.harvard.edu>
References: <20200530144230.3550-1-baijiaju@tsinghua.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530144230.3550-1-baijiaju@tsinghua.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 10:42:30PM +0800, Jia-Ju Bai wrote:
> From: Jia-Ju Bai <baijiaju1990@gmail.com>
> 
> The value us->iobuf is stored in DMA memory, and it is assigned to data,
> so data[6] and data[7] can be modified at anytime by malicious hardware.
> In this case, data[6] ^ data[7] can be a quite large number, which may 
> cause buffer overflow when the code "parity[data[6] ^ data[7]]" is
> executed.
> 
> To fix this possible bug, data[6] ^ data[7] is assigned to a local
> variable, and then this variable is checked before being used.

There are much worse problems than this in the alauda driver.  For 
example, alauda_get_redu_data() does I/O from a data buffer on the 
stack; this is not allowed.  That's just the example I noticed; there 
may very well be others.

If you want to fix something, fix that.

If you're still worried about malicious hardware, the way to fix the 
problem is not to change this one location.  Instead, you should modify 
the driver so that us->iobuf is not stored in DMA memory.

Alan Stern
