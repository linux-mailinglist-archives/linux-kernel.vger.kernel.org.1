Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C821B2BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgDUP5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 11:57:09 -0400
Received: from gentwo.org ([3.19.106.255]:35046 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUP5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:57:08 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id B3BD640B07; Tue, 21 Apr 2020 15:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id B2F9A3EED6;
        Tue, 21 Apr 2020 15:57:07 +0000 (UTC)
Date:   Tue, 21 Apr 2020 15:57:07 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     =?GB2312?B?1dS+/L/8?= <bernard@vivo.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re:Re:Re: [PATCH] kmalloc_index optimization(add kmalloc max size
 check)
In-Reply-To: <AIQAfAC4CMyxqzOp-AElwKpD.3.1587437629306.Hmail.bernard@vivo.com>
Message-ID: <alpine.DEB.2.21.2004211556370.5249@www.lameter.com>
References: <AIQAfAC4CMyxqzOp-AElwKpD.3.1587437629306.Hmail.bernard@vivo.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="531401748-1821483078-1587484627=:5249"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--531401748-1821483078-1587484627=:5249
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 21 Apr 2020, 赵军奎 wrote:

> >You could modify that to check for KMALLOC_MAX_SIZE with some more
> >conditionals but then kmalloc_index) is written so that the compiler gets
> >constant folding right.
> For this point, I am afraid i didn`t catch your idea.
> I am not sure how to modify it....
> Is there some similar code implementation in the kernel？

No. That is where you creativity and ingenuity come in. Otherwise you need
to leave it alone.

--531401748-1821483078-1587484627=:5249--
