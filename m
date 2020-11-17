Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E622B6BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgKQR0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbgKQR0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:26:45 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB24241A7;
        Tue, 17 Nov 2020 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605634005;
        bh=kEvhJdW8Ltu5g1JuAFR+kuuoTrHM0uOyBgnlePDT1+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWwl4+nYvEnKjTlvit50yZ7P3jW8lc2DUH+X9cf/qTygERRkb11WmGa3E1o8gtsnr
         Q9PQgxWcVKbsRpoTJ8GXMF9DAawkI31w5aa+tqzV0sHj1Q7Tz+5Vo3QDPBLrPI0xzw
         Uf94N/zX1rtFrnJB6XWAr2+DLUwGP58BQ5bPPZ24=
Date:   Tue, 17 Nov 2020 19:26:36 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v41 12/24] x86/sgx: Add SGX_IOC_ENCLAVE_CREATE
Message-ID: <20201117172636.GA8524@kernel.org>
References: <20201115044044.11040-1-hdanton@sina.com>
 <15c3349c-44dd-7057-395c-8fd8c674e87d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15c3349c-44dd-7057-395c-8fd8c674e87d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 09:54:47AM -0800, Dave Hansen wrote:
> Hillf, I noticed that you removed a bunch of folks from cc, including
> me.  Was there a reason for that?  I haven't been seeing your feedback
> on these patches at all.

I used the same script as for previous versions as '--cc-cmd', which
simply outputs a static text file. Zero differences what I've done
previously:

git send-email --envelope-sender=jarkko@kernel.org --cc-cmd
../patches/cc-list.sh --cc linux-kernel@vger.kernel.org --to
x86@kernel.org --to linux-sgx@vger.kernel.org
~/Desktop/sgx-v41-fixed/*.patch 

/Jarkko
