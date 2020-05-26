Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDB01E275A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 18:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbgEZQov convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 May 2020 12:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgEZQov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:44:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E931CC03E96E;
        Tue, 26 May 2020 09:44:50 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdcgc-0006hh-2Z; Tue, 26 May 2020 18:44:18 +0200
Date:   Tue, 26 May 2020 18:44:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     wang.yi59@zte.com.cn, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        jiang.xuexin@zte.com.cn, wang.yong12@zte.com.cn,
        linux-rt-users@vger.kernel.org
Subject: Re: [RT PATCH] Fixed: line break of pr_cont not take effect
Message-ID: <20200526164418.oqdbs3a7zdpb4ynq@linutronix.de>
References: <202005231419598080913@zte.com.cn>
 <87imgnndbc.fsf_-_@vostro.fn.ogness.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87imgnndbc.fsf_-_@vostro.fn.ogness.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-23 12:41:27 [+0200], John Ogness wrote:
> > Signed-off-by: 汪勇10269566 <wang.yong12@zte.com.cn>
> 
> Acked-by: John Ogness <john.ogness@linutronix.de>
> 
> @Sebastian: The original patch submission is here[0].

I reworded it and applied it. Thanks everyone.
汪勇, I suggest to mail patches as root in future.

> Thanks,
> John Ogness

Sebastian
