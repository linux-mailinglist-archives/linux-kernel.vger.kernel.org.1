Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE722CA13C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgLALW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:22:58 -0500
Received: from verein.lst.de ([213.95.11.211]:49267 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgLALW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:22:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3DF2B68AFE; Tue,  1 Dec 2020 12:22:16 +0100 (CET)
Date:   Tue, 1 Dec 2020 12:22:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 2/4] configfs: use BIT() for internal flags
Message-ID: <20201201112215.GA31985@lst.de>
References: <20201130164704.22991-1-brgl@bgdev.pl> <20201130164704.22991-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130164704.22991-3-brgl@bgdev.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 05:47:02PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> For better readability and maintenance: use the BIT() macro for flag
> definitions.

This does not improve readability, as I now need to look up a macro,
one that doesn't make any sense at all.  If you really prefer bit based
numbering just use the totally obvious (1 << bit) syntax.
