Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D052B45E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgKPOci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgKPOch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:32:37 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0CEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vM/7h47Kl5wZkVrkxxsaLky8zrU7/LZ/bTKFeL7FKag=; b=VR6Vr309RA4U1oiGTFkwa6KjdK
        Rwhqwma0tECiyHhQ/ilN//u8H5EJlFGhsuqFgD7KCeW/xrz0OYRgg9yYpDu1n0WXRLua6mCdL8O8W
        MtWc2hEopQIll+JwxZKSIxHsXkYa5zbrMxcr8oIYQySe3AWAFlkd+qkwG+EJA1TDhFQk98dKU0Kb6
        uIw8YKoddy3pmYHbH3453PshuqIRgVDuniHWui8CTogsCNcwN3bzvTfEjj7WsexaFwFyBNi3htUPG
        /23vA8bkDWzRAErvd04JjL+BZp/vR1L5uCeXSdpX07C7UOQ3HUIbzfNqCA8JN8I4mDDjXdMAiz3uG
        B7TkUJ3A==;
Received: from [2001:4643:10eb:0:200:5e10:0:d] (port=56160)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1kefYY-00036I-Li; Mon, 16 Nov 2020 15:32:34 +0100
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Harald Arnesen <harald@skogtun.org>
Subject: Linux 4.10-rc4 compile error
Message-ID: <b5b1a7c7-02ae-746b-2a6b-819f0a6b2595@skogtun.org>
Date:   Mon, 16 Nov 2020 15:32:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following compile error, which reverting commit
ff828729be446b86957f7c294068758231cd2183 fixes (and the resulting kernel
boots fine).

$ make
...
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  CHK     kernel/kheaders_data.tar.xz
  CC      drivers/iommu/intel/dmar.o
drivers/iommu/intel/dmar.c: In function 'vf_inherit_msi_domain':
drivers/iommu/intel/dmar.c:338:59: error: 'struct pci_dev' has no member
named 'physfn'; did you mean 'is_physfn'?
  338 |  dev_set_msi_domain(&pdev->dev,
dev_get_msi_domain(&pdev->physfn->dev));
      |                                                           ^~~~~~
      |                                                           is_physfn
make[3]: *** [scripts/Makefile.build:283: drivers/iommu/intel/dmar.o]
Error 1
make[2]: *** [scripts/Makefile.build:500: drivers/iommu/intel] Error 2
make[1]: *** [scripts/Makefile.build:500: drivers/iommu] Error 2
make: *** [Makefile:1799: drivers] Error 2

-- 
Hilsen Harald
