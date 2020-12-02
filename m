Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08E02CCA67
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgLBXQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgLBXQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:16:38 -0500
Date:   Wed, 2 Dec 2020 15:15:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606950957;
        bh=GIxDqD7uyqfqU0/Yhag9Aqk11nRK5ZDPMst72hACnKs=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=oMYRn4E54/4EJ2VENB7SaShDI/g86o6N/JdhUoTDOC5VmHLSl4punLBvaX5v7Euf9
         9hGlahpHiYLijD46ROM026BV78121kP/7FN//sdG5r7agDQPf0a7aDgRq5lfOva2yA
         2jCVgxmEf0igttv5F9MDtQMS8PwsLuwGfytOqjSI=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <qcai@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swapfile: Do not sleep with a spin lock held
Message-Id: <20201202151556.01077710acf79f6fd2ba8287@linux-foundation.org>
In-Reply-To: <20201202151549.10350-1-qcai@redhat.com>
References: <20201202151549.10350-1-qcai@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Dec 2020 10:15:49 -0500 Qian Cai <qcai@redhat.com> wrote:

> We can't call kvfree() with a spin lock held, so defer it.
> 

Fixes: 873d7bcfd066 ("mm/swapfile.c: use kvzalloc for swap_info_struct allocatio
n")

Do you think it's worth a cc:stable?  IOW, is this known to ever
produce a warning?

(If not, why did we need 873d7bcfd066??)
