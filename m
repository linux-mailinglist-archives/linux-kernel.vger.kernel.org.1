Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C25227ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 13:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgGUL2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 07:28:03 -0400
Received: from verein.lst.de ([213.95.11.211]:51712 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgGUL2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:28:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 627DC68AFE; Tue, 21 Jul 2020 13:28:00 +0200 (CEST)
Date:   Tue, 21 Jul 2020 13:28:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>
Cc:     Christoph Hellwig <hch@lst.de>, green.hu@gmail.com,
        deanbo422@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nds32: use get_kernel_nofault in dump_mem
Message-ID: <20200721112800.GA27356@lst.de>
References: <20200720114448.205876-1-hch@lst.de> <20200720114448.205876-2-hch@lst.de> <20200721110717.GA19721@atcfdc88>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110717.GA19721@atcfdc88>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you pich the patches up in the nds32 tree for Linus?  There are
not short-term dependencies on them.
