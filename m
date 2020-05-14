Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A6E1D2750
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 08:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgENGOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 02:14:21 -0400
Received: from verein.lst.de ([213.95.11.211]:50138 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENGOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:14:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 65CF468BEB; Thu, 14 May 2020 08:14:17 +0200 (CEST)
Date:   Thu, 14 May 2020 08:14:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Christoph Hellwig <hch@lst.de>,
        x86@kernel.org
Subject: Re: WARNING in memtype_reserve
Message-ID: <20200514061417.GA8367@lst.de>
References: <000000000000f0d8d205a531f1a3@google.com> <20200509074507.GC1831917@kroah.com> <87wo5l4ecm.fsf@nanos.tec.linutronix.de> <20200513124445.GA1082735@kroah.com> <87zhab249p.fsf@nanos.tec.linutronix.de> <20200514035458.14760-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514035458.14760-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guys, can you please start formal thread on this?  I have no
idea where this came from and what the rationale is.  Btw, if the
pfn is crap in dma_direct_mmap then the dma_addr_t passed in is
crap, as it is derived from that.  What is the caller, and how is
this triggered?
