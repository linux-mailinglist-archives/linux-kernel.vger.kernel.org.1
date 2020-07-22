Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F4D228D84
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 03:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbgGVBWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 21:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgGVBWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:22:48 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD226C061794;
        Tue, 21 Jul 2020 18:22:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A121711DB315F;
        Tue, 21 Jul 2020 18:06:03 -0700 (PDT)
Date:   Tue, 21 Jul 2020 18:22:48 -0700 (PDT)
Message-Id: <20200721.182248.277146641003054082.davem@davemloft.net>
To:     rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] SPARC: backoff.h: delete a duplicated word
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200721210033.15408-1-rdunlap@infradead.org>
References: <20200721210033.15408-1-rdunlap@infradead.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jul 2020 18:06:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 21 Jul 2020 14:00:33 -0700

> Drop the repeated word "other".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks Randy.

> @David:
> In arch/sparc/include/asm/cpu_type.h, line 12,
> is that duplicated "ploos" correct?
>   sun4u       = 0x03, /* V8 ploos ploos */

Yes, it's a funny way of saying "++" :-)
