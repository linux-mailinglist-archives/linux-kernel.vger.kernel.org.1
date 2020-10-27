Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5330C29A5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508481AbgJ0H45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:56:57 -0400
Received: from verein.lst.de ([213.95.11.211]:37680 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508473AbgJ0H45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:56:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5B33367373; Tue, 27 Oct 2020 08:56:55 +0100 (CET)
Date:   Tue, 27 Oct 2020 08:56:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Christoph Hellwig <hch@lst.de>,
        Zhang Li <li.zhang@bitmain.com>,
        Ding Z Nan <oshack@hotmail.com>,
        Tomer Tayar <ttayar@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Dotan Barak <dbarak@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] habanalabs: fix kernel pointer type
Message-ID: <20201027075655.GC22487@lst.de>
References: <20201026160825.3706944-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026160825.3706944-1-arnd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks sensible.  Btw, I've wondered for a while if we need a gen_pool
variant that works on kernel pointers.

Acked-by: Christoph Hellwig <hch@lst.de>
