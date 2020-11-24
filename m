Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EE72C256C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbgKXMLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgKXMLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:11:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C5FC0613D6;
        Tue, 24 Nov 2020 04:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0snAvb5DOf+oPMchsCEyUIU/3RDtclpkTrApuWx5x1w=; b=cM01k4eKrSZ1mFMoilnZWF+zm3
        AvkPQ8IXi5lb0AqfaKPACXJH5QGsEUDKUlx9rQqMare2QscEbYFINvjV3RstjDHldXXZ8X+a33e04
        8VB/uB0teuTiN/iDL1jAgnn9dhOdbi9clxK+cA973oz7OGYADzkC4zqVMk9PbogOnJ1cEMnmAKZ58
        6QKTd5+nWr4diAEMBEC8yTzsmYuBVwAmrYhriaVUmX9/3eh6QBIeHSVFhQ0OHDLDcKOA5ZMWVqxoJ
        G6N5RxYVI1O4iIzvM9h6IxGrIVEDW2LopW5W8kbTUNzkcKAvDW/q505V8tSrogaYT59/VFaJEzKEg
        X14JMrSg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khXA5-0001k0-Qp; Tue, 24 Nov 2020 12:11:10 +0000
Date:   Tue, 24 Nov 2020 12:11:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/3] LICENSES: Add the CC-BY-4.0 license
Message-ID: <20201124121109.GY4327@casper.infradead.org>
References: <cover.1606137108.git.linux@leemhuis.info>
 <c07e51e153f453c83c77a75513ad3d5ec70ef1be.1606137108.git.linux@leemhuis.info>
 <20201124091852.GB11695@lst.de>
 <04eae024-811d-d11e-b8bd-52f0dd0e225f@leemhuis.info>
 <20201124093658.GA13174@lst.de>
 <e424e24f-08d3-0b83-3d5b-ac500c753792@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e424e24f-08d3-0b83-3d5b-ac500c753792@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:07:41AM +0100, Thorsten Leemhuis wrote:
> There is nothing special with this text, it's just that GPL is known to not
> be really ideal for documentation. That makes it hard for people to reuse
> parts of the docs outside of the kernel context, say in books or on
> websites. But it IMHO would be good for us if others could simply use this
> text as a base in such places. Otherwise they'd often face a situation where
> they had to write something completely new themselves, which afsics often
> leads to texts that can be incomplete, inaccurate or actually missleading.
> That can lead to bad bug reports, which is annoying both for reporters and
> kernel developers.
> 
> That's why I came up with the thought "make the text available under more
> liberal license in addition to the GPLv2 is a good idea here". I considered
> MIT, but from what I see CC-BY 4.0 is a way better choice for documentation
> that is more known to authors.
> 
> And I hope others pick up the idea when they write new documentation for the
> kernel, so maybe sooner or later it's not unusual anymore.

It's really tricky to make this work when, eg, including kernel-doc from
files which are unambiguously licensed under the GPL.  I'd be happy to
sign up to licensing the files I control under GPL-with-CC-BY-SA-exception
that said something like "any documentation extracted from this file may
be distributed under the BY-SA license", but I'm not sure everybody would.
