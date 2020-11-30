Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFACB2C8723
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgK3OwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgK3OwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:52:19 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B884EC0613D2;
        Mon, 30 Nov 2020 06:51:39 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5DC2A2BA;
        Mon, 30 Nov 2020 14:51:38 +0000 (UTC)
Date:   Mon, 30 Nov 2020 07:51:37 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/3] LICENSES: Add the CC-BY-4.0 license
Message-ID: <20201130075137.3b551bef@lwn.net>
In-Reply-To: <20201124121109.GY4327@casper.infradead.org>
References: <cover.1606137108.git.linux@leemhuis.info>
        <c07e51e153f453c83c77a75513ad3d5ec70ef1be.1606137108.git.linux@leemhuis.info>
        <20201124091852.GB11695@lst.de>
        <04eae024-811d-d11e-b8bd-52f0dd0e225f@leemhuis.info>
        <20201124093658.GA13174@lst.de>
        <e424e24f-08d3-0b83-3d5b-ac500c753792@leemhuis.info>
        <20201124121109.GY4327@casper.infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 12:11:09 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> > That's why I came up with the thought "make the text available under more
> > liberal license in addition to the GPLv2 is a good idea here". I considered
> > MIT, but from what I see CC-BY 4.0 is a way better choice for documentation
> > that is more known to authors.
> > 
> > And I hope others pick up the idea when they write new documentation for the
> > kernel, so maybe sooner or later it's not unusual anymore.  
> 
> It's really tricky to make this work when, eg, including kernel-doc from
> files which are unambiguously licensed under the GPL. 

As Thorsten points out, there are no such directives in this particular
document.  I don't really see how any such could come to be introduced; we
could add a comment at the top saying that none should be added if that
would help.

We could also, if we saw fit, take the position that anything that has
been processed through the docs build is a derived product of the kernel
and must be GPL-licensed - any dual-licensing would be stripped by that
act.  That, too, should address this concern, I think.

In general I'd rather see fewer licenses in Documentation/ than more.  But
Thorsten has put a lot of effort into this work; if he wants to
dual-license it in this way, my inclination is to accommodate him.  But
that requires getting CC-BY-4.0 accepted into the LICENSES directory.
(That said, I believe it should go into LICENSES/dual/ rather than
preferred/).

Thanks,

jon
