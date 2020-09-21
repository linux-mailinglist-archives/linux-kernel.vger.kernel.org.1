Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57021271AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIUGeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:34:17 -0400
Received: from verein.lst.de ([213.95.11.211]:38614 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgIUGeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:34:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4734568AFE; Mon, 21 Sep 2020 08:34:14 +0200 (CEST)
Date:   Mon, 21 Sep 2020 08:34:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: replace meaningless judgement by checking
 whether req is null
Message-ID: <20200921063413.GA18298@lst.de>
References: <20200921021052.10462-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921021052.10462-1-tian.xianting@h3c.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, this looks much more sensible than the previous versions.
