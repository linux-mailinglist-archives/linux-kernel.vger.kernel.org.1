Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5716722E0AE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGZP3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 11:29:09 -0400
Received: from verein.lst.de ([213.95.11.211]:40705 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgGZP3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:29:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5480A68B05; Sun, 26 Jul 2020 17:29:06 +0200 (CEST)
Date:   Sun, 26 Jul 2020 17:29:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        kyounghwan sohn <kyounghwan.sohn@sk.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] nvme/pci: Prevent SK hynix PC400 from using Write
 Zeroes command
Message-ID: <20200726152906.GA23752@lst.de>
References: <20200723155731.22313-1-kai.heng.feng@canonical.com> <20200723172910.28350-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723172910.28350-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.8.
