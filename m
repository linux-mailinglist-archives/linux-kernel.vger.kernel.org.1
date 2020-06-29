Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099B220D82C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbgF2Tgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:36:55 -0400
Received: from gentwo.org ([3.19.106.255]:55696 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732976AbgF2Tgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:36:52 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 3FF583F57C; Mon, 29 Jun 2020 14:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 3D0293EA72;
        Mon, 29 Jun 2020 14:49:28 +0000 (UTC)
Date:   Mon, 29 Jun 2020 14:49:28 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Long Li <lonuxli.64@gmail.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm:free unused pages in kmalloc_order
In-Reply-To: <20200629024253.GB25523@casper.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2006291448110.27163@www.lameter.com>
References: <20200627045507.GA57675@lilong> <20200629024253.GB25523@casper.infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020, Matthew Wilcox wrote:

> Slab used to disallow GFP_HIGHMEM allocations earlier than this,

It is still not allowed and not supported.
