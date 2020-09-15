Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512EC269E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIOF72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:59:28 -0400
Received: from verein.lst.de ([213.95.11.211]:46411 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgIOF70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:59:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 260E76736F; Tue, 15 Sep 2020 07:59:24 +0200 (CEST)
Date:   Tue, 15 Sep 2020 07:59:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc:     sagi@grimberg.me, minwoo.im.dev@gmail.com, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu
Subject: Re: [PATCH] nvme: tcp: fix kconfig dependency warning when !CRYPTO
Message-ID: <20200915055923.GB18496@lst.de>
References: <20200914150120.449602-1-fazilyildiran@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914150120.449602-1-fazilyildiran@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.9.
