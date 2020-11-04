Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35BA2A70B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbgKDWkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:40:32 -0500
Received: from ms.lwn.net ([45.79.88.28]:52412 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbgKDWkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:40:32 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B8AA22E7;
        Wed,  4 Nov 2020 22:40:31 +0000 (UTC)
Date:   Wed, 4 Nov 2020 15:40:30 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [GIT PULL] Docs-build warning fixes for 5.10-rc3
Message-ID: <20201104154030.5d107c6c@lwn.net>
In-Reply-To: <20201105090652.003eb7bf@canb.auug.org.au>
References: <20201103124420.46bf5a37@lwn.net>
        <CAHk-=wghhw0SpqSKKUqt5eum=UfLD3Qa0suoRxLy_cJc4hChug@mail.gmail.com>
        <20201105090652.003eb7bf@canb.auug.org.au>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 09:06:52 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> There is currently one message produced in your tree (after I add all
> the "pending fixes") and I have reported that this morning.  So things
> are looking pretty good now - a lot of good work over the past couple
> of releases.

The credit for that really belongs to Mauro.  Much appreciated!

jon
