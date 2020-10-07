Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE213286065
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgJGNou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:44:50 -0400
Received: from verein.lst.de ([213.95.11.211]:37408 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGNot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:44:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1C9E66736F; Wed,  7 Oct 2020 15:44:48 +0200 (CEST)
Date:   Wed, 7 Oct 2020 15:44:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 05/12] samples: configfs: improve alignment of broken
 lines
Message-ID: <20201007134447.GB764@lst.de>
References: <20200924124526.17365-1-brgl@bgdev.pl> <20200924124526.17365-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924124526.17365-6-brgl@bgdev.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 02:45:19PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Improve the coding style by correctly aligning broken lines where
> possible.

NAK, this actually makes the code much worse.  Two-tab indents are
technically superior as they avoid pointlessly long line, and avoid
continuous re-indenting when prototypes change even just slightly.
