Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2A52B6C10
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgKQRl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:41:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgKQRlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:41:24 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C7221527;
        Tue, 17 Nov 2020 17:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605634884;
        bh=Pcv5CYKjIB50AFheFhxy6f7MR0wV0Ny57fzyRJ9dP1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OL281W5tC7jPkUi0J7S0ZQBRnL992WSRkcGE/zQh6CpZayEfeUXzMeh8nRgyhA6TL
         cV2Sq0uWDTsqewksxIbhs7+KXFQViWePS+4ua/bal/2KZWyRwl9Gw7r2sP/Z40YZZN
         /rdz3wc8iG1xZcSaUKVjIxYhvYfQHgtJ7Bu0U/qo=
Date:   Tue, 17 Nov 2020 19:41:19 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>, akpm@linux-foundation.org
Subject: Re: [PATCH v41 12/24] x86/sgx: Add SGX_IOC_ENCLAVE_CREATE
Message-ID: <20201117174119.GD8524@kernel.org>
References: <20201115044044.11040-1-hdanton@sina.com>
 <20201117024747.216-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117024747.216-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:47:47AM +0800, Hillf Danton wrote:
> On Mon, 16 Nov 2020 09:54:47 -0800 Dave Hansen wrote:
> > 
> > Hillf, I noticed that you removed a bunch of folks from cc, including
> > me.
> 
> I would have not done that if I noted Mr. TLB on the cc list, sigh.
> 
> > Was there a reason for that?
> 
> Mainly for avoiding sina's spam detection otherwise it would take
> another 24 hours to send the same mail out.
> 
> > I haven't been seeing your feedback on these patches at all.
> 
> My mail address may not survive spam scan at vger.kernel.org.

Ah, sorry we were talking about your response :-) I was worried
that I did something wrong when sending the patch set.

/Jarkko
