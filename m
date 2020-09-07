Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCFF25F402
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 09:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgIGHar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 03:30:47 -0400
Received: from verein.lst.de ([213.95.11.211]:48007 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgIGHaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:30:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C1B1168BFE; Mon,  7 Sep 2020 09:30:44 +0200 (CEST)
Date:   Mon, 7 Sep 2020 09:30:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Christoph Hellwig <hch@lst.de>, arnd@arndb.de,
        gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/zero: also implement ->read
Message-ID: <20200907073044.GE19875@lst.de>
References: <20200903155922.1111551-1-hch@lst.de> <8d430999-b155-dbfa-e7db-f414b48014b1@rasmusvillemoes.dk> <20200907062026.GA19076@lst.de> <4a981ee8-2d57-c7ce-a1ca-43ad237471d2@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a981ee8-2d57-c7ce-a1ca-43ad237471d2@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 08:50:53AM +0200, Rasmus Villemoes wrote:
> 
> Actually, while you're micro-optimizing it, AFAIK VFS already handles
> count==0,

It doesn't.
