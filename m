Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565E9286062
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgJGNn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:43:27 -0400
Received: from verein.lst.de ([213.95.11.211]:37400 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgJGNn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:43:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 363E76736F; Wed,  7 Oct 2020 15:43:24 +0200 (CEST)
Date:   Wed, 7 Oct 2020 15:43:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 02/12] samples: configfs: order includes alphabetically
Message-ID: <20201007134323.GA764@lst.de>
References: <20200924124526.17365-1-brgl@bgdev.pl> <20200924124526.17365-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924124526.17365-3-brgl@bgdev.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 02:45:16PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The preferred coding style is to order all includes alphabetically for
> improved readability. There's no need for the configfs header to come
> last.

Is it?  People seem to have all kinds of weird opinions, but I don't
think any ordering really makes sense.  What does make sense it dropping
the pointless empty line, so I've folded that into the next patch.
