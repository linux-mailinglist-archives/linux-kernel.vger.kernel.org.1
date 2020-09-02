Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146DF25AECC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 17:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgIBP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 11:27:26 -0400
Received: from verein.lst.de ([213.95.11.211]:32775 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbgIBP0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:26:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 777EE68B05; Wed,  2 Sep 2020 17:25:59 +0200 (CEST)
Date:   Wed, 2 Sep 2020 17:25:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: Re: linux-next: build warning after merge of the dma-mapping tree
Message-ID: <20200902152559.GA2053@lst.de>
References: <20200902100317.142db5be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902100317.142db5be@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Santosh,

I'm trying to understand the code that Jim changed for the range
dma offsets.  Do I miss something or can the whole DMA offset case
for keystone only happen when CONFIG_LPAE is enabled?  Which means
we could ifdef out this section to avoid the warning?
