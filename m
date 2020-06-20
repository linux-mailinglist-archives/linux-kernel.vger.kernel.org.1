Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E7F202708
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 00:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgFTWdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 18:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgFTWdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 18:33:10 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF1D3246F7;
        Sat, 20 Jun 2020 22:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592692389;
        bh=TvfQjygC9WGPD7pkkWBeDH+T13WEwlmoWJai7nwcEG8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gxxBSXM57gVnyqbD0LhkozLMDYOps0xZuucHGB52bZBRo1I5Pb34BS/ADB4Lp2/At
         d2GnFrzdsIb31VGPzzu0nR95HONeakwNwUWzdPoymx48JkRTPAM+46TEHOBtcaGCBi
         jGOeqAZHgA9T8P4Jr0EGKzNAl08XH9S4pknOJbbM=
Date:   Sat, 20 Jun 2020 15:33:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] rapidio: rio_mport_cdev: Use struct_size() helper
Message-Id: <20200620153309.41833c64eaf50619acb4272e@linux-foundation.org>
In-Reply-To: <20200619170843.GA24923@embeddedor>
References: <20200619170843.GA24923@embeddedor>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 12:08:43 -0500 "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83

Well.  There's only one other Addresses-KSPP-ID: in kernel history and
I'm a bit reluctant to add new signoff tags such as this.  People like
to invent new tags an awful lot.

If for no other reason than that checkpatch doesn't know about them and
has a big whine.

