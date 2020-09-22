Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B3D2744D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIVO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgIVO5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:57:08 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5833B2395C;
        Tue, 22 Sep 2020 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600786627;
        bh=qgNyAecq4oxMx1KaA3J1BnvoQo/FK2H/JbyEW4SN8pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XqU2M5rll9Q9dBJ5G1ByTbvHr6CQvompbhY9rSaF7xg+CDIRBpVaNfGXBfNQIwAC4
         K7X1hf0hdWhByhKaaM+jUqgcfIL4j60YaAm8nojwvUMRjFX9MG6NGRk2c0l2bnzfe8
         cRG5IQHFP1mRdbib5Q1mMRUfgtPs95wH/LP7ClG8=
Date:   Tue, 22 Sep 2020 07:57:05 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
Message-ID: <20200922145705.GA4035426@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200922062517.30031-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922062517.30031-1-tian.xianting@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit subject is a too long. We should really try to keep these to
50 characters or less.

  nvme-pci: fix NULL req in completion handler

Otherwise, looks fine.

Reviewed-by: Keith Busch <kbusch@kernel.org>
