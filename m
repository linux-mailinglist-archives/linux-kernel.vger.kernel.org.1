Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD8E1E3680
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 05:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgE0D1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 23:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgE0D1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:27:09 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A0B207D8;
        Wed, 27 May 2020 03:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590550029;
        bh=f0tQJ3C9w8njZRPMSk5toxWyDDKhAtvSqcBeGFZA8O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJzHlshrLUwiFNfVqCGdLf0Y71C8PxTR58aO6c8r1ae8KhYNXg/T1zujukMwCUGss
         URuZsH6MJivslMtGq5gx6zFdOasojdFsruwZXA7UVHIpNTmciYw5/xNUpt1Wf7CXh4
         +p6qcFRyqvG1UGqPx3vpYaBdogHBVe27a/bpZXYI=
Date:   Wed, 27 May 2020 12:27:01 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/1] nvme-pci: avoid race between
 nvme_reap_pending_cqes() and nvme_poll()
Message-ID: <20200527032701.GA24861@redsun51.ssa.fujisawa.hgst.com>
References: <20200527004955.19463-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527004955.19463-1-dongli.zhang@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
