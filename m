Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FD1286069
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgJGNq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:46:57 -0400
Received: from verein.lst.de ([213.95.11.211]:37415 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGNq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:46:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D2C0E6736F; Wed,  7 Oct 2020 15:46:55 +0200 (CEST)
Date:   Wed, 7 Oct 2020 15:46:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 00/12] samples: configfs: refactor the configfs sample
 code
Message-ID: <20201007134655.GD764@lst.de>
References: <20200924124526.17365-1-brgl@bgdev.pl> <CAMRc=Mcwyy7N7xFRv8BcJiGcmhKb8Ed3YYXHOX9C=uxb+VNKNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mcwyy7N7xFRv8BcJiGcmhKb8Ed3YYXHOX9C=uxb+VNKNw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 12:40:00PM +0200, Bartosz Golaszewski wrote:
> Any comments on this? Can this still go into v5.10?

I've applied the ones that seems sensible.
