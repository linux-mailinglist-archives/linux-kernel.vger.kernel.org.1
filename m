Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8922D23D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 01:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGXXh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 19:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgGXXhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:37:25 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4648C0619D3;
        Fri, 24 Jul 2020 16:37:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 083CE12753F96;
        Fri, 24 Jul 2020 16:20:37 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:37:19 -0700 (PDT)
Message-Id: <20200724.163719.765874169250237597.davem@davemloft.net>
To:     nivedita@alum.mit.edu
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-sh@vger.kernel.org,
        ysato@users.sourceforge.jp, dalias@libc.org,
        sparclinux@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sparc: Drop unused MAX_PHYSADDR_BITS
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200723231544.17274-4-nivedita@alum.mit.edu>
References: <20200723231544.17274-1-nivedita@alum.mit.edu>
        <20200723231544.17274-4-nivedita@alum.mit.edu>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 24 Jul 2020 16:20:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Thu, 23 Jul 2020 19:15:44 -0400

> The macro is not used anywhere, so remove the definition.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Acked-by: David S. Miller <davem@davemloft.net>
