Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E017B2E19F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgLWIae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:30:34 -0500
Received: from verein.lst.de ([213.95.11.211]:33782 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgLWIad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:30:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9E9CA67373; Wed, 23 Dec 2020 09:29:50 +0100 (CET)
Date:   Wed, 23 Dec 2020 09:29:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joe Perches <joe@perches.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, apw@canonical.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-doc <linux-doc@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] checkpatch: make the line length warnings match the
 coding style document
Message-ID: <20201223082950.GA7129@lst.de>
References: <20201210082251.2717564-1-hch@lst.de> <c3f1d9de2e5a61588f64e69a1309968d84a2dd12.camel@perches.com> <20201210200930.GB7338@casper.infradead.org> <4898c0c03d370a23b1b98ddabb72e70ec8d430fa.camel@perches.com> <93a470c7631d2607e7b2a12e9cc5d8e930911989.camel@perches.com> <20201222131234.GA29028@lst.de> <983e6452a7f2af14ca7edfa56cd2e2997172a771.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983e6452a7f2af14ca7edfa56cd2e2997172a771.camel@perches.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 08:22:06AM -0800, Joe Perches wrote:
> Having checkpatch complain about > 80 column lines didn't stop
> patches before, likely it wouldn't stop patches now.
> 
> Emitting yet more messages for trivial lines > 80 columns is also
> against the intent of the commit that changed the line length maximum.

It certainly helped.  Since that checkpatch change I waste a lot more
of my time on finding all this crap, and people are confused because
they only rely on checkpatch.  Other maintainers are similarly annoyed
or just silently fix things up.

Right now this is making things much worse.
