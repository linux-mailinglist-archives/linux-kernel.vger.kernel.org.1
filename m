Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E57203DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 19:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgFVRWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 13:22:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:38674 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbgFVRWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:22:10 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 202052C8;
        Mon, 22 Jun 2020 17:22:10 +0000 (UTC)
Date:   Mon, 22 Jun 2020 11:22:09 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] docs: f2fs: fix a broken table
Message-ID: <20200622112209.71990f9c@lwn.net>
In-Reply-To: <20200622171106.GA192855@gmail.com>
References: <20200622073907.7608a73a@lwn.net>
        <20200622171106.GA192855@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 10:11:06 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> Someone already sent out a fix for this:
> https://lkml.kernel.org/linux-doc/52f851cb5c9fd2ecae97deec7e168e66b8c295c3.1591137229.git.mchehab+huawei@kernel.org/
> 
> Is it intentional that you're sending out a different fix rather than applying
> that one?

It wasn't, actually, I'm just finding myself more than usually challenged
these days.

That said, removing the table entirely seems ... excessive.  It's not
terrible the way it is, or we could make it:

	test_dummy_encryption[=%s]

if we really want to.

jon
