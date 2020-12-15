Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC642DB0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbgLOP7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbgLOP7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:59:13 -0500
Date:   Tue, 15 Dec 2020 17:58:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608047912;
        bh=tAjNgpJY4PkAjhuu5UfgtKhkfiF5jynWaqKRdXT8BPE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqa8WmM/tsEzWHx8onwjz99VZnQDaxYwqJnFunMBlxgS5WpP2+tpsX2bgwsmUOfwd
         WhbNHGoY65HC3uoEJA5HqDB5/1AHwMJMoedpy/kvan2xHgHUaBsk5L0YS1lx7UBEMD
         p9wTN0akouI1Tu7V8iIFGe2DJHNfJZGb2FWbYQqcf7kZTjaB9Aciv9aTrTcuO26ViG
         c/pLTvfa99f8WyYtGJFEAPNUkQ1gvH9xO+Flqfk0aZ5Ng/Gt7lTPsL0VgTC+u9NIJN
         68kDrv2svpZv7nyYeuMWSVEWnOT1BbEpiSsBWQfBz7aNQh3GJ4CSfoj3nYn198psc2
         WO8cuX391aaBQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Hui, Chunyang" <sanqian.hcy@antgroup.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v41 00/24] Intel SGX foundations
Message-ID: <20201215155824.GA34260@kernel.org>
References: <20201112220135.165028-1-jarkko@kernel.org>
 <20201215054313.GA522982@sanqian-occlum-dev-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215054313.GA522982@sanqian-occlum-dev-ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 01:43:22PM +0800, Hui, Chunyang wrote:
> Tested-by: Chunyang Hui <sanqian.hcy@antfin.com>
> 
> The Occlum project (https://occlum.io/) is a libOS built on top of Intel
> SGX feature. We ran Occlum tests using v5.10 kernel with SGX patch v41 on
> SGX hardware with the Flexible Launch Control (FLC) feature and didn't
> find any problems. As Occlum core developers, we would like these patches
> to be merged.

The patches and some fixes on top of them were pulled on Monday into
mainline tree. I advice you to test v5.11-rc's when they become
available and report any issues you might encounter.

/Jarkko
