Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA01D2212
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 00:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEMWc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 18:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgEMWc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:32:28 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE455C061A0C;
        Wed, 13 May 2020 15:32:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 25C671218DDC4;
        Wed, 13 May 2020 15:32:27 -0700 (PDT)
Date:   Wed, 13 May 2020 15:32:26 -0700 (PDT)
Message-Id: <20200513.153226.1639916880914538869.davem@davemloft.net>
To:     will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, matt@codeblueprint.co.uk,
        sparclinux@vger.kernel.org, kernel-team@android.com
Subject: Re: [RESEND PATCH 0/4] Rework sparc32 page-table layout
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200414214011.2699-1-will@kernel.org>
References: <20200414214011.2699-1-will@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 13 May 2020 15:32:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>
Date: Tue, 14 Apr 2020 22:40:07 +0100

> This is a reposting of the patch series I sent previously to rework the
> sparc32 page-table layout so that 'pmd_t' can be used safely with
> READ_ONCE():
> 
> https://lore.kernel.org/lkml/20200324104005.11279-1-will@kernel.org
> 
> This is blocking the READ_ONCE() rework, which in turn allows us to
> bump the minimum GCC version for building the kernel up to 4.8.

Series applied to sparc-next, thanks Will.
