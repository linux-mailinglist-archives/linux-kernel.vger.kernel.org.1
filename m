Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BAF1AE1BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgDQP7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 11:59:02 -0400
Received: from gentwo.org ([3.19.106.255]:34904 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgDQP7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:59:01 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id D03D83F9C5; Fri, 17 Apr 2020 15:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id CF7753E91E;
        Fri, 17 Apr 2020 15:59:00 +0000 (UTC)
Date:   Fri, 17 Apr 2020 15:59:00 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Bernard Zhao <bernard@vivo.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH] kmalloc_index optimization(add kmalloc max size check)
In-Reply-To: <1587107376-111722-1-git-send-email-bernard@vivo.com>
Message-ID: <alpine.DEB.2.21.2004171556170.29874@www.lameter.com>
References: <1587107376-111722-1-git-send-email-bernard@vivo.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, Bernard Zhao wrote:

> kmalloc size should never exceed KMALLOC_MAX_SIZE.
> kmalloc_index realise if size is exceed KMALLOC_MAX_SIZE, e.g 64M,
> kmalloc_index just return index 26, but never check with OS`s max
> kmalloc config KMALLOC_MAX_SIZE. This index`s kmalloc caches maybe
> not create in function create_kmalloc_caches.
> We can throw an warninginfo in kmalloc at the beginning, instead of
> being guaranteed by the buddy alloc behind.

kmalloc_index(0 already bugs if the allocation is more than 64M


...

   if (size <=  64 * 1024 * 1024) return 26;
        BUG();


You could modify that to check for KMALLOC_MAX_SIZE with some more
conditionals but then kmalloc_index) is written so that the compiler gets
constant folding right.

If you have a patch like that then please verify that all c compilers in
use perform correct constant folding and do not add unnecessary code.


