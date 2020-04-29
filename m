Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353F01BD49E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 08:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgD2G2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 02:28:44 -0400
Received: from verein.lst.de ([213.95.11.211]:60970 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgD2G2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:28:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3CAC268BEB; Wed, 29 Apr 2020 08:28:42 +0200 (CEST)
Date:   Wed, 29 Apr 2020 08:28:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: oabi-compat: fix epoll_ctl build failure
Message-ID: <20200429062842.GA31478@lst.de>
References: <20200428213747.3663311-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428213747.3663311-1-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:37:30PM +0200, Arnd Bergmann wrote:
> Two functions are not declared or defined when CONFIG_EPOLL is
> disabled:

Can we just compile out the whole syscall handler and use
COND_SYSCALL_COMPAT or so?
