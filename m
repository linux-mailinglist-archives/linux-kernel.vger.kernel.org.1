Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167992F29FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404947AbhALI1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:27:25 -0500
Received: from verein.lst.de ([213.95.11.211]:54371 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbhALI1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:27:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8667867373; Tue, 12 Jan 2021 09:26:41 +0100 (CET)
Date:   Tue, 12 Jan 2021 09:26:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     leonid.ravich@dell.com
Cc:     james.smart@broadcom.com, lravich@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmet-fc: associations list protected by rcu,
 instead of spinlock_irq where possible.
Message-ID: <20210112082641.GA25502@lst.de>
References: <20201224110542.22219-1-leonid.ravich@dell.com> <1609697575-103348-1-git-send-email-leonid.ravich@dell.com> <1609697575-103348-2-git-send-email-leonid.ravich@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609697575-103348-2-git-send-email-leonid.ravich@dell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.11.
