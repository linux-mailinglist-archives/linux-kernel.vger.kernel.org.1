Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4EE21BC04
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgGJRP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 13:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbgGJRP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:15:57 -0400
Received: from embeddedor (unknown [200.39.25.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2C9D20674;
        Fri, 10 Jul 2020 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594401357;
        bh=8BlM6oYrDWVXFwdkiKVw0CvLzU+HCpGIc+rJuBWYCxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBC59ssUIz4aHv6uokkVYB3PO6+eBcxcrP0+g0UwBhDwXCqNru5WyOjP0Q62C4Oxl
         lSyzkqnvHikOT7xhtOhttveiJ0tzj3HkNXMWNhLMDB+Dmq313C7yuDpD4Tw8hKONYw
         BWZrxO4wBDXLzZLpeHlDOWFNS7HifqqNwwk19fWg=
Date:   Fri, 10 Jul 2020 12:21:31 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use fallthrough pseudo-keyword
Message-ID: <20200710172131.GA21202@embeddedor>
References: <20200708202650.GA3866@embeddedor>
 <DAA2B121-5D77-4611-86BB-BFBE9200DB7C@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAA2B121-5D77-4611-86BB-BFBE9200DB7C@holtmann.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 07:10:55PM +0200, Marcel Holtmann wrote:
> Hi Gustavo,
> 
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > drivers/bluetooth/bcm203x.c     | 2 +-
> > drivers/bluetooth/bluecard_cs.c | 2 --
> > drivers/bluetooth/hci_ll.c      | 2 +-
> > drivers/bluetooth/hci_qca.c     | 8 +-------
> > 4 files changed, 3 insertions(+), 11 deletions(-)
> 
> patch has been applied to bluetooth-next tree.
> 

Thanks, Marcel.

--
Gustavo
