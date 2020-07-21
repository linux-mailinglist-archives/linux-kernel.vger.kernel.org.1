Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A37F2277D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 06:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGUE7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 00:59:33 -0400
Received: from verein.lst.de ([213.95.11.211]:50457 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgGUE7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:59:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF8566736F; Tue, 21 Jul 2020 06:59:31 +0200 (CEST)
Date:   Tue, 21 Jul 2020 06:59:31 +0200
From:   christoph hellwig <hch@lst.de>
To:     Guan Xuetao <gxt@pku.edu.cn>
Cc:     christoph hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicore32: use get_kernel_nofault in dump mem and
 dump_instr
Message-ID: <20200721045931.GA9672@lst.de>
References: <20200720114358.201161-1-hch@lst.de> <1fdc8e7c.4dfcd.1736f21e98b.Coremail.gxt@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fdc8e7c.4dfcd.1736f21e98b.Coremail.gxt@pku.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 10:09:20AM +0800, Guan Xuetao wrote:
> Very good to remove ds/fs in unicore arch.
> Could u send me full patch for test?

This is the full patch for now.  The actual removal will need
more core instrastructure and at least one more merge window.
