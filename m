Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FB62CA603
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391549AbgLAOoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:44:04 -0500
Received: from verein.lst.de ([213.95.11.211]:50131 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387963AbgLAOoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:44:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4CA9968AFE; Tue,  1 Dec 2020 15:43:16 +0100 (CET)
Date:   Tue, 1 Dec 2020 15:43:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/3] LICENSES: Add the CC-BY-4.0 license
Message-ID: <20201201144314.GA14256@lst.de>
References: <cover.1606137108.git.linux@leemhuis.info> <c07e51e153f453c83c77a75513ad3d5ec70ef1be.1606137108.git.linux@leemhuis.info> <20201124091852.GB11695@lst.de> <04eae024-811d-d11e-b8bd-52f0dd0e225f@leemhuis.info> <20201124093658.GA13174@lst.de> <e424e24f-08d3-0b83-3d5b-ac500c753792@leemhuis.info> <20201124121109.GY4327@casper.infradead.org> <20201130075137.3b551bef@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130075137.3b551bef@lwn.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 07:51:37AM -0700, Jonathan Corbet wrote:
> We could also, if we saw fit, take the position that anything that has
> been processed through the docs build is a derived product of the kernel
> and must be GPL-licensed - any dual-licensing would be stripped by that
> act.  That, too, should address this concern, I think.
> 
> In general I'd rather see fewer licenses in Documentation/ than more.  But
> Thorsten has put a lot of effort into this work; if he wants to
> dual-license it in this way, my inclination is to accommodate him.  But
> that requires getting CC-BY-4.0 accepted into the LICENSES directory.
> (That said, I believe it should go into LICENSES/dual/ rather than
> preferred/).

I agree with everything said above.
