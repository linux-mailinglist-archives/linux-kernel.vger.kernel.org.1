Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF220006B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 04:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgFSCuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 22:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgFSCuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 22:50:51 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B22C06174E;
        Thu, 18 Jun 2020 19:50:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7EEF1120ED49C;
        Thu, 18 Jun 2020 19:50:50 -0700 (PDT)
Date:   Thu, 18 Jun 2020 19:50:49 -0700 (PDT)
Message-Id: <20200618.195049.463745788487710498.davem@davemloft.net>
To:     andriy.shevchenko@linux.intel.com
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/6] serial: sunsab: Return proper error code from
 console ->setup() hook
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200618164751.56828-3-andriy.shevchenko@linux.intel.com>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
        <20200618164751.56828-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Jun 2020 19:50:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 18 Jun 2020 19:47:47 +0300

> For unifying console ->setup() handling, which is pure documented,
> return error code, rather than non-zero arbitrary number.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>

Acked-by: David S. Miller <davem@davemloft.net>
