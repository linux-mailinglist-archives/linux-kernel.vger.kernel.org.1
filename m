Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16561DBA08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 18:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgETQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 12:45:58 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40405 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726545AbgETQp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:45:57 -0400
Received: (qmail 13248 invoked by uid 1000); 20 May 2020 12:45:56 -0400
Date:   Wed, 20 May 2020 12:45:56 -0400
From:   "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To:     "Sverdlin, Alexander \(Nokia - DE/Ulm\)" 
        <alexander.sverdlin@nokia.com>
Cc:     "dinghao.liu@zju.edu.cn" <dinghao.liu@zju.edu.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>, "mpm@selenic.com" <mpm@selenic.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "rfontana@redhat.com" <rfontana@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH] hwrng: ks-sa - fix runtime pm imbalance on error
Message-ID: <20200520164556.GC11084@rowland.harvard.edu>
References: <20200520132957.18776-1-dinghao.liu@zju.edu.cn>
 <ab400cba7523e69b15360b0928cb8fa8b9432d86.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab400cba7523e69b15360b0928cb8fa8b9432d86.camel@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 03:42:17PM +0000, Sverdlin, Alexander (Nokia - DE/Ulm) wrote:
> Hello Dinghao,
> 
> On Wed, 2020-05-20 at 21:29 +0800, Dinghao Liu wrote:
> > pm_runtime_get_sync() increments the runtime PM usage counter even
> > the call returns an error code. Thus a pairing decrement is needed
> > on the error handling path to keep the counter balanced.
> 
> I believe, this is the wrong place for such kind of fix.
> pm_runtime_get_sync() has obviously a broken semantics with regards to
> your observation but no other driver does what you propose.

Look again.  For example, see what usb_autoresume_device() in 
drivers/usb/core/driver.c does.

You really shouldn't make generalizations such as "no other driver does 
..." unless you have read the code for every driver in the kernel.

Alan Stern
