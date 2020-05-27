Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8481E38AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 07:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgE0F63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 01:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0F62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:58:28 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997A7C061A0F;
        Tue, 26 May 2020 22:58:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 55CF8127E900C;
        Tue, 26 May 2020 22:58:27 -0700 (PDT)
Date:   Tue, 26 May 2020 22:58:24 -0700 (PDT)
Message-Id: <20200526.225824.2202331208378344398.davem@davemloft.net>
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, linux@roeck-us.net,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rppt@linux.ibm.com
Subject: Re: [PATCH] sparc32: register memory occupied by kernel as
 memblock.memory
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200527045219.GG48741@kernel.org>
References: <20200524165358.27188-1-rppt@kernel.org>
        <20200527045219.GG48741@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 May 2020 22:58:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 27 May 2020 07:52:19 +0300

> Andrew, David,
> 
> Any comments on this?

No objections from me:

Acked-by: David S. Miller <davem@davemloft.net>
