Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF5299286
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786053AbgJZQdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1769261AbgJZQdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:33:44 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88475205ED;
        Mon, 26 Oct 2020 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603730024;
        bh=8GdsQ1cqSd6XhTLYGpY5vpGIacqJGm+d1RwIZ/tb7CM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0FAUesa8qGxB+xNUNAHBMu49b9iwf9TspZPRxE3fYe/BfJhnhDL20txU0wtbPTfyf
         BUXWtCSy8zyobxfM8EKDh0UndQrNFYlz+wnyw5DQ7D9JM0ZiyGbyA3dhMWujWge9jP
         hvE/gk35VU0V525EYGs7aBEof1DoWhse7ujirrCQ=
Date:   Mon, 26 Oct 2020 09:33:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: fix the RNDRESEEDCRNG ioctl
Message-ID: <20201026163343.GA858@sol.localdomain>
References: <20200916041908.66649-1-ebiggers@kernel.org>
 <20201007035021.GB912@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007035021.GB912@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 08:50:21PM -0700, Eric Biggers wrote:
> On Tue, Sep 15, 2020 at 09:19:08PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > The RNDRESEEDCRNG ioctl reseeds the primary_crng from itself, which
> > doesn't make sense.  Reseed it from the input_pool instead.
> > 
> > Fixes: d848e5f8e1eb ("random: add new ioctl RNDRESEEDCRNG")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Ping?

Ping.
